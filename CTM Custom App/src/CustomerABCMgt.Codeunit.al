codeunit 50003 "CTM Customer ABC Mgt."
{
    procedure RunAnalysis()
    var
        TempCustomerABCBuffer: Record "CTM Customer ABC Buffer" temporary;
    begin
        LoadCustomers(TempCustomerABCBuffer);
        ClassifyBuffer(TempCustomerABCBuffer);
        ApplyBuffer(TempCustomerABCBuffer);
    end;

    procedure ClassifyBuffer(var TempCustomerABCBuffer: Record "CTM Customer ABC Buffer" temporary)
    var
        CumulativeSalesLCY: Decimal;
        TotalSalesLCY: Decimal;
    begin
        ClearBufferClasses(TempCustomerABCBuffer);
        TotalSalesLCY := GetTotalSales(TempCustomerABCBuffer);
        if TotalSalesLCY <= 0 then
            exit;

        TempCustomerABCBuffer.Reset();
        TempCustomerABCBuffer.SetCurrentKey("Sales (LCY)", "Entry No.");
        TempCustomerABCBuffer.Ascending(false);
        if TempCustomerABCBuffer.FindSet() then
            repeat
                if TempCustomerABCBuffer."Sales (LCY)" > 0 then begin
                    CumulativeSalesLCY += TempCustomerABCBuffer."Sales (LCY)";
                    TempCustomerABCBuffer."ABC Class" := GetABCClass(CumulativeSalesLCY / TotalSalesLCY);
                    TempCustomerABCBuffer.Modify();
                end;
            until TempCustomerABCBuffer.Next() = 0;
    end;

    local procedure ApplyBuffer(var TempCustomerABCBuffer: Record "CTM Customer ABC Buffer" temporary)
    var
        Customer: Record Customer;
    begin
        TempCustomerABCBuffer.Reset();
        if TempCustomerABCBuffer.FindSet() then
            repeat
                if Customer.Get(TempCustomerABCBuffer."Customer No.") then
                    if Customer."CTM ABC Class" <> TempCustomerABCBuffer."ABC Class" then begin
                        Customer."CTM ABC Class" := TempCustomerABCBuffer."ABC Class";
                        Customer.Modify();
                    end;
            until TempCustomerABCBuffer.Next() = 0;
    end;

    local procedure ClearBufferClasses(var TempCustomerABCBuffer: Record "CTM Customer ABC Buffer" temporary)
    begin
        TempCustomerABCBuffer.Reset();
        if TempCustomerABCBuffer.FindSet() then
            repeat
                if TempCustomerABCBuffer."ABC Class" <> TempCustomerABCBuffer."ABC Class"::Blank then begin
                    TempCustomerABCBuffer."ABC Class" := TempCustomerABCBuffer."ABC Class"::Blank;
                    TempCustomerABCBuffer.Modify();
                end;
            until TempCustomerABCBuffer.Next() = 0;
    end;

    local procedure ClearCustomerClass(var Customer: Record Customer)
    begin
        if Customer."CTM ABC Class" <> Customer."CTM ABC Class"::Blank then begin
            Customer."CTM ABC Class" := Customer."CTM ABC Class"::Blank;
            Customer.Modify();
        end;
    end;

    local procedure GetABCClass(CumulativeShare: Decimal): Enum "CTM ABC Class"
    begin
        if CumulativeShare <= 0.5 then
            exit(Enum::"CTM ABC Class"::A);
        if CumulativeShare <= 0.8 then
            exit(Enum::"CTM ABC Class"::B);

        exit(Enum::"CTM ABC Class"::C);
    end;

    local procedure GetTotalSales(var TempCustomerABCBuffer: Record "CTM Customer ABC Buffer" temporary): Decimal
    var
        TotalSalesLCY: Decimal;
    begin
        TempCustomerABCBuffer.Reset();
        if TempCustomerABCBuffer.FindSet() then
            repeat
                if TempCustomerABCBuffer."Sales (LCY)" > 0 then
                    TotalSalesLCY += TempCustomerABCBuffer."Sales (LCY)";
            until TempCustomerABCBuffer.Next() = 0;

        exit(TotalSalesLCY);
    end;

    local procedure LoadCustomers(var TempCustomerABCBuffer: Record "CTM Customer ABC Buffer" temporary)
    var
        Customer: Record Customer;
        EntryNo: Integer;
    begin
        if Customer.FindSet() then
            repeat
                Customer.CalcFields("Sales (LCY)");
                if Customer."Sales (LCY)" > 0 then begin
                    EntryNo += 1;
                    TempCustomerABCBuffer.Init();
                    TempCustomerABCBuffer."Entry No." := EntryNo;
                    TempCustomerABCBuffer."Customer No." := Customer."No.";
                    TempCustomerABCBuffer."Sales (LCY)" := Customer."Sales (LCY)";
                    TempCustomerABCBuffer.Insert();
                end else
                    ClearCustomerClass(Customer);
            until Customer.Next() = 0;
    end;
}
