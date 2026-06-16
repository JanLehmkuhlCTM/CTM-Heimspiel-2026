codeunit 98000 "CTM Customer ABC Tests"
{
    Subtype = Test;
    TestPermissions = Disabled;

    var
        Assert: Codeunit "Library Assert";
        CustomerABCMgt: Codeunit "CTM Customer ABC Mgt.";

    [Test]
    procedure AssignsABCClassesForParetoThresholds()
    var
        TempCustomerABCBuffer: Record "CTM Customer ABC Buffer" temporary;
    begin
        AddBufferEntry(TempCustomerABCBuffer, 1, '10000', 50);
        AddBufferEntry(TempCustomerABCBuffer, 2, '20000', 30);
        AddBufferEntry(TempCustomerABCBuffer, 3, '30000', 20);

        CustomerABCMgt.ClassifyBuffer(TempCustomerABCBuffer);

        AssertABCClass(TempCustomerABCBuffer, '10000', Enum::"CTM ABC Class"::A);
        AssertABCClass(TempCustomerABCBuffer, '20000', Enum::"CTM ABC Class"::B);
        AssertABCClass(TempCustomerABCBuffer, '30000', Enum::"CTM ABC Class"::C);
    end;

    [Test]
    procedure LeavesZeroSalesWithoutClass()
    var
        TempCustomerABCBuffer: Record "CTM Customer ABC Buffer" temporary;
    begin
        AddBufferEntry(TempCustomerABCBuffer, 1, '10000', 70);
        AddBufferEntry(TempCustomerABCBuffer, 2, '20000', 30);
        AddBufferEntry(TempCustomerABCBuffer, 3, '30000', 0);

        CustomerABCMgt.ClassifyBuffer(TempCustomerABCBuffer);

        AssertABCClass(TempCustomerABCBuffer, '30000', Enum::"CTM ABC Class"::Blank);
    end;

    local procedure AddBufferEntry(var TempCustomerABCBuffer: Record "CTM Customer ABC Buffer" temporary; EntryNo: Integer; CustomerNo: Code[20]; SalesLCY: Decimal)
    begin
        TempCustomerABCBuffer.Init();
        TempCustomerABCBuffer."Entry No." := EntryNo;
        TempCustomerABCBuffer."Customer No." := CustomerNo;
        TempCustomerABCBuffer."Sales (LCY)" := SalesLCY;
        TempCustomerABCBuffer.Insert();
    end;

    local procedure AssertABCClass(var TempCustomerABCBuffer: Record "CTM Customer ABC Buffer" temporary; CustomerNo: Code[20]; ExpectedABCClass: Enum "CTM ABC Class")
    begin
        TempCustomerABCBuffer.Reset();
        TempCustomerABCBuffer.SetRange("Customer No.", CustomerNo);
        Assert.IsTrue(TempCustomerABCBuffer.FindFirst(), StrSubstNo('Customer %1 should exist in the ABC buffer.', CustomerNo));
        Assert.AreEqual(Format(ExpectedABCClass), Format(TempCustomerABCBuffer."ABC Class"), StrSubstNo('Customer %1 should have the expected ABC class.', CustomerNo));
    end;
}
