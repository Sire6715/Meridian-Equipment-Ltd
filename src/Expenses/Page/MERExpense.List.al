page 51903 "MER Expense List"
{
    PageType = List;
    Caption = 'MER Expense List';
    SourceTable = "MER Expense Header";
    ApplicationArea = All;
    UsageCategory = Administration;
    CardPageId = "MER Expense";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
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
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a description of the expense.';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Caption = 'Project';
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies the code for Shortcut Dimension.';
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total amount of the expense lines.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the approval status of the expense.';
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the expense has been posted.';
                }
            }
        }
    }
}
