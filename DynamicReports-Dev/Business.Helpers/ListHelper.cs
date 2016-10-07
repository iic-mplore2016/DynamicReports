using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;


public class ListHelper
{
    public static IEnumerable<ListItem> Filter()
    {
        return new ListItem[] {
				new ListItem { Value="=", Text="=",Selected=true },
				new ListItem { Value="!=", Text="!=", },
                new ListItem { Value="Between", Text="Between", },
                new ListItem { Value="Not Between", Text="Not Between", },
                new ListItem { Value="<", Text="<", },
                new ListItem { Value="<=", Text="<=", },
                new ListItem { Value=">", Text=">", },
                new ListItem { Value=">=", Text=">=", },
                new ListItem { Value="Is Null", Text="Is Null", },
                new ListItem { Value="Is Not Null", Text="Is Not Null", },
                new ListItem { Value="Is Only", Text="Is Only", },
			};
    }
    public static IEnumerable<ListItem> Aggregate()
    {
        return new ListItem[] {
				new ListItem { Value="None", Text="None",Selected=true },
				new ListItem { Value="SUM", Text="SUM", },
                new ListItem { Value="AVG", Text="AVG", },
                new ListItem { Value="COUNT", Text="COUNT", },
                new ListItem { Value="MIN", Text="MIN", },
                new ListItem { Value="MAX", Text="MAX", }              
            
			};
    }
    public static IEnumerable<ListItem> Precondition()
    {
        return new ListItem[] {
				new ListItem { Value="=", Text="=",Selected=true },
				new ListItem { Value="between", Text="between", },
                new ListItem { Value="in", Text="in", },
               
			};
    }
    public static IEnumerable<ListItem> Authentication()
    {
        return new ListItem[] {
				new ListItem { Value="1", Text="Windows Authentication",Selected=true },
				new ListItem { Value="2", Text="Server Authentication", }            
               
			};
    }
    public static IEnumerable<ListItem> Role()
    {
        return new ListItem[] {
		        new ListItem { Value="1", Text="Admin", },
                new ListItem { Value="2", Text="User", }
               
			};
    }
    public static IEnumerable<ListItem> FilterMore()
    {
        return new ListItem[] {
				new ListItem { Value="And", Text="And",Selected=true },
				new ListItem { Value="Or", Text="Or", },
              
			};
    }
    public static IEnumerable<ListItem> ServerType()
    {
        return new ListItem[] {
				new ListItem { Value="Sql", Text="Sql",Selected=true },
				new ListItem { Value="Oracle", Text="Oracle", },
              
			};
    }
    public static IEnumerable<ListItem> SortOrder()
    {
        return new ListItem[] {
				new ListItem { Value="None", Text="None",Selected=true },
				new ListItem { Value="ASC", Text="ASC", },
                new ListItem { Value="DESC", Text="DESC", },
              
			};
    }
    public static IEnumerable<ListItem> DataType()
    {
        return new ListItem[] {
				new ListItem { Value="None", Text="None",Selected=true },
				new ListItem { Value="Text", Text="Text", },
                new ListItem { Value="Date", Text="Date", },
                new ListItem { Value="DateRange", Text="DateRange", },
                new ListItem { Value="Master", Text="Master", },
              
			};
    }
}
