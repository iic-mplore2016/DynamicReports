using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Reports_ScheduledReport : System.Web.UI.Page
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
            DataTable scheduledReportLists = Config.GetScheduleReport();
            scheduledRepeater.DataSource = scheduledReportLists;
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
        model.fromDate = txtsfrom.Value;
        model.toDate = txtsto.Value;
        model.fromTime = sfrmTime.Value;
        model.toTime = stoTime.Value;
        model.Status = ddlSearch.Items[ddlSearch.SelectedIndex].Text;

        DataTable tableSearch = Config.GetSearchResult(model);
        scheduledRepeater.DataSource = tableSearch;
        scheduledRepeater.DataBind();
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
}