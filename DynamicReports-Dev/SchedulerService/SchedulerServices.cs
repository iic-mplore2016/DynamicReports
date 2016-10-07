using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Net.Mail;
//using System.ServiceProcess;
using System.Text;
using System.Threading.Tasks;
using System.Timers;
using System.Web.UI;
using System.Web.UI.WebControls;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html.simpleparser;

public class SchedulerServices
{
    BusinessLayer Config = new BusinessLayer();
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

    public DataTable ExportExcel()
    {
        currentTime = DateTime.Now.ToString("hh:mm tt");
        GlobalValues.ServerType = "Sql";
        GlobalValues.ServerName = "Data Source=(local);Initial Catalog=NORTHWND;Integrated Security=True";
        string schedulerQuery = "select s.RPRT_Id, s.RPRT_NAM,s.QRY_STRNG,sr.RPRT_DT ,sr.RPRT_TM,sr.RCRN_TYP,sr.SAVD_LOC,sr.EML_LST,sr.WK_NAM,sr.RPRT_FMRT from SCHLD_RPRTS  as sr left join SAVD_RPRT as s on sr.RPRT_Id=s.RPRT_Id";
        DataTable dtList = Config.GetReport(schedulerQuery);

        for (int i = 0; i < dtList.Rows.Count; i++)
        {
            queryBuilder = dtList.Rows[i]["QRY_STRNG"].ToString();
            emailList = dtList.Rows[i]["EML_LST"].ToString();
            reportFormat = dtList.Rows[i]["RPRT_FMRT"].ToString();
            recurrence = dtList.Rows[i]["RCRN_TYP"].ToString();
            reportDate = dtList.Rows[i]["RPRT_DT"].ToString();
            reportTime = dtList.Rows[i]["RPRT_TM"].ToString();
            currentDay = dtList.Rows[i]["WK_NAM"].ToString().Split(',');

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
        GlobalValues.ServerType = "Sql";
        GlobalValues.ServerName = "Data Source=(local);Initial Catalog=NORTHWND;Integrated Security=True";
        DataTable dtExport = Config.GetReport(queryBuilder);
        gridDetails.DataSource = dtExport;
        gridDetails.DataBind();
        StringWriter sw = new StringWriter();
        HtmlTextWriter htw = new HtmlTextWriter(sw);
        try
        {

            if (reportFormat == "excel" || reportFormat == "html")
            {
                gridDetails.RenderControl(htw);
                string renderedGridView = sw.ToString();
                File.WriteAllText(saveLocation, renderedGridView);
            }
            else if (reportFormat == "pdf")
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

    }

}





