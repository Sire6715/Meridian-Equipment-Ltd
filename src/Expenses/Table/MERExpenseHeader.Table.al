table 51900 "MER Expense Header"
{
    Caption = 'MER Expense Header';
    DataClassification = ToBeClassified;


    // Becomes the header. Keep No., Staff No., Expense Date,
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
        field(5; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(6; "Total Amount"; Decimal)
        {
            Caption = 'Amount';
            FieldClass = FlowField;
            CalcFormula = sum("MER Expense Line"."Line Amount" where("Document No." = FIELD("No.")));
            Editable = false;
        }
        field(7; Status; Enum "MER Approval Status")
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            Editable = false;
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
        field(12; "Shortcut Dimension 1 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 1 Code';
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1), Blocked = const(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(13; "Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 2 Code';
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2), Blocked = const(false));
            

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(14; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ShowDimensions();
            end;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    var
        DimMgt: Codeunit DimensionManagement;

    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortCutDimCode: Code[20])
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" := DimMgt.EditDimensionSet(
            "Dimension Set ID",
            StrSubstNo('%1 %3', TableCaption(), "No."));
        DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");

        if OldDimSetID <> "Dimension Set ID" then
            if LinesExist() then begin
                Modify();
                UpdateAllLineDim("Dimension Set ID", OldDimSetID);
            end;
    end;

    local procedure LinesExist(): Boolean
    var
        ExpenseLine: Record "MER Expense Line";
    begin
        ExpenseLine.SetRange("Document No.", "No.");
        exit(not ExpenseLine.IsEmpty());
    end;

    local procedure UpdateAllLineDim(NewParentDimSetID: Integer; OldParentDimSetID: Integer)
    var
        ExpenseLine: Record "MER Expense Line";
        NewDimSetID: Integer;
    begin
        if NewParentDimSetID = OldParentDimSetID then
            exit;

        if GuiAllowed() then
            if not Confirm('You have changed the dimensions on the header. Do you want to update the lines?') then
                exit;

        ExpenseLine.SetRange("Document No.", "No.");
        ExpenseLine.LockTable();
        if ExpenseLine.FindSet() then
            repeat
                NewDimSetID :=
                    DimMgt.GetDeltaDimSetID(
                        ExpenseLine."Dimension Set ID", NewParentDimSetID, OldParentDimSetID);
                if ExpenseLine."Dimension Set ID" <> NewDimSetID then begin
                    ExpenseLine."Dimension Set ID" := NewDimSetID;
                    DimMgt.UpdateGlobalDimFromDimSetID(
                        NewDimSetID,
                        ExpenseLine."Shortcut Dimension 1 Code",
                        ExpenseLine."Shortcut Dimension 2 Code");
                    ExpenseLine.Modify();
                end;
            until ExpenseLine.Next() = 0;
    end;

    trigger OnInsert()
    var
        MERSetup: Record "MER Setup";
        NoSeries: Codeunit "No. Series";
    begin

        if Rec."No." = '' then begin
            MERSetup.Get();
            MERSetup.TestField("Expense No.");
            Rec."No. Series" := MERSetup."Expense No.";
            Rec."No." := NoSeries.GetNextNo(Rec."No. Series", WorkDate(), true);
        end;
    end;


    procedure ShowDimensions()
    begin
        "Dimension Set ID" :=
            DimMgt.EditDimensionSet(
                "Dimension Set ID",
                StrSubstNo('%1 %2', TableCaption(), "No."));
        DimMgt.UpdateGlobalDimFromDimSetID(
            "Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
    end;

    trigger OnDelete()
    var
        ExpenseLine: Record "MER Expense Line";
    begin
        ExpenseLine.SetRange("Document No.", "No.");
        ExpenseLine.DeleteAll(true);
    end;
}