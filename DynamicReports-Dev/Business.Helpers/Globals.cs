using System;
using System.Collections.Generic;
using System.Linq;

using System.Data;
using System.Web;

public static class GlobalValues
{
    public static string ConnectionString { get; set; }
    public static string Authentication { get; set; }
    public static string ServerName { get; set; }
    public static string ServerType { get; set; }
    public static string ProviderName { get; set; }
    public static string ServerLocation { get; set; }
    public static string SendEmail { get; set; }
    public static string UserName { get; set; }
    public static string Password { get; set; }
    public static string SelectedDB { get; set; }
    public static string[] SelectedRows { get; set; }
    public static string[] SelectedIds { get; set; }
    public static string BuildQueries { get; set; }
    public static string ReportBuildQueries { get; set; }
    public static string FirstTable { get; set; }
    public static string JoinTable { get; set; }
    public static string BuildAggregator { get; set; }
    public static string SortOrderFields { get; set; }
    public static string FilterQuery { get; set; }
    public static string FilterWhere { get; set; }
    public static string QueueLimit { get; set; }
    public static string ManualJoiningQuery { get; set; }
    public static List<MasterTablesModel> MasterTables = new List<MasterTablesModel>();
    public static List<DatabaseFieldsModel> SelectedFields = new List<DatabaseFieldsModel>();

    public static List<CustomFieldsModel> CustomFields = new List<CustomFieldsModel>();
    //public static List<LookUpColumn> LookUpColumns = new List<LookUpColumn>();
    public static List<MasterLookUp> MasterLookUp = new List<MasterLookUp>();
    public static List<ReferenceTable> ReferenceTable = new List<ReferenceTable>();

    public static List<TableJoin> TableJoin = new List<TableJoin>();
    public static List<ExistTablesModel> ExistTablesModel = new List<ExistTablesModel>();
    public static List<SearchNameModel> SearchNameList = new List<SearchNameModel>();
    public static DataTable globalTable = new DataTable();
}
