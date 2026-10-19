page 51901 "MER Expense Subform"
{
    PageType = ListPart;
    ApplicationArea = All;
    Caption = 'MER Expense Line';
    SourceTable = "MER Expense Line";
    AutoSplitKey = true;
    DelayedInsert = true;


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the line number within this expense.';
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the category of the expense line.';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies the code for Shortcut Dimension 1.';
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies the code for Shortcut Dimension.';
                }

                field("Expense G/L Account No."; Rec."Expense G/L Account No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the general ledger account for this expense line.';
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the amount of this expense line.';
                }
            }
        }
    }
}