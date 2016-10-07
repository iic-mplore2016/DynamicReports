using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Services;
using Newtonsoft.Json;
/// <summary>
/// Summary description for Report_Viewer
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]

[System.Web.Script.Services.ScriptService]
public class Report_Viewer : System.Web.Services.WebService
{
    private string query = "";
    BusinessLayer Config = new BusinessLayer();
    //DataTable dt = new DataTable();
    [WebMethod(EnableSession = true)]
    public string ViewReport()
    {
        string jsonString = string.Empty;
        try
        {
            if (HttpContext.Current.Session["ReportViewQuery"] != null)
            {
                query = HttpContext.Current.Session["ReportViewQuery"].ToString();

                DataTable table = Config.GetReport(query);
                foreach (var del in GlobalValues.CustomFields)
                {
                    string[] column = del.LabelColumn.Split('.');
                    if (del.IsDisplay == false)
                    {
                        if (del.DisplayName != "")
                        {
                            table.Columns.Remove(del.DisplayName);
                        }
                        else
                        {
                            table.Columns.Remove(column[1]);
                        }
                    }
                }
                DataTable formatDtble = table.Clone();
                int countformat = 0;

                foreach (DataRow dr in table.Rows)
                {
                    object[] objData = dr.ItemArray;
                    for (int i = 0; i < objData.Length; i++)
                    {
                        DateTime date;

                        var val = objData[i].ToString();
                        if (DateTime.TryParse(val, out date))
                        {
                            date = Convert.ToDateTime(val);
                            string formatDt = date.ToString("dd-MMM-yyyy");
                            val = formatDt;
                            if (countformat == 0)
                            {
                                formatDtble.Columns[i].DataType = typeof(string);
                            }
                            objData[i] = val.ToString();
                            formatDtble.Rows.Add(objData);
                        }
                    }

                    countformat = countformat + 1;
                }

                //if (GlobalValues.CustomFields)
                jsonString = JsonConvert.SerializeObject(table);
            }
            else
            {
                jsonString = JsonConvert.SerializeObject(0);

            }
        }
        catch (Exception ex)
        {
            ExceptionLogging.SendErrorToText(ex);
        }
        return jsonString;
    }


}

