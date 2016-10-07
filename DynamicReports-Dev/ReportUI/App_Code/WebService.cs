using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;

/// <summary>
/// Summary description for WebService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class WebService : System.Web.Services.WebService
{
    BusinessLayer Config = new BusinessLayer();
    DataTable dt = new DataTable();
    [WebMethod(EnableSession = true)]
    public string ViewReport()
    {
        string jsonString = string.Empty;
        try
        {
            if (HttpContext.Current.Request.QueryString["rID"] != null)
            {
                string rid = HttpContext.Current.Request.QueryString["rID"];
                string query = "select * from Activity where ACTVTY_ID='" + rid + "'";
                //  string query = "select * from STAGE_ACTIVITY";
                dt = Config.GetReport(query);

                //foreach (var del in GlobalValues.CustomFields)
                //{
                //    string[] column = del.LabelColumn.Split('.');
                //    if (del.IsDisplay == false)
                //    {
                //        if (del.DisplayName != "")
                //        {
                //            dt.Columns.Remove(del.DisplayName);
                //        }
                //        else
                //        {
                //            dt.Columns.Remove(column[1]);
                //        }
                //    }
                //}
                jsonString = JsonConvert.SerializeObject(dt);
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
