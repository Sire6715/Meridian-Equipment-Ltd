table 51902 "MER Expense Line"
{
    DataClassification = CustomerContent;


    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = SystemMetadata;
            TableRelation = "MER Expense Header"."No.";
        }

        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            Description = 'Line No.';
            DataClassification = SystemMetadata;
        }
        field(4; "Category"; Enum "MER Expense Category")
        {
            Caption = 'Category Expense';
            DataClassification = ToBeClassified;
        }

        field(3; "Expense G/L Account No."; Code[20])
        {
            Caption = ' Expense G/L Account No.';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No." where("Account Type" = const(Posting), Blocked = const(false));
        }
        field(6; "Line Amount"; Decimal)
        {
            Caption = 'Amount';
            DataClassification = ToBeClassified;
            MinValue = 0.01;
        }
        field(7; "Shortcut Dimension 1 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension Code 1';
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1), Blocked = const(false));
            trigger OnValidate()
            begin
                DimMgt.ValidateShortcutDimValues(1, "Shortcut Dimension 1 Code", "Dimension Set ID");
            end;
        }
        field(8; "Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = 'Project';
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2), Blocked = const(false));
            trigger OnValidate()
            begin
                DimMgt.ValidateShortcutDimValues(2, "Shortcut Dimension 2 Code", "Dimension Set ID");
            end;
        }

        field(9; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ShowDimensions()
            end;
        }
    }
    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
            SumIndexFields = "Line Amount";
        }
    }


    trigger OnInsert()
    var
        ExpenseHeader: Record "MER Expense Header";
    begin
        if "Dimension Set ID" <> 0 then
            exit; // line already has its own dimensions

        if ExpenseHeader.Get("Document No.") then begin
            "Dimension Set ID" := ExpenseHeader."Dimension Set ID";
            "Shortcut Dimension 1 Code" := ExpenseHeader."Shortcut Dimension 1 Code";
            "Shortcut Dimension 2 Code" := ExpenseHeader."Shortcut Dimension 2 Code";
        end;
    end;

    var
        DimMgt: Codeunit DimensionManagement;

    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortCutDimCode: Code[20])
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortCutDimCode, "Dimension Set ID");
    end;

    procedure ShowDimensions()
    begin
        "Dimension Set ID" :=
            DimMgt.EditDimensionSet(
                "Dimension Set ID",
                StrSubstNo('%1 %2 %3', TableCaption(), "Document No.", "Line No."));
        DimMgt.UpdateGlobalDimFromDimSetID(
            "Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
    end;
}
