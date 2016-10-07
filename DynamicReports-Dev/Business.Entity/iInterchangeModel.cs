using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;


public class iInterchangeModel
{

    //ACTIVITY table   
    public int ActivityID { get; set; }
    public string ActivityName { get; set; }
    public int ActivityTypeID { get; set; }
    public string ActivityDescription { get; set; }
    public int ListBit { get; set; }
    public int MySubmitBit { get; set; }
    public string ModuleID { get; set; }
    public string Menutext { get; set; }
    public int MenuOrder { get; set; }
    public int CreateBit { get; set; }
    public int EditBit { get; set; }
    public string GUID { get; set; }
    public int HDQRTRSID { get; set; }
    public int ListColumnCount { get; set; }
    public int MySubmitColumnBit { get; set; }
    public int CancelBit { get; set; }
    public int DifferentBit { get; set; }
    public string ActivityCaption { get; set; }


    //REPORT_PARAMETER table
    public string ReportName { get; set; }
    public string ParameterName { get; set; }
    public string DisplayName { get; set; }
    public string ParameterType { get; set; }
    public string ParameterQuery { get; set; }
    public int ParameterOperator { get; set; }
    public int RequertDeptID { get; set; }
    public int ParameterDropdown { get; set; }
    public int CompanyID { get; set; }
    public int OrderNo { get; set; }

       //Common variable for table  
    public int ReportId { get; set; }
    public string ActualColumn { get; set; }
    public string MasterQuery { get; set; }
    public string ParameterOrderColumn { get; set; }
    public string ParameterOrderType { get; set; }
    public int ActivityBit { get; set; }
    public string AssociationID { get;set; }
    public int UserTypeID { get; set; }


}

