table 51900 "MER Expense Table"
{
    Caption = 'MER Expense Table';
    DataClassification = ToBeClassified;

    fields

    {
        field(1; "No."; Code[20])
        {
            Caption = 'Primary Key';
            DataClassification = ToBeClassified;
        }
        field(2; "Staff No."; Code[20])
        {
            Caption = 'Staff Number';
            TableRelation = "MER Staff"."No.";
            NotBlank = true;
            DataClassification = ToBeClassified;
        }
        field(3; "Expense Date"; Date)
        {
            Caption = 'Expense Date';
            NotBlank = true;
            DataClassification = ToBeClassified;
        }
        field(4; "Category"; Enum "MER Expense Category")
        {
            Caption = 'Category Expense';
            DataClassification = ToBeClassified;
        }
        field(5; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(6; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = ToBeClassified;
            MinValue = 0.01;

            trigger OnValidate()
            begin
                if Amount <= 0.01 then
                    Error('Amount cannot be less than Zero(0)');
            end;
        }
        field(7; Status; Enum "MER Approval Status")
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; "Expense G/L Account No."; Code[20])
        {
            Caption = ' Expense G/L Account No.';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
        field(9; Posted; Boolean)
        {
            Caption = 'Posted';
            DataClassification = ToBeClassified;
        }
        field(10; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = ToBeClassified;
        }
        field(11; "No. Series"; Code[20])
        {
            Caption = 'Number series';
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        MERSetup: Record "MER Setup";
        NoSeries: Codeunit "No. Series";
    begin

        if Rec."No." = '' then begin
            MERSetup.Get();
            MERSetup.TestField("Expense No.");
            Rec."No." := NoSeries.GetNextNo("MERSetup"."Expense No.", WorkDate(), true)
        end;
    end;

    local procedure SubmitForApproval()
    begin
        if Status <> Status::Open then
            Error('Only Open expenses can be opened for approval');

        TestField("Expense Date");
        TestField("Staff No.");
        TestField(Amount);

        Status := status::"Pending Approval";
        Modify(true);
    end;
}