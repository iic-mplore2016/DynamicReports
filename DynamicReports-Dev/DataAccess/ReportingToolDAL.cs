using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.Common;
using System.Data.SqlClient;
using System.Data;
using System.Web;
using System.Web.Configuration;
//using Oracle.DataAccess.Client;
//using Oracle.DataAccess.Types;
//using Oracle.ManagedDataAccess.Client;
public class ReportingToolDAL
{

    DataBaseFactory db = new DataBaseFactory();

    public DataTable TableExist()
    {
        DataTable dt = new DataTable();
        string query = "";
        if (GlobalValues.ServerType == "Sql")
            query = WebConfigurationManager.AppSettings["SqlTablesExist"];
        if (GlobalValues.ServerType == "Oracle")
            query = WebConfigurationManager.AppSettings["OracleTablesExist"];

        dt = db.ExecuteSQLQuery(query);
        return dt;

    }
    public DataTable ReadTables()
    {
        DataTable dt = new DataTable();
        string query = "";
        if (GlobalValues.ServerType == "Sql")
            query = WebConfigurationManager.AppSettings["SqlTables"];
        if (GlobalValues.ServerType == "Oracle")
            query = WebConfigurationManager.AppSettings["OracleTables"];


        dt = db.ExecuteSQLQuery(query);
        return dt;

    }
    public DataTable ReadTablesAll(string values)
    {
        DataTable dt = new DataTable();
        string query = "";
        if (GlobalValues.ServerType == "Sql")
        {
            if (values == "Tables")
                query = WebConfigurationManager.AppSettings["SqlTables"];
            if (values == "Views")
                query = WebConfigurationManager.AppSettings["SqlViews"];
            if (values == "Both")
                query = WebConfigurationManager.AppSettings["SqlTablesViews"];
        }

        if (GlobalValues.ServerType == "Oracle")
        {
            if (values == "Tables")
                query = WebConfigurationManager.AppSettings["OracleTables"];
            if (values == "Views")
                query = WebConfigurationManager.AppSettings["OracleViews"];
            if (values == "Both")
                query = WebConfigurationManager.AppSettings["OracleTablesViews"];
        }

        dt = db.ExecuteSQLQuery(query);
        return dt;

    }

    public DataTable ReadColumns(string row)
    {
        DataTable dt = new DataTable();
        string query = "";
        if (GlobalValues.ServerType == "Sql")
            query = WebConfigurationManager.AppSettings["SqlColumns"] + "'" + row + "'";
        if (GlobalValues.ServerType == "Oracle")
            query = WebConfigurationManager.AppSettings["OracleColumns"] + "'" + row + "' order by COLUMN_ID";

        dt = db.ExecuteSQLQuery(query);
        return dt;
    }
    public string ReadprimaryKey(string tableName)
    {
        DataTable dt = new DataTable();
        string query = "";
        string ID = "";
        if (GlobalValues.ServerType == "Sql")
        {
            query = WebConfigurationManager.AppSettings["SqlPrimaryKeyString"];
            query += "'" + tableName + "'";
            query += WebConfigurationManager.AppSettings["SqlPrimaryKeyStringPlus"];
        }
        else
        {
            query = WebConfigurationManager.AppSettings["OraclePrimaryKeyString"];
            query += "'" + tableName + "'";
            query += WebConfigurationManager.AppSettings["OraclePrimaryKeyStringPlus"];

        }
        dt = db.ExecuteSQLQuery(query);
        ID = dt.Rows[0]["COLUMN_NAME"].ToString();
        return ID;
    }

    public DataTable CheckReportName(string repName)
    {
        DataTable dt = new DataTable();
        string query = "select RPRT_NAM from SAVD_RPRT where RPRT_NAM ='" + repName + "'";
        dt = db.ExecuteSQLQuery(query);
        return dt;
    }

    public DataTable ViewModule()
    {
        DataTable dt = new DataTable();
        string query = "select * from module";
        dt = db.ExecuteSQLQuery(query);
        return dt;
    }
    public DataTable ViewReport(string query)
    {
        DataTable dt = new DataTable();
        dt = db.ExecuteSQLQuery(query);
        return dt;
    }

