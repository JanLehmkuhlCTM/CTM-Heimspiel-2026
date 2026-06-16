pageextension 50006 "CTM Customer Card ABC" extends "Customer Card"
{
    layout
    {
        addlast(General)
        {
            field("CTM ABC Class"; Rec."CTM ABC Class")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the ABC class assigned from the customer sales analysis.';
            }
        }
    }
}
