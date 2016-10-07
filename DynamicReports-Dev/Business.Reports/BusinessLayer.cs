using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
public class BusinessLayer
{
    //ReportingToolDAL_SQL DAL = new ReportingToolDAL_SQL();
    ReportingToolDAL DAL = new ReportingToolDAL();

    //public void Conn_String(string Query)
    //{
    //    DAL.Connect_to_Server(Query);
    //}
    public DataTable GetExistTbales()
    {
        return DAL.TableExist();
    }
    public DataTable GetDataTables()
    {
        return DAL.ReadTables();
    }

    public DataTable GetDataTablesAll(string name)
    {
        return DAL.ReadTablesAll(name);
    }

    public DataTable GetReportName(string repName)
    {
        return DAL.CheckReportName(repName);
    }

    public DataTable GetColumns(string row)
    {
        return DAL.ReadColumns(row);
    }
    public string GetPrimaryKey(string tableName)
    {
        return DAL.ReadprimaryKey(tableName);
    }
    public DataTable GetReport(string Query)
    {
        return DAL.ViewReport(Query);
    }

    public DataTable GetModule()
    {
        return DAL.ViewModule();
    }
    public int SaveReport(SaveReportModel model)
    {
        return DAL.SaveReport(model);
    }
    public void SaveReportFields(SaveReportModel model)
    {
        DAL.SaveReportFields(model);
    }
    public void SaveReportFilterFields(SaveReportModel model)
    {
        DAL.SaveReportFilterFields(model);
    }

    public DataTable GetSavedReport()
    {
        return DAL.ViewSaveReport();
    }
    public void SaveScheduleReport(SaveReportModel model)
    {
        DAL.SaveScheduleReport(model);
    }
   
    public void SaveActivityTable(iInterchangeModel model)
    {
        DAL.SaveActivityTable(model);
    }

    public void SaveParameterTable(iInterchangeModel model)
    {
        DAL.SaveParameterTable(model);
    }

    public void SaveMjoinFields(TableJoin tj)
    {
        DAL.SaveMjoinFields(tj);
    }
    public void SaveAssociationTable(iInterchangeModel model)
    {
        DAL.SaveAssociationTable(model);
    }
    public DataTable GetScheduleReport()
    {
        return DAL.ViewScheduleReport();
    }

    public void UpdateSchedulerReport(string status, string id)
    {
        DAL.UpdateSchedulerReport(status, id);
    }
    public DataTable GetSchedulerLogStatus()
    {
        return DAL.SchedulerLogStatus();
    }
    public DataTable GetQueuedReport(QueueModel queue)
    {
        return DAL.ViewQueuedReport(queue);
    }
    public DataTable GetMasterTable(string column, int id)
    {
        return DAL.ReadMasterTable(column, id);
    }

    public DataTable GetSearchResult(SearchModel model)
    {
        return DAL.SearchResult(model);
    }
    public DataTable GetSearchLogResult(SearchModel model)
    {
        return DAL.SearchLogResult(model);
    }

    public DataTable GetSearchQueueLogResult(SearchModel model)
    {
        return DAL.SearchQueueLogResult(model);
    }
    public DataTable GetQueueLogResult()
    {
        return DAL.QueueLogResult();
    }
   
    public void UpdateSchedulerReportHideAndShow(string status, string id)
    {
        DAL.UpdateSchedulerReportHideAndShow(status, id);
    }
    public DataTable GetExingColumns(string cols, string names)
    {
        return DAL.ViewExingColumns(cols, names);
    }

    public int SaveMaster(MasterLookUp model)
    {
        return DAL.SaveMaster(model);
    }
    public void SaveMasterFields(MasterLookUp column)
    {
        DAL.SaveMasterFields(column);
    }
}