    public int SaveReport(SaveReportModel model)
    {
        int newID = 0;

        if (GlobalValues.ServerType == "Sql")
        {
            SqlParameter[] param = { new SqlParameter("@rname", model.ReportName),
                                 new SqlParameter("@arole", model.AssignRole),
                                 new SqlParameter("@cstring", GlobalValues.ServerName),
                                 new SqlParameter("@qbuild", model.QueryBuilder),
                                 new SqlParameter("@rtype", model.ReportType),
                                 new SqlParameter("@sdate", DateTime.Now.ToString("dd-MMM-yyyy"))};
            newID = db.ExecuteNoneSP("SP_SAVD_RPRT", param);
        }
        else
        {
            string query = " insert into SAVD_RPRT(RPRT_NAM,ASSN_ROL,CONN_STRNG,QRY_STRNG,RPRT_TYP,UPDAT_DT,GRP_STRNG) values('" + model.ReportName + "','" + model.AssignRole + "','" + GlobalValues.ServerName + "','" + model.QueryBuilder + "','" + model.ReportType + "','" + DateTime.Now.ToString("dd-MMM-yyyy") + "','" + model.Grouping + "')RETURNING RPRT_ID INTO :p_rid";
            newID = db.ExecuteNoneSPOrcale(query);
        };

        return newID;
    }
    public int SaveReportFields(SaveReportModel model)
    {
        string query = "insert into RPRT_FLD(FLD_NAM,UPDT_DT,RPRT_Id) values";

        query += "('" + model.FieldName + "','" + DateTime.Now.ToString("dd-MMM-yyyy") + "','" + model.ReportId + "')";

        int result = 0;
        db.ExecuteNonQuery(query);
        return result;

    }
    public int SaveReportFilterFields(SaveReportModel model)
    {
        string query = "insert into FIELD_CONDITION(RPRT_Id,isDISPLAY,PRMTR_TYP,PRMTR_QRY,CLMN_NAM,DISPLAY_NAM,isFILTER,PRE_CON,AGGREGATION,ORDER_NO,SORTBY,DATE_TYP,UPDT_DT) values";

        query += "('" + model.ReportId + "','" + model.IsDisplay + "','" + model.parameterType + "','" + model.parameterQuery + "','" + model.LabelColumn + "','" + model.DisplayName + "','" + model.isFilter + "','" + model.Precondition + "','" + model.Aggregation + "','" + model.orderNo + "','" + model.SortBy + "','" + model.dateType + "','" + DateTime.Now.ToString("dd-MMM-yyyy") + "')";

        int result = 0;
        db.ExecuteNonQuery(query);
        return result;

    }


    public int SaveScheduleReport(SaveReportModel model)
    {
        string query = query = "insert into SCHLD_RPRTS(RPRT_Id,RCRN_TYP,RPRT_DT,RPRT_TM,SAVD_LOC,EML_LST,WK_NAM,QUE_ACTY,PROV,RPRT_FMRT,UPDAT_DT) values";

        query += "('" + model.ReportId + "','" + model.RecurrenceType + "','" + DateTime.Now.ToString("dd-MMM-yyyy") + "','" + model.ReportTime + "','" + model.SaveLocation + "','" + model.SendEmail + "','" + model.DayWise + "','" + "Start" + "','" + "Show" + "','" + model.ReportFormat + "','" + DateTime.Now.ToString("dd-MMM-yyyy") + "')";


        int result = 0;
        db.ExecuteNonQuery(query);
        return result;
    }

    public int SaveActivityTable(iInterchangeModel activity)
    {

        string query = "insert into Activity(ACTVTY_ID,ACTVTY_NAM,ACTVTY_TYP_ID,ACTVTY_DSCRPTN,LST_BT,MY_SBMT_BT,MDL_ID,MNU_TXT,MNU_ORDR,CRT_BT,EDT_BT,ACTV_BT,GUID,HD_QRTRS_ID,LST_CLMN_CNT,MY_SBMT_CLMN_CNT,CNCL_BT,DRFT_BT,ACTVTY_CPTN) values";
        query += "('" + activity.ActivityID + "','" + activity.ActivityName + "','" + activity.ActivityTypeID + "','" + activity.ActivityDescription + "','" + activity.ListBit + "','" + activity.MySubmitBit + "','" + activity.ModuleID + "','" + activity.Menutext + "','" + activity.MenuOrder + "','" + activity.CreateBit + "','" + activity.EditBit + "','" + activity.ActivityBit + "','" + activity.GUID + "','" + activity.HDQRTRSID + "','" + activity.ListColumnCount + "','" + activity.MySubmitColumnBit + "','" + activity.CancelBit + "','" + activity.DifferentBit + "','" + activity.ActivityCaption + "')";
        //query += "('" + activity.ActivityID + "','" + activity.ActivityName + "','5','Reports','0','0','" + activity.ModuleID + "','" + activity.Menutext + "','1','0','0','1','" + activity.GUID + "','1','0','0','0','0','" + activity.ActivityCaption + "')";

        int result = 0;
        db.ExecuteNonQuery(query);
        return result;
    }

