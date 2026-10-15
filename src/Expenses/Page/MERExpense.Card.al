page 51899 "MER Expense Card"
{
    ApplicationArea = All;
    Caption = 'MER Expense Card';
    PageType = Card;
    SourceTable = "MER Expense Table";

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
                    Caption = 'Expense No.';
                    ToolTip = 'Specifies the unique number for this expense.';
                }
                field("Staff No."; Rec."Staff No.")
                {
                    ApplicationArea = All;
                    Caption = 'Staff No.';
                    ToolTip = 'Specifies the staff member who incurred this expense.';
                }
                field("Expense Date"; Rec."Expense Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date the expense was incurred.';
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the category of the expense.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a description of the expense.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the amount of the expense.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = Rec.Status <> Rec.Status::"Pending Approval";
                    ToolTip = 'Specifies the approval status of the expense.';
                    
                }
            }
            group(Posting)
            {
                Caption = 'Posting';

                field("Expense G/L Account No."; Rec."Expense G/L Account No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the general ledger account for the expense.';
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the expense has been posted.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    Caption = 'Posting Date';
                    ToolTip = 'Specifies the posting date of the expense.';
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number series used for this expense.';
                }
            }
        }
    }
}