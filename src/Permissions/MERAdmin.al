permissionset 51899 "MER ADMIN"
{
    Assignable = true;
    // IncludedPermissionSets = SomePermissionSet;
    Permissions =
        tabledata "MER Setup" = RIMD,
        tabledata "MER Expense Header" = RIMD,
        tabledata "MER Expense Line" = RIMD,
        tabledata "MER Staff" = RIMD;

}