    public int SaveParameterTable(iInterchangeModel parameter)
    {
        string query = "insert into REPORT_PARAMETER(RPRT_ID,PRMTR_NAM,PRMTR_DSPLY_NAM,PRMTR_TYP,PRMTR_QRY,PRMTR_OPT,REQ_DPT_ID,PRMTR_ORDR_CLMN,PRMTR_ORDR_TYP,PRMTR_DRPDWN,SCHMA_CLMN_NM,CMPNY_ID,ORDR_NO,ACTV_BT) values";
        query += "('" + parameter.ReportId + "','" + parameter.DisplayName + "','" + parameter.DisplayName + "','" + parameter.ParameterType + "','" + parameter.ParameterQuery + "','" + parameter.ParameterOperator + "','" + parameter.RequertDeptID + "','" + parameter.ParameterOrderColumn + "','" + parameter.ParameterOrderType + "','" + parameter.ParameterDropdown + "','" + parameter.ActualColumn + "','" + parameter.CompanyID + "','" + parameter.OrderNo + "','" + parameter.ActivityBit + "')";
        //query += "('" + parameter.ReportId + "','" + parameter.DisplayName + "','" + parameter.DisplayName + "','" + parameter.ParameterType + "','" + parameter.ParameterQuery + "','0','0','" + parameter.ParameterOrderColumn + "','" + parameter.ParameterOrderType + "','0','" + parameter.ActualColumn + "','1','1','1')";

        int result = 0;
        db.ExecuteNonQuery(query);
        return result;
    }
    public DataTable ReadMasterTable(string column, int id)
    {
        DataTable dt = new DataTable();
        string query = "select MPPING_QRY from MASTER_LOOKUP where LKUP_CLMN='" + column + "' and RPRT_ID='" + id + "'";
        dt = db.ExecuteSQLQuery(query);
        return dt;
    }


    public int SaveAssociationTable(iInterchangeModel master)
    {

        string query = "insert into ACTIVITY_ASSOCIATION(ACTVTY_ASSCTN_ID,ACTVTY_ID,USR_TYP_ID) values";
        query += "(" + master.AssociationID + ",'" + master.ActivityID + "','" + master.UserTypeID + "')";
        int result = 0;
        db.ExecuteNonQuery(query);
        return result;
    }
    public DataTable ViewSaveReport()
    {
        DataTable dt = new DataTable();
        string query = "select * from SAVD_RPRT";
        dt = db.ExecuteSQLQuery(query);
        return dt;

    }

    public DataTable ViewScheduleReport()
    {
        DataTable dt = new DataTable();
        string query = "select SAVD_RPRT.RPRT_Id, SAVD_RPRT.RPRT_NAM,SAVD_RPRT.ASSN_ROL,SCHLD_RPRTS.RPRT_DT,SCHLD_RPRTS.RPRT_TM,SCHLD_RPRTS.QUE_ACTY,SCHLD_RPRTS.PROV from SCHLD_RPRTS left join SAVD_RPRT on SCHLD_RPRTS.RPRT_ID=SAVD_RPRT.RPRT_ID";
        dt = db.ExecuteSQLQuery(query);
        return dt;
    }

