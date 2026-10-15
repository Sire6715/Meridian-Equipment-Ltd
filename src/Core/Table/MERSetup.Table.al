table 51910 "MER Setup"
{
    DataClassification = CustomerContent;
    Caption = 'MER Setup';
    DataPerCompany = true;


    fields
    {
        field(1; "Primary Key"; code[10])
        {
            Caption = 'Primary Key';

        }
        field(2; "Approval Enabled"; Boolean)
        {
            Caption = 'Approval Enabled';
            Description = 'Turns the Approval Engine On or Off';

        }
        field(3; "Expense Approval Threshold"; Decimal)
        {
            Caption = 'Expense Approval Threshold';
            InitValue = 10000;

        }
        field(4; "Credit Breach Tolerance %"; Decimal)
        {
            Caption = 'Credit Breach Tolerance %';
            Description = 'Expense Above this Triggers approval';
        }
        field(5; "Warranty Notice Days"; Integer)
        {
            Caption = 'Warranty Notice Days';
            Description = 'Days before expiry to notify';
        }
        field(6; "Birthday Lookahead Days"; Integer)
        {
            Caption = 'Birthday Lookahead Days';
            InitValue = 7;
        }
        field(7; "Staff No."; Code[20])
        {
            Caption = 'Staff Numbers';
            TableRelation = "No. Series";
        }
        field(8; "Expense No."; Code[20])
        {
            Caption = 'Expense Numbers';
            TableRelation = "No. Series";
        }
        field(9; "Ticket No."; Code[20])
        {
            Caption = 'Ticket Numbers';
            TableRelation = "No. Series";
        }
        field(10; "Warranty No."; Code[20])
        {
            Caption = 'Ticket Numbers';
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }
}