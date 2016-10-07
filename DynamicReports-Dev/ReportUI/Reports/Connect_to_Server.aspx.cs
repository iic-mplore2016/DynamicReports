using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;
public partial class Reports_Connect_to_Server : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadDataBase();
        }
    }

    protected void LoadDataBase()
    {
        GlobalValues.ServerType = string.Empty;
        GlobalValues.ServerName = string.Empty;
        GlobalValues.ServerType = string.Empty;

        //ddlServerType.DataSource = ListHelper.ServerType();
        //ddlServerType.DataBind();

        GlobalValues.ServerType = WebConfigurationManager.ConnectionStrings["DBType"].ProviderName;
        GlobalValues.ServerName = WebConfigurationManager.ConnectionStrings["DBConnection"].ConnectionString;
        GlobalValues.ProviderName = WebConfigurationManager.ConnectionStrings["DBConnection"].ProviderName;
        dataSource.Value = GlobalValues.ServerName;
    }
    protected void btnConnect_Click(object sender, EventArgs e)
    {
        Response.Redirect("DashBoard.aspx");
    }

}