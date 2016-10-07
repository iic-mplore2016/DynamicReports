using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
    public class TablesFieldModel
    {
        public TablesFieldModel()
        {
            DatabaseList = new List<DatabaseListModel>();

        }
        public int Id { get; set; }
        public string TableName { get; set; }
        public IList<DatabaseListModel> DatabaseList { get; set; }
    }
