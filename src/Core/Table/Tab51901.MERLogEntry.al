// table 51901 MERLogEntry
// {
//     Caption = 'MERLogEntry';
//     DataClassification = ToBeClassified;

//     fields
//     {
//         field(1; "Entry No."; Integer)
//         {
//             Caption = 'Entry No.';
//         }
//         field(2; "Event Type"; Enum "MER Log Event Type")
//         {
//             Caption = 'Event Type';
//         }
//         field(3; "Event DateTime"; Date)
//         {
//             Caption = 'Event DateTime';
//         }
//         field(4; "User ID"; Code[50])
//         {
//             Caption = 'User ID';
//         }
//         field(5; "Source Record ID"; RecordId)
//         {
//             Caption = 'Source Record ID';
//         }
//         field(6; "Source No."; Code[20])
//         {
//             Caption = 'Source No.';
//         }
//         field(7; Description; Text[250])
//         {
//             Caption = 'Description';
//         }
//         field(8; Amount; Decimal)
//         {
//             Caption = 'Amount';
//         }
//     }
//     keys
//     {
//         key(PK; "Entry No.")
//         {
//             Clustered = true;
//         }
//     }
// }
