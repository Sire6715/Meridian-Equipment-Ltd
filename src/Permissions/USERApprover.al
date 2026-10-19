permissionset 51901 "MER APPROVER"
{
    Assignable = true;
    IncludedPermissionSets = "MER USER";
    Permissions =
        tabledata "MER Setup" = R,
        tabledata "MER Expense Header" = RIM,
        tabledata "MER Staff" = R;

}


