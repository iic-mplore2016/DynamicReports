using iTextSharp.text;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.pdf;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.IO;
using System.Linq;
using System.Net.Mail;
using System.Text;
using System.Threading.Tasks;
using System.Web.UI;
using System.Web.UI.WebControls;


    class scheduled
    {
        private GridView gridDetails = new GridView();
        string currentTime { get; set; }
        private Random r = new Random();
        public string saveLocation { get; set; }
        public string queryBuilder { get; set; }
        public string emailList { get; set; }
        public string recurrence { get; set; }
        public string weekDays { get; set; }
        public string monthly { get; set; }
        public string[] currentDay { get; set; }
        public string reportDate { get; set; }
        public string reportTime { get; set; }
        public string reportFormat { get; set; }
        public string statusFlag { get; set; }
        public string reportID { get; set; }
        public string reportName { get; set; }
        public string assignRole { get; set; }
        public string updateType { get; set; }
        public string qId { get; set; }
        public string ServerType { get; set; }
        public string ServerName { get; set; }

        private DbProviderFactory factory;
        private DbConnection dConn;
        private String connString, providerStr = "";

        public void CreateConnection() //Default Constructor
        {
            //ServerType = "Sql";
            ServerName = "Data Source=localhost;User Id=STAGE_VSOL;Password=STAGE_VSOL";

            connString = ServerName;

            //providerStr = "System.Data.SqlClient";

            providerStr = "Oracle.DataAccess.Client";

            factory = DbProviderFactories.GetFactory(providerStr);

            dConn = factory.CreateConnection();

            //set connection string
            dConn.ConnectionString = connString;

            //open the connection
            try
            {
                dConn.Open();
            }
            catch (Exception e)
            {

            }

        }
        public void EmailSend()
        {
            MailMessage mail = new MailMessage();
            SmtpClient SmtpServer = new SmtpClient("smtp.gmail.com");
            mail.From = new MailAddress("prabuganesh440@gmail.com");
            mail.To.Add(emailList);
            mail.Subject = "Report Mail";
            mail.Body = "Daily Report With Attachment";
            System.Net.Mail.Attachment attachment;
            attachment = new System.Net.Mail.Attachment(saveLocation);
            mail.Attachments.Add(attachment);
            SmtpServer.Port = 587;
            SmtpServer.Credentials = new System.Net.NetworkCredential("prabuganesh440@gmail.com", "prabuvikram");
            SmtpServer.EnableSsl = true;
            SmtpServer.Send(mail);


        }

        public DataTable runQueue()
        {
            currentTime = DateTime.Now.ToString("hh:mm tt");
            string schedulerQuery = "select SAVD_RPRT.RPRT_Id,QUE_RPRT.RPRT_FRMT,QUE_RPRT.Que_Id,QUE_RPRT.FLG,SAVD_RPRT.RPRT_NAM,SAVD_RPRT.QRY_STRNG,SCHLD_RPRTS.SAVD_LOC,SCHLD_RPRTS.EML_LST from QUE_RPRT left join SAVD_RPRT on QUE_RPRT.RPRT_Id=SAVD_RPRT.RPRT_Id left join SCHLD_RPRTS on SCHLD_RPRTS.RPRT_Id=SAVD_RPRT.RPRT_Id";
            DataTable dtList = ExecuteSQLQuery(schedulerQuery);

            for (int i = 0; i < dtList.Rows.Count; i++)
            {
                updateType = "q";
                reportFormat = dtList.Rows[i]["RPRT_FRMT"].ToString();
                statusFlag = dtList.Rows[i]["FLG"].ToString();
                queryBuilder = dtList.Rows[i]["QRY_STRNG"].ToString();
                emailList = dtList.Rows[i]["EML_LST"].ToString();
                qId = dtList.Rows[i]["Que_Id"].ToString();

                if (reportFormat == "excel" || reportFormat == "Excel")
                    saveLocation = dtList.Rows[i]["SAVD_LOC"].ToString() + "\\" + dtList.Rows[i]["RPRT_NAM"].ToString() + "_" + DateTime.Now.ToString("dd-MM-yyyy") + "(" + r.Next(0, 9999).ToString() + ").xls";
                else if (reportFormat == "pdf" || reportFormat == "Pdf")
                    saveLocation = dtList.Rows[i]["SAVD_LOC"].ToString() + "\\" + dtList.Rows[i]["RPRT_NAM"].ToString() + "_" + DateTime.Now.ToString("dd-MM-yyyy") + "(" + r.Next(0, 9999).ToString() + ").pdf";
                else if (reportFormat == "html" || reportFormat == "Html")
                    saveLocation = dtList.Rows[i]["SAVD_LOC"].ToString() + "\\" + dtList.Rows[i]["RPRT_NAM"].ToString() + "_" + DateTime.Now.ToString("dd-MM-yyyy") + "(" + r.Next(0, 9999).ToString() + ").html";

                if (statusFlag == "1")
                {
                    FileWrite();
                }
            }

            return dtList;
        }

        public DataTable ExportExcel()
        {
            currentTime = DateTime.Now.ToString("hh:mm tt");
            string schedulerQuery = "select SAVD_RPRT.RPRT_Id, SAVD_RPRT.RPRT_NAM,SAVD_RPRT.QRY_STRNG,SAVD_RPRT.ASSN_ROL,SCHLD_RPRTS.RPRT_DT,SCHLD_RPRTS.RPRT_TM,SCHLD_RPRTS.RCRN_TYP,SCHLD_RPRTS.SAVD_LOC,SCHLD_RPRTS.EML_LST,SCHLD_RPRTS.WK_NAM,SCHLD_RPRTS.RPRT_FMRT from SCHLD_RPRTS left join SAVD_RPRT on SCHLD_RPRTS.RPRT_Id=SAVD_RPRT.RPRT_Id;";
            DataTable dtList = ExecuteSQLQuery(schedulerQuery);

            for (int i = 0; i < dtList.Rows.Count; i++)
            {
                updateType = "s";
                queryBuilder = dtList.Rows[i]["QRY_STRNG"].ToString();
                emailList = dtList.Rows[i]["EML_LST"].ToString();
                reportFormat = dtList.Rows[i]["RPRT_FMRT"].ToString();
                recurrence = dtList.Rows[i]["RCRN_TYP"].ToString();
                reportDate = dtList.Rows[i]["RPRT_DT"].ToString();
                reportTime = dtList.Rows[i]["RPRT_TM"].ToString();
                currentDay = dtList.Rows[i]["WK_NAM"].ToString().Split(',');
                reportID = dtList.Rows[i]["RPRT_Id"].ToString();
                reportName = dtList.Rows[i]["RPRT_NAM"].ToString();
                assignRole = dtList.Rows[i]["ASSN_ROL"].ToString();

                if (reportFormat == "excel")
                    saveLocation = dtList.Rows[i]["SAVD_LOC"].ToString() + "\\" + dtList.Rows[i]["RPRT_NAM"].ToString() + "_" + DateTime.Now.ToString("dd-MM-yyyy") + "(" + r.Next(0, 9999).ToString() + ").xls";
                else if (reportFormat == "pdf")
                    saveLocation = dtList.Rows[i]["SAVD_LOC"].ToString() + "\\" + dtList.Rows[i]["RPRT_NAM"].ToString() + "_" + DateTime.Now.ToString("dd-MM-yyyy") + "(" + r.Next(0, 9999).ToString() + ").pdf";
                else if (reportFormat == "html")
                    saveLocation = dtList.Rows[i]["SAVD_LOC"].ToString() + "\\" + dtList.Rows[i]["RPRT_NAM"].ToString() + "_" + DateTime.Now.ToString("dd-MM-yyyy") + "(" + r.Next(0, 9999).ToString() + ").html";

                if (recurrence == "Daily")
                {
                    if (currentTime == reportTime)
                    {
                        FileWrite();
                    }

                }
                if (recurrence == "Weekly")
                {
                    if (currentDay.Contains(DateTime.Now.DayOfWeek.ToString()))
                    {
                        if (currentTime == reportTime)
                        {
                            FileWrite();
                        }

                    }

                }

                if (recurrence == "Monthly")
                {
                    if (currentDay.Contains(DateTime.Now.ToString("dd")))
                    {
                        if (currentTime == reportTime)
                        {
                            FileWrite();
                        }
                    }

                }

            }
            return dtList;

        }

        public void FileWrite()
        {

            DataTable dtExport = ExecuteSQLQuery(queryBuilder);
            gridDetails.DataSource = dtExport;
            gridDetails.DataBind();
            StringWriter sw = new StringWriter();
            HtmlTextWriter htw = new HtmlTextWriter(sw);
            try
            {

                if (reportFormat == "excel" || reportFormat == "html" || reportFormat == "Excel" || reportFormat == "Html")
                {
                    gridDetails.RenderControl(htw);
                    string renderedGridView = sw.ToString();
                    File.WriteAllText(saveLocation, renderedGridView);
                }
                else if (reportFormat == "pdf" || reportFormat == "Pdf")
                {
                    //create empty document
                    PdfWriter PdfWriter;
                    Document ndocument = new Document(PageSize.A4, 10f, 10f, 10f, 0f);
                    PdfWriter.GetInstance(ndocument, new FileStream(saveLocation, FileMode.Create));
                    ndocument.Open();
                    ndocument.Add(new Paragraph("Empty"));
                    ndocument.Close();

                    //write the pdf document
                    string path = Path.Combine(saveLocation);
                    HtmlTextWriter hw = new HtmlTextWriter(sw);
                    gridDetails.RenderControl(hw);
                    dynamic output = new FileStream(path, FileMode.Create);
                    StringReader sr = new StringReader(sw.ToString());
                    iTextSharp.text.Document pdfDoc = new iTextSharp.text.Document(PageSize.A4, 10f, 10f, 100f, 0f);
                    HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
                    iTextSharp.text.pdf.PdfWriter.GetInstance(pdfDoc, output);
                    pdfDoc.Open();
                    htmlparser.Parse(sr);
                    pdfDoc.Close();
                }


                if (string.IsNullOrEmpty(emailList) == false)
                {
                    EmailSend();
                }

            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (updateType == "s")
                {
                    string query = "insert into SCHED_LOG_STATUS([RPRT_ID],[RPRT_NAM],[ASSN_ROL],[USR_NAM],[RPRT_DT],[RPRT_TM],[GNRD_DT],[GRND_TM],[STATUS])";
                    query += "values('" + reportID + "','" + reportName + "','" + assignRole + "','" + "" + "','" + reportDate + "','" + reportTime + "','" + DateTime.Now + "','" + DateTime.Now.ToString("hh:MM:ss") + "','" + 1 + "')";
                    ExecuteSQLQuery(query);
                }
                else if (updateType == "q")
                {
                    string query = "update QUE_RPRT set FLG = 0 where Que_Id = '" + qId + "'";
                    ExecuteSQLQuery(query);
                }

            }


        }

        public DataTable ExecuteSQLQuery(string queryString)
        {
            CreateConnection();
            DataTable dataTable = new DataTable();

            using (dConn)
            {
                DbCommand command = factory.CreateCommand();
                command.CommandText = queryString;
                command.Connection = dConn;
                DbDataAdapter adapter = factory.CreateDataAdapter();
                adapter.SelectCommand = command;
                adapter.Fill(dataTable);
            }

            return dataTable;
        }
    }