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
            DataClassification = EndUserIdentifiableInformation;
        }
        field(7; "Birth Date"; Date)
        {
            Caption = 'Birth Date';
            DataClassification = EndUserIdentifiableInformation;
        }
        field(8; "Manager No."; Code[20])
        {
            Caption = 'Manager Number';
            TableRelation = "MER Staff"."No.";
            trigger OnValidate()
            begin
                ValidateManagerNo();
            end;
        }
        field(9; "User ID"; Code[50])
        {
            Caption = 'User ID';
            TableRelation = User."User Name";
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

    local procedure ValidateManagerNo()
    var
        Manager: Record "MER Staff";
        ManagerNo: Code[20];
        VisitedManagerNos: List of [Code[20]];
    begin
        ManagerNo := "Manager No.";
        while ManagerNo <> '' do begin
            if ManagerNo = "No." then
                Error('A staff member cannot be their own manager, either directly or through the manager hierarchy.');

            if VisitedManagerNos.Contains(ManagerNo) then
                Error('The manager hierarchy contains a circular reference.');

            VisitedManagerNos.Add(ManagerNo);
            if not Manager.Get(ManagerNo) then
                exit;

            ManagerNo := Manager."Manager No.";
        end;
    end;

    local procedure GetNextApprover(): Code[20]
    var
        Manager: Record "MER Staff";
        ManagerNo: Code[20];
        VisitedManagerNos: List of [Code[20]];
    begin
        ManagerNo := "Manager No.";
        While ManagerNo <> '' do begin

            if ManagerNo = "No." then
                Error('A staff member cannot be their own manager, either directly or through the manager hierarchy.');

            if VisitedManagerNos.Contains(ManagerNo) then
                Error('The manager hierarchy contains a circular reference.');

            VisitedManagerNos.Add(ManagerNo);

            if not Manager.Get(ManagerNo) then
                exit('');

            if not Manager.Blocked then
                exit(ManagerNo);

            ManagerNo := Manager."Manager No.";
        end;
    end;

    trigger OnInsert()
    var
        MERSetup: Record "MER Setup";
        NoSeries: Codeunit "No. Series";
    begin
        if Rec."No." = '' then begin
            MERSetup.Get();
            MERSetup.TestField("Staff No.");
            Rec."No." := "MERSetup"."Staff No.";
            Rec."No." := NoSeries.GetNextNo(Rec."No.", WorkDate(), true)
        end;
    end;
}