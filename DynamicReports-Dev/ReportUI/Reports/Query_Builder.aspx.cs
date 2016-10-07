using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;
using System.Threading;
using System.Web.Services;
using System.Web.Script.Services;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.Json;
using System.Collections;
using System.Reflection;
using System.Runtime.InteropServices;

public partial class Reports_Query_Builder : System.Web.UI.Page
{
    BusinessLayer Config = new BusinessLayer();
    DataTable sqltable = new DataTable();
    DataTable tablecolumn = new DataTable();
    Assembly assembly = Assembly.GetExecutingAssembly();
    private string tablenmae { get; set; }
    private DataTable db = new DataTable();
    public string[] SelectedIds { get; set; }


    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            PopulateEventDropdownLists();
        }
    }

    private void PopulateEventDropdownLists()
    {
        //  Guid id = Guid.NewGuid();
        GlobalValues.ServerType = WebConfigurationManager.ConnectionStrings["DBType"].ProviderName;
        GlobalValues.ServerName = WebConfigurationManager.ConnectionStrings["DBConnection"].ConnectionString;
        GlobalValues.ProviderName = WebConfigurationManager.ConnectionStrings["DBConnection"].ProviderName;

        GlobalValues.SelectedRows = null;
        GlobalValues.globalTable.Clear();
        GlobalValues.MasterTables.Clear();
        GlobalValues.SelectedFields.Clear();
        GlobalValues.SortOrderFields = string.Empty;
        GlobalValues.CustomFields.Clear();
        GlobalValues.SelectedFields.Clear();
        GlobalValues.BuildQueries = string.Empty;
        GlobalValues.SearchNameList.Clear();
        GlobalValues.MasterLookUp.Clear();
        GlobalValues.SelectedRows = null;
        GlobalValues.TableJoin.Clear();
        GlobalValues.ReferenceTable.Clear();
        try
        {
            ddlagregation.DataSource = ListHelper.Aggregate();
            ddlagregation.DataBind();

            ddlModule.DataSource = Config.GetModule();
            ddlModule.DataBind();
            ddlModule.DataTextField = "MDL_NAM";
            ddlModule.DataValueField = "MDL_ID";
            ddlModule.DataBind();

            ddlsortOrder.DataSource = ListHelper.SortOrder();
            ddlsortOrder.DataBind();
            ddlDataType.DataSource = ListHelper.DataType();
            ddlDataType.DataBind();


            //   BusinessLayer Config = new BusinessLayer();


        }
        catch (Exception ex)
        {

            ExceptionLogging.SendErrorToText(ex);
        }

    }

    [WebMethod]
    [ScriptMethod]
    public static string ClearManualJoin()
    {
        GlobalValues.FilterQuery = string.Empty;
        return "true";
    }
    [WebMethod]
    [ScriptMethod]
    public static string btnClearFields_Click()
    {
        GlobalValues.TableJoin.Clear();
        GlobalValues.MasterTables.Clear();
        GlobalValues.CustomFields.Clear();
        GlobalValues.SelectedFields.Clear();
        GlobalValues.MasterLookUp.Clear();
        GlobalValues.SortOrderFields = string.Empty;
        GlobalValues.BuildQueries = string.Empty;
        GlobalValues.ReferenceTable.Clear();
        GlobalValues.FilterQuery = string.Empty;
        GlobalValues.FilterWhere = string.Empty;

        GlobalValues.ExistTablesModel.Clear();
        HttpContext.Current.Session["ReportViewQuery"] = null;
        HttpContext.Current.Session["ReportQuery"] = null;

        return "true";
    }


    [WebMethod(EnableSession = true)]
    [ScriptMethod]
    public static CustomFieldsModel btnvalidate_Click(string[] fields, string sfields, string mjquery, string[] mjoins)
    {

        HttpContext.Current.Session["ReportViewQuery"] = null;
        HttpContext.Current.Session["ReportQuery"] = null;
        GlobalValues.BuildQueries = string.Empty;
        GlobalValues.FilterQuery = string.Empty;
        GlobalValues.FilterWhere = string.Empty;
        GlobalValues.SelectedFields.Clear();
        GlobalValues.ExistTablesModel.Clear();
        GlobalValues.SortOrderFields = string.Empty;
        GlobalValues.MasterTables.Clear();

        GlobalValues.ReferenceTable.Clear();
        MasterTablesModel[] tableArray = null;
        string tablenmae;
        DataTable sqltable = new DataTable();
        bool aggregateFlag = false;
        BusinessLayer Config = new BusinessLayer();

        if (sfields != "-1")
        {            
            string selected_order = sfields.Replace(", as", "").TrimEnd(',');
            GlobalValues.SortOrderFields = " order by " + selected_order;
        }
        foreach (var item in fields)
        {
            var items = new DatabaseFieldsModel
            {
                TableField = item
            };
            GlobalValues.SelectedFields.Add(items);
        }

        string groupby = "";
        //  sqltable = GlobalValues.globalTable;
        GlobalValues.FirstTable = null;
        string query1 = "Select ";
        foreach (var sField in GlobalValues.SelectedFields)
        {
            string slitvalues = sField.TableField;
            string aaa = slitvalues.Split('.')[0];

            var item = new MasterTablesModel
            {
                TablesName = aaa
            };
            bool result = GlobalValues.MasterTables.Exists(t => t.TablesName == aaa);
            if (result == false)
                GlobalValues.MasterTables.Add(item);
        }
        int i = 0;
        string pTableName = "";
        tableArray = GlobalValues.MasterTables.ToArray();

        foreach (var sField in GlobalValues.SelectedFields)
        {
            if (i == 0)
            {
                if (GlobalValues.CustomFields.Count > 0)
                {
                    var item = GlobalValues.CustomFields.FirstOrDefault(s => s.LabelColumn == sField.TableField);
                    if (item != null)
                    {

                        if (item.Aggregation != "None" && item.DisplayName != "")
                        {

                            bool dName = item.DisplayName.Contains(" ");
                            if (dName == true)
                                item.DisplayName = '"' + item.DisplayName.Trim('"') + '"';

                            query1 += item.Aggregation + "(" + item.LabelColumn + ")" + " as " + item.DisplayName + " ,";
                            aggregateFlag = true;
                        }
                        if (item.Aggregation == "None" && item.DisplayName != "")
                        {
                            bool dName = item.DisplayName.Contains(" ");

                            if (dName == true)
                                item.DisplayName = '"' + item.DisplayName.Trim('"') + '"';
                            query1 += item.LabelColumn + " as " + item.DisplayName + " ,";
                            groupby += sField.TableField + ",";
                        }
                        if (item.Aggregation != "None" && item.DisplayName == "")
                        {
                            query1 += item.Aggregation + "(" + item.LabelColumn + ")" + " ,";
                            aggregateFlag = true;
                        }
                        if (item.LabelColumn != sField.TableField)
                            query1 += sField.TableField + ",";

                        if (item.IsFilter == true && item.DisplayName == "" && item.Aggregation == "None")
                        {
                            query1 += sField.TableField + ",";
                            groupby += sField.TableField + ",";
                        }
                        if (item.SortBy != "None" && item.SortBy != null)
                        {
                            query1 += sField.TableField + ",";
                            groupby += sField.TableField + ",";
                            GlobalValues.SortOrderFields += item.LabelColumn + " " + item.SortBy + ",";
                        }
                        if (item.IsDisplay == false && item.DisplayName == "" && item.IsFilter == false && item.PreconditionCheck == false && item.Aggregation == "None" && item.SortBy == "None")
                        {
                            query1 += sField.TableField + ",";
                            groupby += sField.TableField + ",";
                        }
                    }
                    else
                    {
                        groupby += sField.TableField + ",";
                        query1 += sField.TableField + ",";
                    }
                }
                else
                {
                    query1 += sField.TableField + ",";
                }

            }

        }


        string joinValues = "";
        if (mjquery != "-1")
        {
            GlobalValues.TableJoin.Clear();
            for (int z = 0; z < mjoins.Length; z++)
            {
                string[] mjfields = mjoins[z].Split(':');
                GlobalValues.TableJoin.Add(new TableJoin()
                {
                    fieldLeft = mjfields[0],
                    joinType = mjfields[1],
                    fieldRight = mjfields[2]
                });

            }
            query1 = query1.TrimEnd(',') + mjquery.TrimEnd(',');
            GlobalValues.FilterQuery = query1;
            
        }
        else
        {
            GlobalValues.TableJoin.Clear();
            //string BaseTable = "";
            for (int j = 0; j < tableArray.Length; j++)
            {
                tablenmae = tableArray[j].TablesName;
                if (j == 0)
                {
                    //BaseTable = tablenmae;
                    var reffer1 = new ReferenceTable();
                    reffer1.RefferentTables = tablenmae;
                    GlobalValues.ReferenceTable.Add(reffer1);
                    query1 = query1.TrimEnd(',') + " from " + tablenmae;
                    GlobalValues.FilterQuery = query1;
                }
                int k = 0;
                foreach (var yField in GlobalValues.MasterTables)
                {
                    if (tablenmae != yField.TablesName)
                    {
                        DataTable dt2 = Config.GetExingColumns(tablenmae, yField.TablesName);

                        if (dt2.Rows.Count > 0)
                        {


                            if (k != 0)
                            {
                                pTableName = dt2.Rows[0]["TableName"].ToString() + "." + dt2.Rows[0]["ColumnName"].ToString() + " = " + dt2.Rows[0]["ReferenceTableName"].ToString() + "." + dt2.Rows[0]["ReferenceColumnName"].ToString();
                                tablenmae = dt2.Rows[0]["ReferenceTableName"].ToString();
                                joinValues += pTableName + ",";
                                //  k++;
                                GlobalValues.TableJoin.Add(new TableJoin()
                                {
                                    fieldLeft = dt2.Rows[0]["TableName"].ToString() + "." + dt2.Rows[0]["ColumnName"].ToString(),
                                    joinType = "LEFT JOIN",
                                    fieldRight = dt2.Rows[0]["ReferenceTableName"].ToString() + "." + dt2.Rows[0]["ReferenceColumnName"].ToString()
                                });
                            }
                            else
                            {
                                pTableName = dt2.Rows[0]["TableName"].ToString() + "." + dt2.Rows[0]["ColumnName"].ToString() + " = " + dt2.Rows[0]["ReferenceTableName"].ToString() + "." + dt2.Rows[0]["ReferenceColumnName"].ToString();
                                joinValues += pTableName + ",";
                                if (j == 0)
                                    tablenmae = dt2.Rows[0]["ReferenceTableName"].ToString();
                                k++;
                                GlobalValues.TableJoin.Add(new TableJoin()
                                {
                                    fieldLeft = dt2.Rows[0]["TableName"].ToString() + "." + dt2.Rows[0]["ColumnName"].ToString(),
                                    joinType = "LEFT JOIN",
                                    fieldRight = dt2.Rows[0]["ReferenceTableName"].ToString() + "." + dt2.Rows[0]["ReferenceColumnName"].ToString()
                                });
                            }
                            var reffer2 = new ReferenceTable();
                            reffer2.RefferentTables = tablenmae;
                            GlobalValues.ReferenceTable.Add(reffer2);
                            var tItems = new ExistTablesModel
                            {

                                TableName = " left join " + tablenmae + " on "
                            };
                            GlobalValues.ExistTablesModel.Add(tItems);
                            var alreadyExist = GlobalValues.ExistTablesModel.Where(t => t.TableName == " left join " + tablenmae + " on ").ToList();
                            if (alreadyExist.Count == 1)
                            {
                                query1 += " left join " + tablenmae + " on " + pTableName;
                            }
                            else
                            {
                                query1 += " and " + pTableName;
                            }
                            GlobalValues.FilterQuery = query1;
                        }
                    }
                }
            }
        }
        if (aggregateFlag == true)
        {
            if (GlobalValues.SelectedFields.Count > 1)
            {
                query1 += " group by " + groupby.TrimEnd(',');
                GlobalValues.FilterWhere = " group by " + groupby.TrimEnd(',');
            }
        }
        var rfields = new CustomFieldsModel();
        string orderby = "";
        if (GlobalValues.SortOrderFields != null && GlobalValues.SortOrderFields != "")
        {
            orderby = query1 + " Order By " + GlobalValues.SortOrderFields.TrimEnd(',');
            GlobalValues.FilterWhere += " Order By " + GlobalValues.SortOrderFields.TrimEnd(',');
            GlobalValues.BuildQueries = orderby;
            //GlobalValues.ReportBuildQueries = orderby;
            HttpContext.Current.Session["ReportQuery"] = orderby;
        }
        else
        {
            orderby = query1;
            GlobalValues.BuildQueries = orderby;
            // GlobalValues.ReportBuildQueries = orderby;
            HttpContext.Current.Session["ReportQuery"] = orderby;
        }
        try
        {
            DataTable table = Config.GetReport(GlobalValues.BuildQueries);
            if (table != null)
            {
                rfields = new CustomFieldsModel
                {
                    query = orderby,
                    ReturnJoin = joinValues,
                    condition = "yes"
                };
            }
            else
            {
                string notReference = "";
                foreach (var car in GlobalValues.MasterTables.Where(c => !GlobalValues.ReferenceTable.Any(f => f.RefferentTables == c.TablesName)))
                {
                    notReference += car.TablesName + ",";
                }

                //k var notLinked = GlobalValues.MasterTables.Where(b => GlobalValues.ReferenceTable.Contains(b.TablesName));
                // var result = GlobalValues.MasterTables.Where
                rfields = new CustomFieldsModel
                {
                    query = orderby,
                    ReturnJoin = joinValues,
                    condition = notReference.TrimEnd(',')
                };
            }
        }
        catch (Exception ex)
        {
            string notReference = "";
            foreach (var car in GlobalValues.MasterTables.Where(c => !GlobalValues.ReferenceTable.Any(f => f.RefferentTables == c.TablesName)))
            {
                notReference += car.TablesName + ",";
            }
            ExceptionLogging.SendErrorToText(ex);
            rfields = new CustomFieldsModel
            {
                query = orderby,
                ReturnJoin = joinValues,
                condition = notReference.TrimEnd(',')
            };
        }
        return rfields;
    }


    protected void btnsave_Click(object sender, EventArgs e)
    {

        try
        {
            string reportType = "";
            if (chckWebview.Checked == true)
                reportType = chckWebview.Value;
            if (chckSchedule.Checked == true)
                reportType = chckSchedule.Value;

            var model = new SaveReportModel()
            {
                ReportType = reportType,
                ReportName = txtrName.Value,
                QueryBuilder = GlobalValues.FilterQuery,
                AssignRole = "Admin",
                SelectedDatabase = GlobalValues.SelectedDB,
                ConnectionString = GlobalValues.ConnectionString,
                SavedDate = DateTime.Now,
                Grouping = GlobalValues.FilterWhere
            };

            int LastID = Config.SaveReport(model);
            var attribute = Guid.NewGuid();
            var activityModel = new iInterchangeModel()
            {
                ActivityID = LastID,
                ActivityName = txtrName.Value,
                ActivityTypeID = 5,
                ActivityDescription = "Reports",
                ListBit = 0,
                MySubmitBit = 0,
                ModuleID = ddlModule.SelectedValue,
                Menutext = "ReportParameter.aspx?apu=Reports/" + txtrName.Value + "/" + txtrName.Value + " Report&activityid=" + LastID + "&activityname=" + txtrName.Value + "&type=Reports&listpanetitle=Reports >> " + txtrName.Value + " >> " + txtrName.Value + " Report&pagetitle=" + txtrName.Value + " Report&pagetype=Reports&mode=new&qrytype=view;status=" + txtrName.Value + " Report",
                MenuOrder = 1,
                CreateBit = 0,
                EditBit = 0,
                ActivityBit = 1,
                GUID = Convert.ToString(attribute),
                HDQRTRSID = 1,
                ListColumnCount = 0,
                MySubmitColumnBit = 0,
                CancelBit = 0,
                DifferentBit = 0,
                ActivityCaption = txtrName.Value
            };
            Config.SaveActivityTable(activityModel);


            //var association = new iInterchangeModel()
            //{
            //    // AssociationID = "(select max(ACTVTY_ASSCTN_ID)+1 as AID from activity_association)",
            //    AssociationID = WebConfigurationManager.AppSettings["AssociationID"],
            //    ActivityID = LastID,
            //    UserTypeID = 79

            //};
            string[] associationID = { "79", "80", "81" };
            if (WebConfigurationManager.AppSettings["ACTIVITY_ASSOCIATION"] == "True" || WebConfigurationManager.AppSettings["ACTIVITY_ASSOCIATION"] == "true")
            {
                var association = new iInterchangeModel();
                // association.AssociationID = WebConfigurationManager.AppSettings["AssociationID"];
                foreach (string assID in associationID)
                {
                    association.AssociationID = WebConfigurationManager.AppSettings["AssociationID"];
                    association.ActivityID = LastID;
                    association.UserTypeID = Convert.ToInt16(assID);
                    Config.SaveAssociationTable(association);
                }

            }
            var parameterModel = new iInterchangeModel();
            //  var masterParamModel = new iInterchangeModel();

            //foreach (var mjoin in GlobalValues.TableJoin)
            //{
            //    var mjn = new TableJoin
            //    {
            //        repId = LastID.ToString(),
            //        fieldLeft = mjoin.fieldLeft,
            //        joinType = mjoin.joinType,
            //        fieldRight = mjoin.fieldRight
            //    };
            //    Config.SaveMjoinFields(mjn);
            //}

            foreach (var item in GlobalValues.SelectedFields)
            {
                model.ReportId = LastID;
                model.FieldName = item.TableField;
                Config.SaveReportFields(model);
            }
            foreach (var lookup in GlobalValues.MasterLookUp)
            {
                var master = new MasterLookUp
                {
                    ReportID = LastID,
                    LookUpType = lookup.LookUpType,
                    LabelColumn = lookup.LabelColumn,
                    TableName = lookup.TableName,
                    MappingField = lookup.MappingField,
                    LookUpQuery = lookup.LookUpQuery
                };
                int lookUpID = Config.SaveMaster(master);
                foreach (var mField in lookup.LookUpColumn)
                {
                    master.LookUpID = lookUpID;
                    master.ActualColumn = mField.LookUpActualColumn;
                    master.ReportID = LastID;
                    master.DisplayName = mField.LookUpAliasColumn;
                    Config.SaveMasterFields(master);
                }
            }

            foreach (var item in GlobalValues.CustomFields)
            {
                model.ReportId = LastID;
                model.LabelColumn = item.LabelColumn;
                if (item.IsDisplay == true)
                    model.LabelColumn = item.LabelColumn;
                model.DisplayName = item.DisplayName.Trim('"');
                if (item.IsDisplay == true) { model.IsDisplay = 1; } else { model.IsDisplay = 0; }
                if (item.IsFilter == true) { model.isFilter = 1; } else { model.isFilter = 0; }
                if (item.PreconditionCheck == true) { model.Precondition = 1; } else { model.Precondition = 0; }
                model.Aggregation = item.Aggregation;
                model.SortBy = item.SortBy;
                if (item.parameterType == "Text")
                {
                    model.parameterType = "String";
                }
                else if (item.parameterType == "Master")
                {
                    parameterModel.ParameterType = "MultiValue";
                }
                else
                {
                    model.parameterType = item.parameterType;
                }
                Config.SaveReportFilterFields(model);

                DataTable masterQuery = Config.GetMasterTable(model.LabelColumn, model.ReportId);


                if (item.IsFilter == true)
                {
                    parameterModel.ReportId = LastID;
                    parameterModel.ParameterName = item.DisplayName.Trim('"');
                    parameterModel.DisplayName = item.DisplayName.Trim('"');
                    if (item.parameterType == "Text")
                    {
                        parameterModel.ParameterType = "String";
                    }
                    else if (item.parameterType == "Master")
                    {
                        parameterModel.ParameterType = "MultiValue";
                    }
                    else
                    {
                        parameterModel.ParameterType = item.parameterType;
                    }

                    if (masterQuery.Rows.Count != 0)
                    {
                        if (masterQuery.Rows[0]["MPPING_QRY"] != null)
                        {
                            parameterModel.ParameterQuery = masterQuery.Rows[0]["MPPING_QRY"].ToString();
                        }
                    }
                    else
                    {
                        parameterModel.ParameterQuery = "";
                    }

                    parameterModel.ParameterOperator = 0;
                    parameterModel.RequertDeptID = 0;
                    parameterModel.ParameterOrderColumn = "";
                    parameterModel.ParameterOrderType = "";
                    parameterModel.ParameterDropdown = 0;
                    parameterModel.ActualColumn = item.LabelColumn;
                    parameterModel.CompanyID = 1;
                    parameterModel.OrderNo = 1;
                    parameterModel.ActivityBit = 1;
                    Config.SaveParameterTable(parameterModel);
                }
                //masterParamModel.ActualColumn = item.LabelColumn;
                //masterParamModel.MasterQuery = WebConfigurationManager.AppSettings["MasterQuery"];
                //masterParamModel.ParameterOrderColumn = item.LabelColumn;
                //masterParamModel.ParameterOrderType = item.parameterType;
                //masterParamModel.ActivityBit = 1;
                //Config.SaveMasterTable(masterParamModel);


            }


            if (chckSchedule.Checked == true)
            {
                model.ReportFormat = report_format.SelectedValue;
                model.ReportTime = txtTime.Value;
                //if (chckLocation.Checked == true)
                model.SaveLocation = "";
                //if (chckEmail.Checked == true)
                model.SendEmail = txtareaEmail.Value;

                if (optionDaily.Checked == true)
                {
                    model.RecurrenceType = optionDaily.Value;
                    Config.SaveScheduleReport(model);
                }
                if (optionsWeekly.Checked == true)
                {
                    string weeklyWise = "";
                    if (chckSunday.Checked == true)
                        weeklyWise += chckSunday.Value + ",";
                    if (chckMonday.Checked == true)
                        weeklyWise += chckMonday.Value + ",";
                    if (chckTuesday.Checked == true)
                        weeklyWise += chckTuesday.Value + ",";
                    if (chckWenesday.Checked == true)
                        weeklyWise += chckWenesday.Value + ",";
                    if (chckThursday.Checked == true)
                        weeklyWise += chckThursday.Value + ",";
                    if (chckFriday.Checked == true)
                        weeklyWise += chckFriday.Value + ",";
                    if (chckSaturday.Checked == true)
                        weeklyWise += chckSaturday.Value + ",";
                    model.DayWise = weeklyWise.Trim(',');
                    model.RecurrenceType = optionsWeekly.Value;
                    Config.SaveScheduleReport(model);
                }
                if (optionsMonthly.Checked == true)
                {
                    model.RecurrenceType = optionsMonthly.Value;
                    if (optionsDay.Checked == true)
                        model.DayWise = txtDay.Value;
                    Config.SaveScheduleReport(model);
                }
            }
            //clear all the fields
            //  ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Notify", "alert('Notification :SuccessFully Saved');", true);
            txtrName.Value = "";
            chckWebview.Checked = false;
            chckSchedule.Checked = false;
            optionDaily.Checked = false;
            optionsWeekly.Checked = false;
            optionsMonthly.Checked = false;
            chckSunday.Checked = false;
            chckMonday.Checked = false;
            chckTuesday.Checked = false;
            chckWenesday.Checked = false;
            chckThursday.Checked = false;
            chckFriday.Checked = false;
            chckSaturday.Checked = false;
            optionsDay.Checked = false;
            txtDay.Value = "";

            txtareaEmail.Value = "";
        }
        catch (Exception ex)
        {

            ExceptionLogging.SendErrorToText(ex);
        }
      
    }

    [WebMethod]
    [ScriptMethod]
    public static MasterLookUp getmaster(string label)
    {
        var mresults = GlobalValues.MasterLookUp.Where(c => c.LabelColumn == label).ToList();
        var mitems = new MasterLookUp();

        if (mresults.Count != 0)
        {
            foreach (var mres in mresults)
            {
                if (label == mres.LabelColumn)
                {
                    mitems = new MasterLookUp
                    {
                        LookUpType = mres.LookUpType,
                        LabelColumn = mres.LabelColumn,
                        ReportID = mres.ReportID,
                        TableName = mres.TableName,
                        MappingField = mres.MappingField,
                        LookUpQuery = mres.LookUpQuery,
                        LookUpID = mres.LookUpID,
                        ActualColumn = mres.ActualColumn,
                        DisplayName = mres.DisplayName,
                        LookUpColumn = mres.LookUpColumn
                    };
                }
            }
        }
        else
        {
            mitems = new MasterLookUp
            {
                LookUpType = "0",
                LabelColumn = label,
                //ReportID = mres.ReportID,
                TableName = "Please Choose",
                MappingField = "0",
                LookUpQuery = "",
                //LookUpID = mres.LookUpID,
                ActualColumn = "",
                DisplayName = "",
                LookUpColumn = new List<LookUpColumn>()
            };
        }

        return mitems;
    }

    [WebMethod]
    [ScriptMethod]
    public static CustomFieldsModel getUser(string label)
    {
        var resul = GlobalValues.CustomFields.Where(c => c.LabelColumn == label).ToList();

        var fields = new CustomFieldsModel();


        if (resul.Count != 0)
        {
            foreach (var field in resul)
            {
                if (label == field.LabelColumn)
                {
                    fields = new CustomFieldsModel
                    {
                        LabelColumn = field.LabelColumn,
                        IsDisplay = field.IsDisplay,
                        IsFilter = field.IsFilter,
                        DisplayName = field.DisplayName,
                        Aggregation = field.Aggregation,
                        SortBy = field.SortBy,
                        parameterType = field.parameterType
                    };
                    break;
                }
                else
                {
                    fields = new CustomFieldsModel
                    {
                        LabelColumn = label,
                        IsDisplay = true,
                        IsFilter = false,
                        DisplayName = label.Split('.')[1],
                        Aggregation = "None",
                        SortBy = "None",
                        parameterType = "None"
                    };
                }

            }
        }
        else
        {
            fields = new CustomFieldsModel
            {
                LabelColumn = label,
                IsDisplay = true,
                IsFilter = false,
                DisplayName = label.Split('.')[1],
                Aggregation = "None",
                SortBy = "None",
                parameterType = "None"
            };
        }

        return fields;
    }

    [WebMethod]
    [ScriptMethod]
    public static string SaveUser(CustomFieldsModel user)
    {

        var resul = GlobalValues.CustomFields.Where(c => c.LabelColumn == user.LabelColumn).ToList();

        if (resul.Count != 0)
        {
            resul[0].LabelColumn = user.LabelColumn;
            resul[0].IsDisplay = user.IsDisplay;
            resul[0].IsFilter = user.IsFilter;
            resul[0].DisplayName = user.DisplayName;
            resul[0].Aggregation = user.Aggregation;
            resul[0].SortBy = user.SortBy;
            resul[0].parameterType = user.parameterType;

        }
        else
        {
            GlobalValues.CustomFields.Add(new CustomFieldsModel()
            {
                LabelColumn = user.LabelColumn,
                IsDisplay = user.IsDisplay,
                IsFilter = user.IsFilter,
                DisplayName = user.DisplayName,
                Aggregation = user.Aggregation,
                SortBy = user.SortBy,
                parameterType = user.parameterType

            });
            //  HttpContext.Current.Session.Add("CustomFields", GlobalValues.CustomFields);
        }
        return "Success";
    }
    [WebMethod]
    [ScriptMethod]
    public static string MasterLookUpSave(MasterLookUp mFields, string[] mColumns)
    {
        string queryColumns = "";
        foreach (var item in mColumns)
        {
            string[] lookupColumn = item.Split(':');
            bool dName = lookupColumn[1].Contains(" ");
            if (dName == true)
                lookupColumn[1] = '"' + lookupColumn[1] + '"';
            var items = new LookUpColumn
            {
                LookUpActualColumn = lookupColumn[0],
                LookUpAliasColumn = lookupColumn[1]
            };
            mFields.LookUpColumn.Add(items);
            queryColumns += lookupColumn[0] + "[" + lookupColumn[1] + "]" + ",";
        }

        string query = "SELECT " + queryColumns + mFields.MappingField + "[ID]" + " FROM " + mFields.TableName;
        mFields.LookUpQuery = query;

        var mresults = GlobalValues.MasterLookUp.Where(c => c.LabelColumn == mFields.LabelColumn).ToList();

        if (mresults.Count != 0)
        {
            mresults[0].ActualColumn = mFields.ActualColumn;
            mresults[0].DisplayName = mFields.DisplayName;
            mresults[0].LabelColumn = mFields.LabelColumn;
            mresults[0].LookUpColumn = mFields.LookUpColumn;
            mresults[0].LookUpID = mFields.LookUpID;
            mresults[0].LookUpQuery = mFields.LookUpQuery;
            mresults[0].LookUpType = mFields.LookUpType;
            mresults[0].MappingField = mFields.MappingField;
            mresults[0].ReportID = mFields.ReportID;
            mresults[0].TableName = mFields.TableName;

        }
        else
        {
            GlobalValues.MasterLookUp.Add(mFields);
        }

        return query;
    }
    [WebMethod]
    [ScriptMethod]
    public static string getFields(string table)
    {
        BusinessLayer Config = new BusinessLayer();
        DataTable tablecolumn = Config.GetColumns(table);
        string jsonString = string.Empty;
        jsonString = JsonConvert.SerializeObject(tablecolumn);
        return jsonString;
    }
    [WebMethod]
    [ScriptMethod]
    public static string GetTables(string table)
    {
        BusinessLayer Config = new BusinessLayer();
        DataTable tName = Config.GetDataTablesAll(table);
        string jsonString = string.Empty;
        jsonString = JsonConvert.SerializeObject(tName);
        return jsonString;

    }

    // public static string GetMasterLookUpTable()
    [WebMethod]
    [ScriptMethod]
    public static string DeleteField(string fieldName)
    {
        var resul = GlobalValues.CustomFields.Where(c => c.LabelColumn == fieldName).ToList();
        if (resul.Count != 0)
        {
            resul[0].LabelColumn = fieldName;
            resul[0].IsDisplay = true;
            resul[0].IsFilter = false;
            resul[0].DisplayName = "";
            resul[0].Aggregation = "None";
            resul[0].SortBy = "None";
            resul[0].parameterType = "None";

        }
        return "true";
    }

    [WebMethod]
    [ScriptMethod]
    public static string validateReportname(string repName)
    {
        BusinessLayer Config = new BusinessLayer();
        DataTable reportName = Config.GetReportName(repName);
        int cnt = reportName.Rows.Count;
        if (cnt != 0)
        {
            return "true";
        }
        else
        {
            return "false";
        }
    }

    protected void btngeneratereport_Click(object sender, EventArgs e)
    {

        Session["ReportViewQuery"] = HttpContext.Current.Session["ReportQuery"];
        Response.Redirect("ReportViewer.aspx");

    }

}
