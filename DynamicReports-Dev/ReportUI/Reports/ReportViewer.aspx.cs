using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Reports_ReportViewer : System.Web.UI.Page
{
    BusinessLayer Config = new BusinessLayer();
    DataTable dt = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            filterRepeater.DataSource = GlobalValues.CustomFields.Where(filter => filter.IsFilter == true).ToList();
            filterRepeater.DataBind();

        }

    }
    protected void OnItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            DropDownList ddlFilter = e.Item.FindControl("ddlFilter") as DropDownList;
            DropDownList ddlMore = e.Item.FindControl("ddlMore") as DropDownList;
            ddlFilter.DataSource = ListHelper.Filter();
            ddlFilter.DataBind();
            try
            {
                ddlMore.DataSource = ListHelper.FilterMore();
                ddlMore.DataBind();
            }
            catch (Exception ex)
            {

                ExceptionLogging.SendErrorToText(ex);
            }
        }
    }
    protected void btnRun_Click(object sender, EventArgs e)
    {
        Session["ReportViewQuery"] = null;
        string whereCondition = "";
        foreach (RepeaterItem gr in filterRepeater.Items)
        {
            var cName = (HiddenField)gr.FindControl("hfcName");
            var ddlFilter = (DropDownList)gr.FindControl("ddlFilter") as DropDownList;
            var ddlMore = (DropDownList)gr.FindControl("ddlMore") as DropDownList;
            var txt = (TextBox)gr.FindControl("txtFilter") as TextBox;
            string field = cName.Value;
            string ddl1 = ddlFilter.SelectedItem.Text;
            string ddl2 = ddlMore.SelectedItem.Text;
            if (string.IsNullOrEmpty(txt.Text) == false)
                whereCondition += " " + field + ddl1 + "'" + txt.Text + "'" + " " + ddl2;

        }

        string filterQuery = "";

        if (string.IsNullOrEmpty(GlobalValues.FilterQuery) == false)
        {
            filterQuery += GlobalValues.FilterQuery;
        }
        if (string.IsNullOrEmpty(whereCondition) == false)
        {
            filterQuery += " Where " + whereCondition.Substring(0, whereCondition.LastIndexOf(" ")).Trim();
        }
        if (string.IsNullOrEmpty(GlobalValues.FilterWhere) == false)
        {
            filterQuery += GlobalValues.FilterWhere;
        }
        if (string.IsNullOrEmpty(GlobalValues.SortOrderFields) == false)
        {
            filterQuery += " order by " + GlobalValues.SortOrderFields.TrimEnd(',');
        }
        if (string.IsNullOrEmpty(GlobalValues.FilterQuery) == false)
            Session["ReportViewQuery"] = filterQuery;


    }

}