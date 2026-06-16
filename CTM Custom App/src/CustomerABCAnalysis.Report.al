report 50004 "CTM Customer ABC Analysis"
{
    ApplicationArea = All;
    Caption = 'Customer ABC Analysis';
    ProcessingOnly = true;
    UseRequestPage = false;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Integer; Integer)
        {
            DataItemTableView = sorting(Number) where(Number = const(1));

            trigger OnAfterGetRecord()
            var
                CustomerABCMgt: Codeunit "CTM Customer ABC Mgt.";
            begin
                CustomerABCMgt.RunAnalysis();
            end;
        }
    }
}
