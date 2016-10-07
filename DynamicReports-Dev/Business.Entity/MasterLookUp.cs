using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
public class MasterLookUp
{
    public string LabelColumn { get; set; }
    public string LookUpType { get; set; }
    public int ReportID { get; set; }
    public string TableName { get; set; }
    public string MappingField { get; set; }
    public string LookUpQuery { get; set; }
    public int LookUpID { get; set; }
    public string ActualColumn { get; set; }
    public string DisplayName { get; set; }

    public List<LookUpColumn> LookUpColumn = new List<LookUpColumn>();
}

