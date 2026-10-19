permissionset 51900 "MER USER"
{
    Assignable = true;
    Permissions =
        tabledata "MER Setup" = R,
        tabledata "MER Expense Header" = RI,
        tabledata "MER Expense Line" = RI,
        tabledata "MER Staff" = R;
}