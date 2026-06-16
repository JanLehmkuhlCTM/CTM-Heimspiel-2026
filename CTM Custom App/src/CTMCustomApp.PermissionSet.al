permissionset 50000 "CTM Custom App - All"
{
    Assignable = true;
    Caption = 'CTM Custom App - All';

    Permissions = tabledata "CTM Customer ABC Buffer" = RIMD;
}
