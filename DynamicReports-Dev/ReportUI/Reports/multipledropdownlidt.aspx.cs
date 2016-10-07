using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Reports_multipledropdownlidt : System.Web.UI.Page
{
    BusinessLayer Config = new BusinessLayer();
    DataTable table = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            SetInitialRow();
    }

    private DataTable bind()
    {
        DataTable table = Config.GetDataTables();
        return table;
    }
    private void FillDropDownList(DropDownList ddl)
    {
        DataTable dt = bind();
        foreach (DataRow row in dt.Rows)
        {
            foreach (DataColumn column in dt.Columns)
            {
                ddl.Items.Add(row[column].ToString());
                //   Console.WriteLine(row[column]);
            }
        }
    }

    protected void DropDownA_SelectedIndexChanged(object sender, EventArgs e)
    {

        GridViewRow gvr = (GridViewRow)((DropDownList)sender).Parent.Parent;
        // Now convert sender as dropdown which is fired and you can get all the properties   of the dropdown
        DropDownList ddl = (DropDownList)sender;
        // Now fetch the data from the database based on selected drodpwon and bind that data to another dropdown this way
        DropDownList ddlsecond = gvr.FindControl("DropDownList2") as DropDownList;
        ddlsecond.Items.Clear();
        // ddlsecond.SelectedIndex = -1;
        DataTable table = new DataTable();

        table = Config.GetColumns(ddl.SelectedItem.Value);
        ddlsecond.DataSource = table;

        ddlsecond.DataTextField = table.Columns["All_Columns"].ToString();
        ddlsecond.DataValueField = table.Columns["All_Columns"].ToString();
        ddlsecond.DataBind();
        ddlsecond.Items.Insert(0, "--Select--");


    }
    protected void DropDownB_SelectedIndexChanged(object sender, EventArgs e)
    {

        GridViewRow gvr = (GridViewRow)((DropDownList)sender).Parent.Parent;
        // Now convert sender as dropdown which is fired and you can get all the properties   of the dropdown
        DropDownList ddl = (DropDownList)sender;
        // Now fetch the data from the database based on selected drodpwon and bind that data to another dropdown this way
        DropDownList ddlsecond = gvr.FindControl("DropDownList4") as DropDownList;
        ddlsecond.Items.Clear();
        // ddlsecond.SelectedIndex = -1;
        DataTable table = new DataTable();

        table = Config.GetColumns(ddl.SelectedItem.Value);
        ddlsecond.DataSource = table;

        ddlsecond.DataTextField = table.Columns["All_Columns"].ToString();
        ddlsecond.DataValueField = table.Columns["All_Columns"].ToString();
        ddlsecond.DataBind();
        ddlsecond.Items.Insert(0, "--Select--");


    }
    private void SetInitialRow()
    {
        GlobalValues.ServerType = WebConfigurationManager.ConnectionStrings["DBType"].ProviderName;
        GlobalValues.ServerName = WebConfigurationManager.ConnectionStrings["DBConnection"].ConnectionString;
        GlobalValues.ProviderName = WebConfigurationManager.ConnectionStrings["DBConnection"].ProviderName;
        DataTable dt = new DataTable();
        DataRow dr = null;

        //Define the Columns
        dt.Columns.Add(new DataColumn("RowNumber", typeof(string)));
        dt.Columns.Add(new DataColumn("Column1", typeof(string)));
        dt.Columns.Add(new DataColumn("Column2", typeof(string)));
        dt.Columns.Add(new DataColumn("Column3", typeof(string)));
        dt.Columns.Add(new DataColumn("Column4", typeof(string)));
        //Add a Dummy Data on Initial Load
        dr = dt.NewRow();
        dr["RowNumber"] = 1;
        dt.Rows.Add(dr);

        //Store the DataTable in ViewState
        ViewState["CurrentTable"] = dt;
        //Bind the DataTable to the Grid
        Gridview1.DataSource = dt;
        Gridview1.DataBind();

        //Extract and Fill the DropDownList with Data
        DropDownList ddl1 = (DropDownList)Gridview1.Rows[0].FindControl("DropDownList1");
        DropDownList ddl2 = (DropDownList)Gridview1.Rows[0].FindControl("DropDownList2");
        DropDownList ddl3 = (DropDownList)Gridview1.Rows[0].FindControl("DropDownList3");
        DropDownList ddl4 = (DropDownList)Gridview1.Rows[0].FindControl("DropDownList4");



        FillDropDownList(ddl1);
        FillDropDownList(ddl3);
        // DropDownList ddl3 = (DropDownList)Gridview1.Rows[0].Cells[3].FindControl("DropDownList3");
        //  FillDropDownList(ddl1);
        //DataTable dts = Config.GetDataTables();
        //ddl1.DataSource = dts;
        //ddl1.DataTextField = dts.Columns["name"].ToString();
        //ddl1.DataValueField = dts.Columns["name"].ToString();
        //ddl1.DataBind();
        ////  DataTable dts = Config.GetColumns("Categories");
        //ddl3.DataSource = dts;
        //ddl3.DataTextField = dts.Columns["name"].ToString();
        //ddl3.DataValueField = dts.Columns["name"].ToString();
        //ddl3.DataBind();
    }
    private void AddNewRowToGrid()
    {

        if (ViewState["CurrentTable"] != null)
        {
            DataTable dtCurrentTable = (DataTable)ViewState["CurrentTable"];
            DataRow drCurrentRow = null;

            if (dtCurrentTable.Rows.Count > 0)
            {
                drCurrentRow = dtCurrentTable.NewRow();
                drCurrentRow["RowNumber"] = dtCurrentTable.Rows.Count + 1;
                //add new row to DataTable
                dtCurrentTable.Rows.Add(drCurrentRow);
                //Store the current data to ViewState
                ViewState["CurrentTable"] = dtCurrentTable;

                for (int i = 0; i < dtCurrentTable.Rows.Count - 1; i++)
                {
                    //extract the DropDownList Selected Items
                    DropDownList ddl1 = (DropDownList)Gridview1.Rows[i].FindControl("DropDownList1");
                    DropDownList ddl2 = (DropDownList)Gridview1.Rows[i].FindControl("DropDownList2");
                    DropDownList ddl3 = (DropDownList)Gridview1.Rows[i].FindControl("DropDownList3");
                    DropDownList ddl4 = (DropDownList)Gridview1.Rows[i].FindControl("DropDownList4");
                    // DropDownList ddl3 = (DropDownList)Gridview1.Rows[i].Cells[3].FindControl("DropDownList3");

                    // Update the DataRow with the DDL Selected Items
                    dtCurrentTable.Rows[i]["Column1"] = ddl1.SelectedItem.Text;
                    dtCurrentTable.Rows[i]["Column2"] = ddl2.SelectedItem.Text;

                    dtCurrentTable.Rows[i]["Column1"] = ddl3.SelectedItem.Text;
                    dtCurrentTable.Rows[i]["Column2"] = ddl4.SelectedItem.Text;
                    // dtCurrentTable.Rows[i]["Column3"] = ddl3.SelectedItem.Text;

                }

                //Rebind the Grid with the current data
                Gridview1.DataSource = dtCurrentTable;
                Gridview1.DataBind();
            }
        }
        else
        {
            Response.Write("ViewState is null");
        }

        //Set Previous Data on Postbacks
        SetPreviousData();
    }

    private void SetPreviousData()
    {
        int rowIndex = 0;
        if (ViewState["CurrentTable"] != null)
        {
            DataTable dt = (DataTable)ViewState["CurrentTable"];
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    //Set the Previous Selected Items on Each DropDownList on Postbacks
                    DropDownList ddl1 = (DropDownList)Gridview1.Rows[rowIndex].FindControl("DropDownList1");
                    DropDownList ddl2 = (DropDownList)Gridview1.Rows[rowIndex].FindControl("DropDownList2");
                    DropDownList ddl3 = (DropDownList)Gridview1.Rows[rowIndex].FindControl("DropDownList3");
                    DropDownList ddl4 = (DropDownList)Gridview1.Rows[rowIndex].FindControl("DropDownList4");
                    //  DropDownList ddl3 = (DropDownList)Gridview1.Rows[rowIndex].Cells[3].FindControl("DropDownList3");

                    //Fill the DropDownList with Data
                    FillDropDownList(ddl1);
                    FillDropDownList(ddl2);

                    //  ddl2.Items.Insert(0, "--Select--");

                    if (i < dt.Rows.Count - 1)
                    {
                        ddl1.ClearSelection();
                        ddl1.Items.FindByText(dt.Rows[i]["Column1"].ToString()).Selected = true;

                        table = Config.GetColumns(ddl1.SelectedItem.Value);
                        ddl2.DataSource = table;

                        ddl2.DataTextField = "All_Columns";
                        ddl2.DataValueField = "All_Columns";
                        ddl2.DataBind();
                        ddl2.ClearSelection();
                        ddl2.Items.FindByText(dt.Rows[i]["Column2"].ToString()).Selected = true;

                        ddl3.ClearSelection();
                        ddl3.Items.FindByText(dt.Rows[i]["Column3"].ToString()).Selected = true;

                        table = Config.GetColumns(ddl3.SelectedItem.Value);
                        ddl4.DataSource = table;

                        ddl4.DataTextField = "All_Columns";
                        ddl4.DataValueField = "All_Columns";
                        ddl4.DataBind();
                        ddl4.ClearSelection();
                        ddl4.Items.FindByText(dt.Rows[i]["Column4"].ToString()).Selected = true;

                        //ddl3.ClearSelection();
                        //ddl3.Items.FindByText(dt.Rows[i]["Column3"].ToString()).Selected = true;
                    }

                    rowIndex++;
                }
            }
        }
    }
    private void SetPreviousData1()
    {
        int rowIndex = 0;
        if (ViewState["CurrentTable"] != null)
        {
            DataTable dt = (DataTable)ViewState["CurrentTable"];
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    //Set the Previous Selected Items on Each DropDownList on Postbacks
                    DropDownList ddl1 = (DropDownList)Gridview1.Rows[rowIndex].FindControl("DropDownList1");
                    DropDownList ddl2 = (DropDownList)Gridview1.Rows[rowIndex].FindControl("DropDownList2");
                    DropDownList ddl3 = (DropDownList)Gridview1.Rows[rowIndex].FindControl("DropDownList3");
                    DropDownList ddl4 = (DropDownList)Gridview1.Rows[rowIndex].FindControl("DropDownList4");
                    //  DropDownList ddl3 = (DropDownList)Gridview1.Rows[rowIndex].Cells[3].FindControl("DropDownList3");

                    FillDropDownList(ddl1);
                    FillDropDownList(ddl2);



                    if (i < dt.Rows.Count - 1)
                    {
                        ddl1.ClearSelection();
                        ddl1.Items.FindByText(dt.Rows[i]["Column1"].ToString()).Selected = true;

                        table = Config.GetColumns(ddl1.SelectedItem.Value);
                        ddl2.DataSource = table;

                        ddl2.DataTextField = "All_Columns";
                        ddl2.DataValueField = "All_Columns";
                        ddl2.DataBind();
                        ddl2.ClearSelection();
                        ddl2.Items.FindByText(dt.Rows[i]["Column2"].ToString()).Selected = true;


                        ddl3.ClearSelection();
                        ddl3.Items.FindByText(dt.Rows[i]["Column3"].ToString()).Selected = true;

                        table = Config.GetColumns(ddl3.SelectedItem.Value);
                        ddl4.DataSource = table;

                        ddl4.DataTextField = "All_Columns";
                        ddl4.DataValueField = "All_Columns";
                        ddl4.DataBind();
                        ddl4.ClearSelection();
                        ddl4.Items.FindByText(dt.Rows[i]["Column4"].ToString()).Selected = true;
                        //ddl3.ClearSelection();
                        //ddl3.Items.FindByText(dt.Rows[i]["Column3"].ToString()).Selected = true;
                    }

                    rowIndex++;
                }
            }
        }
    }

    protected void ButtonAdd_Click(object sender, EventArgs e)
    {
        AddNewRowToGrid();
    }
    protected void Remove(int id)
    {
        if (ViewState["CurrentTable"] != null)
        {
            DataTable dtCurrentTable = (DataTable)ViewState["CurrentTable"];
            // DataRow drCurrentRow = null;

            if (dtCurrentTable.Rows.Count > 0)
            {
                int n = dtCurrentTable.Rows.Count;

                DataRow row = dtCurrentTable.Rows[id];
                dtCurrentTable.Rows.Remove(row);
                for (int i = 0; i < dtCurrentTable.Rows.Count; i++)
                {
                    //extract the DropDownList Selected Items
                    DropDownList ddl1 = (DropDownList)Gridview1.Rows[i].FindControl("DropDownList1");
                    DropDownList ddl2 = (DropDownList)Gridview1.Rows[i].FindControl("DropDownList2");
                    DropDownList ddl3 = (DropDownList)Gridview1.Rows[i].FindControl("DropDownList3");
                    DropDownList ddl4 = (DropDownList)Gridview1.Rows[i].FindControl("DropDownList4");
                    //  DropDownList ddl3 = (DropDownList)Gridview1.Rows[i].Cells[3].FindControl("DropDownList3");
                    FillDropDownList(ddl1);
                    // Update the DataRow with the DDL Selected Items
                    dtCurrentTable.Rows[i]["Column1"] = ddl1.SelectedItem.Text;
                    dtCurrentTable.Rows[i]["Column2"] = ddl2.SelectedItem.Text;
                    dtCurrentTable.Rows[i]["Column3"] = ddl1.SelectedItem.Text;
                    dtCurrentTable.Rows[i]["Column4"] = ddl2.SelectedItem.Text;
                    
                                    }

                //Rebind the Grid with the current data
                Gridview1.DataSource = dtCurrentTable;
                Gridview1.DataBind();
            }
        }
        else
        {
            Response.Write("ViewState is null");
        }

        //Set Previous Data on Postbacks

        SetPreviousData1();
    }
    protected void ButtonRomove_Click(object sender, EventArgs e)
    {
        GridViewRow gvRow = (GridViewRow)(sender as Control).Parent.Parent;
        int index = gvRow.RowIndex;
        Remove(index);
    }

    //OnClick Button()
    //{
    //    int n = 0;
    //    Int32 Styleid;
    //    String Danceid = string.Empty;
    //    String Costumeid = string.Empty;
    //    foreach (GridViewRow dRow in Gridview1.Rows)
    //    {
    //        if (dRow != null)
    //        {
    //            DropDownList tb = (DropDownList)Gridview1.Rows[n].FindControl("DropDownList1");
    //            DropDownList tb1 = (DropDownList)Gridview1.Rows[n].FindControl("DropDownList2");
    //            Costumeid = tb1.SelectedValue.ToString();
    //            Obj.DanceDeatilid = DanceDetailid;

    //            Obj.DancerName = tb.SelectedItem.Text;
    //            Obj.Groupid = Groupid;
    //            Obj.Danceid = tb.SelectedValue.ToString();
    //            Obj.Costumeid = Costumeid;
    //            Obj.CostumeName = tb1.SelectedItem.Text;
    //            Styleid = BusObj.InsertCostumeDetails(Obj);

    //            n++;
    //        }

    //    }
    // }
}

