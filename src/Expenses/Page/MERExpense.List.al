page 51901 "MER Expense List"
{
    ApplicationArea = All;
    Caption = 'MER Expense List';
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "MER Expense Table";

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
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the expense has been posted.';
                }
            }
        }
    }
}