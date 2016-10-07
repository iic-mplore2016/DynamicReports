using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

public class CustomFieldsModel
{
    public string LabelColumn { get; set; }
    public bool IsDisplay { get; set; }
    public string DisplayName { get; set; }
    public bool IsFilter { get; set; }
    public bool PreconditionCheck { get; set; }
    public string Aggregation { get; set; }
    public string PreconditionSelection { get; set; }
    public string PreconditionValues { get; set; }
    public string DateBetween { get; set; }
    public string query { get; set; }
    public string condition { get; set; }
    public string SortBy { get; set; }
    public string ReturnJoin { get; set; }

    public string parameterType { get; set; }
    public string parameterQuery { get; set; }
    public int orderNo { get; set; }
    public string dateType { get; set; }


}
