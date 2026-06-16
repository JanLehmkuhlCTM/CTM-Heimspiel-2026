pageextension 50005 "CTM Customer List ABC" extends "Customer List"
{
    layout
    {
        addlast(Control1)
        {
            field("CTM ABC Class"; Rec."CTM ABC Class")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the ABC class assigned from the customer sales analysis.';
            }
        }
    }

    actions
    {
        addlast(Processing)
        {
            action("CTM Run ABC Analysis")
            {
                ApplicationArea = All;
                Caption = 'Run ABC Analysis';
                Image = Calculate;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = report "CTM Customer ABC Analysis";
                ToolTip = 'Calculate the ABC class for all customers based on sales.';
            }
        }
    }
}
