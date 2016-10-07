using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Diagnostics;

public partial class Reports_QueueReport : System.Web.UI.Page
{
    QueueModel model = new QueueModel();
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

            DataTable queuedReportLists = Config.GetQueuedReport(model);
            queueReport.DataSource = queuedReportLists;
            queueReport.DataBind();
        }
        catch (Exception ex)
        {

            ExceptionLogging.SendErrorToText(ex);
        }

    }
    protected void btnDownloadFile_Click(object sender, EventArgs e)
    {

        string strFileType, strFilePath, strFileName;
        LinkButton button = (sender as LinkButton);
        string commandArgument = button.CommandArgument;
        RepeaterItem item = button.NamingContainer as RepeaterItem;
        LinkButton viewFile = (LinkButton)item.FindControl("btnView") as LinkButton;
        string[] view = viewFile.CommandArgument.Split(';');
        strFileName = view[0];
        strFileType = view[1];
        strFilePath = WebConfigurationManager.AppSettings["FilePath"];
        switch (strFileType)
        {

            case "Excel":
                Response.Redirect(strFilePath + strFileName);
                break;
            case "Html":
                Response.Redirect(strFilePath + strFileName);
                break;
        }
    }

    private void Download_File(string FilePath)
    {
        Response.ContentType = ContentType;
        Response.AppendHeader("Content-Disposition", "attachment; filename=" + Path.GetFileName(FilePath));
        Response.WriteFile(FilePath);
        Response.End();
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {

        model.fromDate = txtsfrom.Value;
        model.toDate = txtsto.Value;
        model.Status = ddlStatus.Value;
        try
        {

            DataTable queuedReportLists = Config.GetQueuedReport(model);
            queueReport.DataSource = queuedReportLists;
            queueReport.DataBind();
        }
        catch (Exception ex)
        {

            ExceptionLogging.SendErrorToText(ex);
        }

    }
}