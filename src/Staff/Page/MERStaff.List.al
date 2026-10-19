page 51902 "MER Staff List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "MER Staff";
    CardPageId = "MER Staff Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Staff No.';
                    Editable = false;
                    ToolTip = 'Specifies the unique number for this staff member.';
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                    Caption = 'First Name';
                    ToolTip = 'Specifies the first name of the staff member.';
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                    Caption = 'Last Name';
                    ToolTip = 'Specifies the last name of the staff member.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    Caption = 'Name';
                    ToolTip = 'Displays the full name of the staff member.';
                }
                field("E-mail"; Rec."E-mail")
                {
                    ApplicationArea = All;
                    Caption = 'E-mail';
                    ToolTip = 'Specifies the e-mail address of the staff member.';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                    Caption = 'Phone No.';
                    ToolTip = 'Specifies the phone number of the staff member.';
                }
                field("Birth Date"; Rec."Birth Date")
                {
                    ApplicationArea = All;
                    Caption = 'Birth Date';
                    ToolTip = 'Specifies the birth date of the staff member.';
                }
                field("Manager No."; Rec."Manager No.")
                {
                    ApplicationArea = All;
                    Caption = 'Manager No.';
                    ToolTip = 'Specifies the manager assigned to this staff member.';
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    Caption = 'User ID';
                    ToolTip = 'Specifies the user linked to this staff member.';
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                    Caption = 'Blocked';
                    ToolTip = 'Specifies whether this staff member is blocked.';
                }
            }
        }
    }
}