    public void UpdateSchedulerReport(string status, string id)
    {
        string query = "update SCHLD_RPRTS set QUE_ACTY='" + status + " where RPRT_Id='" + id + "'";
        db.ExecuteNonQuery(query);
    }
    public void UpdateSchedulerReportHideAndShow(string status, string id)
    {
        string query = "update SCHLD_RPRTS set PROV='" + status + " where RPRT_Id='" + id + "'";
        db.ExecuteNonQuery(query);
    }
    public DataTable SchedulerLogStatus()
    {
        DataTable dt = new DataTable();
        string query = "select * from SCHED_LOG_STATUS";
        dt = db.ExecuteSQLQuery(query);
        return dt;
    }
    public DataTable ViewQueuedReport(QueueModel queue)
    {
        DataTable dt = new DataTable();

        string query = "select RPRT_TTL ,RPRT_NAM, RPRT_FRMT ,CRTD_BY ,CRTD_DT ,GNRTD_DT ,STTS,FL_NAM from QUEUE_REPORT where QUE_ID!=0";
        if (queue.fromDate != null && queue.fromDate != "" && queue.toDate != null && queue.toDate != "")
        {
            DateTime fromdate = DateTime.ParseExact(queue.fromDate, "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture);
            DateTime todate = DateTime.ParseExact(queue.toDate, "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture);
            query += " and GNRTD_DT between '" + fromdate.ToString("dd-MMM-yyyy") + "' and '" + todate.ToString("dd-MMM-yyyy") + "'";
        }
        if (queue.Status != null && queue.Status != "Please Select")
            query += " and STTS ='" + queue.Status + "'";
        query += " order by GNRTD_DT desc,QUE_ID desc";
        dt = db.ExecuteSQLQuery(query);
        return dt;
    }
    public DataTable SearchResult(SearchModel model)
    {
        DataTable dt = new DataTable();
        string query = "select SAVD_RPRT.RPRT_Id, SAVD_RPRT.RPRT_NAM,SAVD_RPRT.ASSN_ROL,SCHLD_RPRTS.RPRT_DT,SCHLD_RPRTS.RPRT_TM,SCHLD_RPRTS.QUE_ACTY,SCHLD_RPRTS.PROV from SAVD_RPRT left join  SCHLD_RPRTS on SCHLD_RPRTS.RPRT_Id=SAVD_RPRT.RPRT_Id  where SAVD_RPRT.RPRT_Id !=0 ";

        if (model.fromDate != "" && model.toDate != "")
        {
            DateTime fromdate = DateTime.ParseExact(model.fromDate, "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture);
            DateTime todate = DateTime.ParseExact(model.toDate, "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture);
            query += " and SCHLD_RPRTS.RPRT_DT between '" + fromdate.ToString("dd-MMM-yyyy") + "' and '" + todate.ToString("dd-MMM-yyyy") + "'";
        }
        if (model.fromTime != "12:00 AM" && model.toTime != "12:00 AM")
        {
            query += " and SCHLD_RPRTS.RPRT_TM between '" + model.fromTime + "' and '" + model.toTime + "'";
        }
        if (model.Status != "")
        {
            query += " and SCHLD_RPRTS.QUE_ACTY='" + model.Status + "'";
        }
        dt = db.ExecuteSQLQuery(query);
        return dt;
    }

    public DataTable SearchLogResult(SearchModel model)
    {
        DataTable dt = new DataTable();
        string query = "select * from SCHED_LOG_STATUS where SCHLD_ID !=0";

        if (model.fromDate != "" && model.toDate != "")
        {
            DateTime fromdate = DateTime.ParseExact(model.fromDate, "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture);
            DateTime todate = DateTime.ParseExact(model.toDate, "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture);
            query += " and RPRT_DT between '" + fromdate.ToString("dd-MMM-yyyy") + "' and '" + todate.ToString("dd-MMM-yyyy") + "'";
        }
        if (model.fromTime != "12:00 AM" && model.toTime != "12:00 AM")
        {
            query += " and RPRT_TM between '" + model.fromTime + "' and '" + model.toTime + "'";
        }
        //if (model.Status != "")
        //{
        //    query += " SCHLD_RPRTS.QUE_ACTY='" + model.Status + "'";
        //}
        dt = db.ExecuteSQLQuery(query);
        return dt;
    }


    public DataTable QueueLogResult()
    {
        DataTable dt = new DataTable();
        string query = "select SAVD_RPRT.RPRT_NAM,SAVD_RPRT.ASSN_ROL,QUE_RPRT.RPRT_ID,QUE_RPRT.UPDT_DT,QUE_RPRT.QUE_ID from QUE_RPRT left join SAVD_RPRT on QUE_RPRT.RPRT_ID=SAVD_RPRT.RPRT_ID where QUE_RPRT.FLG=0";
        dt = db.ExecuteSQLQuery(query);
        return dt;
    }

    public DataTable SearchQueueLogResult(SearchModel model)
    {
        DataTable dt = new DataTable();
        string query = "select SAVD_RPRT.RPRT_NAM,SAVD_RPRT.ASSN_ROL,QUE_RPRT.RPRT_ID,QUE_RPRT.UPDT_DT,QUE_RPRT.QUE_ID from QUE_RPRT left join SAVD_RPRT on QUE_RPRT.RPRT_ID=SAVD_RPRT.RPRT_ID where QUE_RPRT.FLG=0";

        if (model.fromDate != "" && model.toDate != "")
        {
            DateTime fromdate = DateTime.ParseExact(model.fromDate, "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture);
            DateTime todate = DateTime.ParseExact(model.toDate, "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture);
            query += " and UPDT_DT between '" + fromdate.ToString("dd-MMM-yyyy") + "' and '" + todate.ToString("dd-MMM-yyyy") + "'";
        }
        //if (model.fromTime != "12:00 AM" && model.toTime != "12:00 AM")
        //{
        //    query += " and RPRT_TM between '" + model.fromTime + "' and '" + model.toTime + "'";
        //}
        //if (model.Status != "")
        //{
        //    query += " SCHLD_RPRTS.QUE_ACTY='" + model.Status + "'";
        //}
        dt = db.ExecuteSQLQuery(query);
        return dt;
    }
    public DataTable ViewExingColumns(string Table, string rTable)
    {
        DataTable dt = new DataTable();
        string query = "";
        if (GlobalValues.ServerType == "Sql")
        {
            query = " SELECT f.name AS ForeignKey,OBJECT_NAME(f.parent_object_id) AS TableName,COL_NAME(fc.parent_object_id, fc.parent_column_id) AS ColumnName,OBJECT_NAME (f.referenced_object_id) AS ReferenceTableName,COL_NAME(fc.referenced_object_id, fc.referenced_column_id) AS ReferenceColumnName FROM sys.foreign_keys AS f INNER JOIN sys.foreign_key_columns AS fc ";
            query += " ON f.OBJECT_ID = fc.constraint_object_id WHERE  OBJECT_NAME(f.parent_object_id) = '" + Table + "' AND OBJECT_NAME (f.referenced_object_id) ='" + rTable + "'";
        }
        else
        {
            query = "SELECT CONS.CONSTRAINT_NAME,CONS.TABLE_NAME as TableName,COLS.COLUMN_NAME as ColumnName,CONS.R_CONSTRAINT_NAME,CONS_R.TABLE_NAME as ReferenceTableName,COLS_R.COLUMN_NAME as ReferenceColumnName FROM USER_CONSTRAINTS CONS LEFT JOIN USER_CONS_COLUMNS COLS ON COLS.CONSTRAINT_NAME = CONS.CONSTRAINT_NAME LEFT JOIN USER_CONSTRAINTS CONS_R ON CONS_R.CONSTRAINT_NAME = CONS.R_CONSTRAINT_NAME LEFT JOIN USER_CONS_COLUMNS COLS_R ON COLS_R.CONSTRAINT_NAME = CONS.R_CONSTRAINT_NAME";
            query += " WHERE CONS.TABLE_NAME = '" + Table + "' AND CONS_R.TABLE_NAME = '" + rTable + "'";
        }
        dt = db.ExecuteSQLQuery(query);
        return dt;

    }
    public int SaveMaster(MasterLookUp model)
    {
        int newID = 0;

        if (GlobalValues.ServerType == "Sql")
        {
            //SqlParameter[] param = { new SqlParameter("@rname", model.ReportName),
            //                     new SqlParameter("@arole", model.AssignRole),
            //                     new SqlParameter("@cstring", GlobalValues.ServerName),
            //                     new SqlParameter("@qbuild", model.QueryBuilder),
            //                     new SqlParameter("@rtype", model.ReportType),
            //                     new SqlParameter("@sdate", DateTime.Now.ToString("dd-MMM-yyyy"))};
            //newID = db.ExecuteNoneSP("SP_SAVD_RPRT", param);
        }
        else
        {
            string query = " insert into MASTER_LOOKUP(RPRT_ID,LKUP_CLMN,SCHM_TYP,TBL_NAM,MPPNG_FLD,MPPING_QRY) values('" + model.ReportID + "','" + model.LabelColumn + "','" + model.LookUpType + "','" + model.TableName + "','" + model.MappingField + "','" + model.LookUpQuery + "')RETURNING LKUP_ID INTO :p_rid";
            newID = db.ExecuteNoneSPOrcale(query);
        };

        return newID;
    }
    public int SaveMasterFields(MasterLookUp column)
    {
        string query = "insert into LOOKUP_FIELD(LKUP_ID,CLMN_NAM,RPRT_ID,DSPLY_NAM) values";

        query += "('" + column.LookUpID + "','" + column.ActualColumn + "','" + column.ReportID + "','" + column.DisplayName + "')";

        int result = 0;
        db.ExecuteNonQuery(query);
        return result;

    }
    public int SaveMjoinFields(TableJoin tjoin)
    {
        string query = "insert into JOIN_TABLE(RPRT_Id,FLD_LFT,JN_TYP,FLD_RGHT) values";
        query += "('" + tjoin.repId + "','" + tjoin.fieldLeft + "','" + tjoin.joinType + "','" + tjoin.fieldRight + "')";

        int result = 0;
        db.ExecuteNonQuery(query);
        return result;
    }
}

