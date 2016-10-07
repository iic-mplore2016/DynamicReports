using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

    public class ServerModel
    {
        public int Id { get; set; }
        public string ServerName { get; set; }
        public string Authentication { get; set; }
        public string UserName { get; set; }
        public string Password { get; set; }
        public List<ListItem> DropDown { get; set; }
    }
