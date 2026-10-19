page 51899 "MER Expense"
{
    ApplicationArea = All;
    Caption = 'MER Expense Card';
    PageType = Card;
    SourceTable = "MER Expense Header";
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = IsOpen;

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
                field(Amount; Rec."Total Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the amount of the expense.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the approval status of the expense.';

                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies the code for Shortcut Dimension 1.';
                    visible = false;
                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies the code for Shortcut Dimension.';
                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
            }
            group(Posting)
            {
                Caption = 'Posting';

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
                // field("No. Series"; Rec."No. Series")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the number series used for this expense.';
                // }
            }

            part(MERExpenseLine; "MER Expense Subform")
            {
                ApplicationArea = All;
                UpdatePropagation = Both;
                SubPageLink = "Document No." = field("No.");
                Editable = Rec."No." <> '';
            }
        }

    }

    actions
    {
        area(Processing)
        {
            action(Submit)
            {
                ApplicationArea = Basic, Suit;
                Promoted = true;
                PromotedCategory = Process;
                Image = SendApprovalRequest;
                Visible = isOpen;

                trigger OnAction()
                begin
                    SubmitForApproval();
                end;
            }

            action("Re-Open")
            {
                ApplicationArea = Basic, Suit;
                Promoted = true;
                PromotedCategory = Process;
                Image = ReOpen;
                Visible = IsPending or IsCancelled;

                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    Rec.Status := Rec."Status"::Open;
                    Rec.Modify();
                    CurrPage.Update();
                end;
            }
            action(Approve)
            {
                ApplicationArea = Basic, Suit;
                Promoted = true;
                PromotedCategory = Process;
                Image = Approve;
                Visible = Rec.Status = Rec.Status::"Pending Approval";

                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    Rec.Status := Rec."Status"::Approved;
                    Rec.Modify();
                    CurrPage.Update();
                end;
            }
            action(Cancel)
            {
                ApplicationArea = Basic, Suit;
                Promoted = true;
                PromotedCategory = Process;
                Image = Cancel;
                Visible = IsApproved;

                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    Rec.Status := Rec."Status"::Cancelled;
                    Rec.Modify();
                    CurrPage.Update();
                end;
            }
            action(Reject)
            {
                ApplicationArea = Basic, Suit;
                Promoted = true;
                PromotedCategory = Process;
                Image = Reject;
                Visible = IsPending;


                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    Rec.Status := Rec."Status"::Rejected;
                    Rec.Modify();
                    CurrPage.Close();
                end;
            }

            action(Dimensions)
            {
                ApplicationArea = Dimensions;
                Caption = 'Dimensions';
                Image = Dimensions;
                ShortcutKey = 'Shift+Ctrl+D';
                ToolTip = 'View or edit dimensions for this expense.';

                trigger OnAction()
                begin
                    Rec.ShowDimensions();
                    CurrPage.SaveRecord();
                    CurrPage.Update(false);
                end;
            }
        }
    }


    trigger OnAfterGetRecord()
    begin
        SetPageCtrls();
    end;

    trigger OnInit()
    begin
        SetPageCtrls();
    end;

    trigger OnOpenPage()
    begin
        SetPageCtrls();
    end;


    local procedure SetPageCtrls()
    begin
        IsOpen := Rec.Status = Rec.Status::Open;
        CurrPage.Editable(IsOpen);
        IsPending := Rec.Status = Rec.Status::"Pending Approval";
        IsApproved := Rec.Status = Rec.Status::Approved;
        IsCancelled := Rec.Status = Rec.Status::Cancelled;
    end;

    local procedure SubmitForApproval()
    begin
        if Rec.Status <> Rec.Status::Open then
            Error('Only Open expenses can be opened for approval');

        Rec.TestField("Expense Date");
        Rec.TestField("Staff No.");
        Rec.CalcFields("Total Amount");
        if Rec."Total Amount" <= 0 then
            Error('An expense must have at least one line with an amount greater than zero before it can be submitted for approval.');

        Rec.Status := Rec.Status::"Pending Approval";
        Rec.Modify(true);
        CurrPage.Update();
    end;

    var
        IsOpen, IsPending, IsApproved, IsCancelled, IsRejected : Boolean;

}