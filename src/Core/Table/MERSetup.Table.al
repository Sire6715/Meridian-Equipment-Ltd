table 51910 "MER Setup"
{
    DataClassification = ToBeClassified;
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
        field(11; "Fallback Approver ID"; Code[50])
        {
            Caption = 'Fallback Approver ID';
            TableRelation = User;
        }
        field(12; "Project Dimension"; Code[20])
        {
            Caption = 'Project Dimension';
            TableRelation = Dimension;
        }
        field(13; "Project Dimension Code"; Code[20])
        {
            Caption = 'Project Dimension Code';
            TableRelation = Dimension;
        }
        field(14; "Require Project on Lines"; Boolean)
        {
            Caption = 'Require Project on Expense Lines';
        }
        field(15; "Expense Balancing G/L Acc. No."; Code[20])
        {
            Caption = 'Expense Balancing G/L Account No.';
            TableRelation = "G/L Account" where("Account Type" = const(Posting), Blocked = const(false));
        }
        field(16; "Expense Journal Template"; Code[10])
        {
            Caption = 'Expense Journal Template';
            TableRelation = "Gen. Journal Template";
        }
        field(17; "Expense Journal Batch"; Code[10])
        {
            Caption = 'Expense Journal Batch';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Expense Journal Template"));
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