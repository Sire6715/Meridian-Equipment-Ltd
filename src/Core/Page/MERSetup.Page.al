page 51909 "MER Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "MER Setup";
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("Approval Enabled"; Rec."Approval Enabled")
                {
                    Caption = 'Approval Enabled';
                    ToolTip = 'Turns the Approval Engine On or Off';
                    ApplicationArea = All;
                }
                field("Expense Approval Threshold"; Rec."Expense Approval Threshold")
                {
                    Caption = 'Expense Approval Threshold';
                    ToolTip = 'Default 10,000';
                    ApplicationArea = All;
                }
                field("Credit Breach Tolerance %"; Rec."Credit Breach Tolerance %")
                {
                    Caption = 'Credit Breach Tolerance %';
                    ToolTip = 'Expense Above this Triggers approval';
                    ApplicationArea = All;
                }
                field("Warranty Notice Days"; Rec."Warranty Notice Days")
                {
                    Caption = 'Warranty Notice Days';
                    ToolTip = 'Days before expiry to notify';
                    ApplicationArea = All;
                }
                field("Birthday Lookahead Days"; Rec."Birthday Lookahead Days")
                {
                    Caption = 'Birthday Lookahead Days';
                    ApplicationArea = All;
                }
            }

            group("Number Series")
            {
                Caption = 'Number Series';
                field("Staff No."; Rec."Staff No.")
                {
                    Caption = 'Staff Numbers';
                    ToolTip = 'Specifies the number series for Staffs.';

                }
                field("Expense No."; Rec."Expense No.")
                {
                    Caption = 'Expense Numbers';
                    ToolTip = 'Specifies the number series for Expenses.';
                }
                field("Ticket No."; Rec."Ticket No.")
                {
                    Caption = 'Ticket Numbers';
                    ToolTip = 'Specifies the number series for Tickets';
                }
                field("Warranty No."; Rec."Warranty No.")
                {
                    Caption = 'Warranty Numbers';
                    ToolTip = 'Specifies the number series for Warranties.';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        if not Rec.Get() then begin
            Rec.Init();
            Rec."Primary Key" := '';
            Rec.Insert();
        end;
    end;
}