page 51900 "MER Staff Card"
{
    ApplicationArea = All;
    Caption = 'MER Staff Card';
    PageType = Card;
    SourceTable = "MER Staff";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

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
                    Editable = false;
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
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = All;
                    Caption = 'No. Series';
                    ToolTip = 'Specifies the number series used for this staff member.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(SendMessage)
            {
                Caption = 'Send Message';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Send a message to Staff.';

                trigger OnAction()
                var
                // Message: Codeunit "Email Message";
                // Email: CodeUnit Email;
                begin
                    // Message.Create(Rec."E-mail", StrSubstNo('Hello %1', Rec.Name), 'How''re you doing today?');
                    // Email.Send(Message);
                    Message(StrSubstNo('Hello %1', Rec.Name));
                end;
            }
        }
    }
}
