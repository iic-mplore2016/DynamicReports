using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;

/// <summary>
/// Summary description for autosearch
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
[ToolboxItem(false)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class autosearch : System.Web.Services.WebService
{
    BusinessLayer Config = new BusinessLayer();
    public autosearch()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }
    //public class SearchName
    //{
    //    public string name { get; set; }


    //}
    //public class SearchNameList
    //{
    //    public List<SearchName> name { get; set; }
    //}

    [WebMethod]
    public List<string> Getpost(string prefixText)
    {

        List<string> CountryNames = new List<string>();

        var Tables = GlobalValues.SearchNameList.Where(n => n.name.ToLower().Contains(prefixText)).ToList();
        // foreach (var item in GlobalValues.SearchNameList)
        foreach (var item in Tables)
        {
            CountryNames.Add(item.name);
        }
        return CountryNames;

    }

}
