using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Reports_SheduledRportLog : System.Web.UI.Page
{
    BusinessLayer Config = new BusinessLayer();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadData();

        }
    }
    protected void LoadData()
    {
        GlobalValues.ServerType = WebConfigurationManager.ConnectionStrings["DBType"].ProviderName;
        GlobalValues.ServerName = WebConfigurationManager.ConnectionStrings["DBConnection"].ConnectionString;
        GlobalValues.ProviderName = WebConfigurationManager.ConnectionStrings["DBConnection"].ProviderName;
        try
        {
            //DataTable dtList = Config.GetSavedReport();
            //dashboardRepeater.DataSource = dtList;
            //dashboardRepeater.DataBind();

            //string aa = dtList.Rows[0]["RPRT_DT"].ToString();
            //string bb = dtList.Rows[0]["RPRT_TM"].ToString();

            //// DateTime dt = DateTime.ParseExact(aa, "MM/dd/yyyy hh:mm:ss tt", CultureInfo.InvariantCulture);
            ////  string aaa = DateTime.ParseExact(aa, "yyyy-MM-dd", System.Globalization.CultureInfo.InvariantCulture);
            //// string datestring = DateTime.Now.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture);
            //// string nnn = fromdate.ToString("dd-MMM-yyyy");
            //string ccc = DateTime.Today.ToString("dd-MMM-yyyy");


            //DataTable scheduledReportLists = Config.GetScheduleReport();
            //scheduledRepeater.DataSource = scheduledReportLists;
            //scheduledRepeater.DataBind();

            DataTable logReportLists = Config.GetSchedulerLogStatus();
            repeaterLogStatus.DataSource = logReportLists;
            repeaterLogStatus.DataBind();

            //DataTable searchQueue = Config.GetQueueLogResult();
            //qrepeate1.DataSource = searchQueue;
            //qrepeate1.DataBind();

            //DataTable queuedReportLists = Config.GetQueuedReport();
            //qRepeater.DataSource = queuedReportLists;
            //qRepeater.DataBind();
        }
        catch (Exception ex)
        {

            ExceptionLogging.SendErrorToText(ex);
        }
    }
    protected void btnlogSearch_Click(object sender, EventArgs e)
    {
        SearchModel model = new SearchModel();
        //  string datestring = DateTime.Now.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture);
        model.fromDate = txtlogfrom.Value;
        model.toDate = txtlogto.Value;
        model.fromTime = txtfromtime.Value;
        model.toTime = txttotime.Value;
        try
        {
            DataTable tableSearch = Config.GetSearchLogResult(model);
            repeaterLogStatus.DataSource = tableSearch;
            repeaterLogStatus.DataBind();

            DataTable searchQueue = Config.GetSearchQueueLogResult(model);
            qrepeate1.DataSource = searchQueue;
            qrepeate1.DataBind();
        }
        catch (Exception ex)
        {

            ExceptionLogging.SendErrorToText(ex);
        }
    }
}