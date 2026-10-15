table 51911 "MER Staff"
{
    DataClassification = ToBeClassified;
    Caption = 'MER Staff';
    DataPerCompany = true;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'Primary Key';
        }
        field(2; "First Name"; Text[50])
        {
            Caption = 'First Name';
            trigger OnValidate()
            begin
                UpdateFullName();
            end;
        }
        field(3; "Last Name"; Text[50])
        {
            Caption = 'Last Name';
            trigger OnValidate()
            begin
                UpdateFullName();
            end;
        }
        field(4; "Name"; Text[100])
        {
            Caption = 'Staff Name';
            Editable = false;
        }
        field(5; "E-mail"; Text[80])
        {
            Caption = 'Staff Email';
            ExtendedDatatype = EMail;

            trigger OnValidate()
            begin
                ValidateEmail();
            end;
        }
        field(6; "Phone No."; Text[30])
        {
            Caption = 'Staff Phone Number';
            ExtendedDatatype = PhoneNo;
        }
        field(7; "Birth Date"; Date)
        {
            Caption = 'Birth Date';
        }
        field(8; "Manager No."; Code[20])
        {
            Caption = 'Manager Number';
            TableRelation = "MER Staff"."No.";
            trigger OnValidate()
            begin
                if "Manager No." = Rec."No." then Error('A staff member cannot be their own manager.');
            end;
        }
        field(9; "User ID"; Code[50])
        {
            Caption = 'User ID';
            TableRelation = "User"."User Name";
        }
        field(10; "Blocked"; Boolean)
        {
            Caption = 'Blocked';
            InitValue = false;
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

    local procedure ValidateEmail()
    var
        MailManagement: Codeunit "Mail Management";
    begin
        if "E-mail" = '' then
            exit;

        MailManagement.CheckValidEmailAddress("E-mail");
    end;

    local procedure UpdateFullName()
    begin
        Rec.Name := DelChr(Rec."First Name" + ' ' + Rec."Last Name", '<>', ' ');
    end;

    trigger OnInsert()
    var
        MERSetup: Record "MER Setup";
        NoSeries: Codeunit "No. Series";
    begin
        if Rec."No." = '' then begin
            MERSetup.Get();
            MERSetup.TestField("Staff No.");
            Rec."No." := NoSeries.GetNextNo("MERSetup"."Staff No.", WorkDate(), true)
        end;
    end;
}