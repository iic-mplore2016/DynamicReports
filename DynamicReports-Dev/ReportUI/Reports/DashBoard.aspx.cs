using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Globalization;
public partial class Reports_DashBoard : System.Web.UI.Page
{
    SetLimitation s = new SetLimitation();
    BusinessLayer Config = new BusinessLayer();
    QueueLimitModel queueLimit = new QueueLimitModel();
    DropDownList rFormat;
    DropDownList rPriority;
    private string commandArgument;

    //SchedulerServices services = new SchedulerServices();
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
            DataTable dtList = Config.GetSavedReport();
            dashboardRepeater.DataSource = dtList;
            dashboardRepeater.DataBind();

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

            //DataTable logReportLists = Config.GetSchedulerLogStatus();
            //repeaterLogStatus.DataSource = logReportLists;
            //repeaterLogStatus.DataBind();

            DataTable searchQueue = Config.GetQueueLogResult();
            qrepeate1.DataSource = searchQueue;
            qrepeate1.DataBind();

            //DataTable queuedReportLists = Config.GetQueuedReport();
            //qRepeater.DataSource = queuedReportLists;
            //qRepeater.DataBind();
        }
        catch (Exception ex)
        {

            ExceptionLogging.SendErrorToText(ex);
        }
    }
    protected void AnchorButton_Click(object sender, EventArgs e)
    {
        LinkButton button = (sender as LinkButton);
        commandArgument = button.CommandArgument;
        RepeaterItem item = button.NamingContainer as RepeaterItem;
        rFormat = (DropDownList)item.FindControl("ddlFormat") as DropDownList;
        rPriority = (DropDownList)item.FindControl("ddlPriority") as DropDownList;

        if (setlimit.Value != "")
        {
            if (Int32.Parse(setlimit.Value) > 0)
            {
                if (limitation.Value != "")
                    limitation.Value = (Int32.Parse(limitation.Value) + 1).ToString();
                else
                    limitation.Value = "1";
            }

            if (Int32.Parse(limitation.Value) > Int32.Parse(setlimit.Value))
            {
                string script = "<script>";
                script += "alert('";
                script += "Limit Over Flow.....";
                script += "');";
                script += "</script>";
                ClientScript.RegisterStartupScript(typeof(Page), "alert", script);
            }
            else
            {
                //  addqueue();
            }
        }
        else
        {
            //   addqueue();
        }

    }




    protected void btnStatus_Click(object sender, EventArgs e)
    {

        LinkButton button = (sender as LinkButton);
        string commandArgument = button.CommandArgument;

        RepeaterItem item = button.NamingContainer as RepeaterItem;

        LinkButton button1 = (LinkButton)item.FindControl("btnStatus") as LinkButton;
        HiddenField query = (HiddenField)item.FindControl("hddnReportID") as HiddenField;
        Config.UpdateSchedulerReport(button1.Text, query.Value);
        try
        {
            DataTable dt1 = Config.GetScheduleReport();
            scheduledRepeater.DataSource = dt1;
            scheduledRepeater.DataBind();
        }
        catch (Exception ex)
        {

            ExceptionLogging.SendErrorToText(ex);
        }

    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        setlimit.Value = txtDay.Value;
    }

    protected void btnhideandshow_Click(object sender, EventArgs e)
    {

        LinkButton button = (sender as LinkButton);
        string commandArgument = button.CommandArgument;

        RepeaterItem item = button.NamingContainer as RepeaterItem;

        LinkButton button1 = (LinkButton)item.FindControl("btnhideandshow") as LinkButton;
        HiddenField query = (HiddenField)item.FindControl("hddnReportID") as HiddenField;
        Config.UpdateSchedulerReportHideAndShow(button1.Text, query.Value);

        try
        {
            DataTable dt1 = Config.GetScheduleReport();
            scheduledRepeater.DataSource = dt1;
            scheduledRepeater.DataBind();
        }
        catch (Exception ex)
        {

            ExceptionLogging.SendErrorToText(ex);
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        SearchModel model = new SearchModel();
        model.fromDate = txtsfrom.Text;
        model.toDate = txtsto.Text;
        model.fromTime = sfrmTime.Value;
        model.toTime = stoTime.Value;
        model.Status = ddlSearch.Items[ddlSearch.SelectedIndex].Text;

        DataTable tableSearch = Config.GetSearchResult(model);
        scheduledRepeater.DataSource = tableSearch;
        scheduledRepeater.DataBind();
    }

    protected void btnlogSearch_Click(object sender, EventArgs e)
    {
        SearchModel model = new SearchModel();
        //  string datestring = DateTime.Now.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture);
        model.fromDate = txtlogfrom.Text;
        model.toDate = txtlogto.Text;
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

    //protected void Button1_Click(object sender, EventArgs e)
    //{
    //    Button2.Enabled = false;
    //    Response.Redirect("Query_Builder.aspx");
    //}

    protected void viewButton_Click(object sender, EventArgs e)
    {
        GlobalValues.ServerType = WebConfigurationManager.ConnectionStrings["DBType"].ProviderName;
        GlobalValues.ServerName = WebConfigurationManager.ConnectionStrings["DBConnection"].ConnectionString;
        GlobalValues.ProviderName = WebConfigurationManager.ConnectionStrings["DBConnection"].ProviderName;
        GlobalValues.BuildQueries = string.Empty;
        LinkButton button = (sender as LinkButton);
        string queryArgument = button.CommandArgument;
        GlobalValues.ReportBuildQueries = queryArgument;
        Session["ReportViewQuery"] = queryArgument;
        Response.Redirect("ReportViewer.aspx");
    }
    protected void eidtButton_Click(object sender, EventArgs e)
    {
        GlobalValues.ServerType = WebConfigurationManager.ConnectionStrings["DBType"].ProviderName;
        GlobalValues.ServerName = WebConfigurationManager.ConnectionStrings["DBConnection"].ConnectionString;
        GlobalValues.ProviderName = WebConfigurationManager.ConnectionStrings["DBConnection"].ProviderName;
        GlobalValues.BuildQueries = string.Empty;
        LinkButton button = (sender as LinkButton);
        string queryArgument = button.CommandArgument;
        Session["EDITREPORTID"] = queryArgument;
        //GlobalValues.ReportBuildQueries = queryArgument;
        //Session["ReportViewQuery"] = queryArgument;
        Response.Redirect("Query_Builder.aspx");

    }
}

