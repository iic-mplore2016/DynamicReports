using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

public class SaveReportModel
{
    public int ReportId { get; set; }
    public string ReportName { get; set; }
    public string AssignRole { get; set; }
    public string SelectedDatabase { get; set; }
    public string ConnectionString { get; set; }
    public string QueryBuilder { get; set; }
    public string FieldName { get; set; }
    public DateTime SavedDate { get; set; }
    public string Grouping { get; set; }

    public string ReportType { get; set; }
    public string RecurrenceType { get; set; }
    public string DayWise { get; set; }
    public string ReportTime { get; set; }
    public string ReportFormat { get; set; }
    public string SaveLocation { get; set; }
    public string SendEmail { get; set; }

    public string LabelColumn { get; set; }
    public int IsDisplay { get; set; }
    public string DisplayName { get; set; }
    public int isFilter { get; set; }
    public int Precondition { get; set; }
    public string Aggregation { get; set; }
    public string SortBy { get; set; }
    public string parameterType { get; set; }
    public string parameterQuery { get; set; }
    public int orderNo { get; set; }
    public string dateType { get; set; }

}
