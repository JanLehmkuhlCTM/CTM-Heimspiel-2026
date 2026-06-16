tableextension 50001 "CTM Customer ABC" extends Customer
{
    fields
    {
        field(50000; "CTM ABC Class"; Enum "CTM ABC Class")
        {
            Caption = 'ABC Class';
            DataClassification = CustomerContent;
            Editable = false;
            ToolTip = 'Specifies the ABC class assigned from the customer sales analysis.';
        }
    }
}
