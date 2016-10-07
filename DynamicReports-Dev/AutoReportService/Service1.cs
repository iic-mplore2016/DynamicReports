using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Net.Mail;
using System.ServiceProcess;
using System.Text;
using System.Threading.Tasks;
using System.Timers;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AutoReportService
{
    public partial class Service1 : ServiceBase
    {
        public Service1()
        {
            InitializeComponent();
        }

        protected override void OnStart(string[] args)
        {
            System.Diagnostics.Debugger.Launch();
            System.Timers.Timer time = new System.Timers.Timer();
            time.Start();
            time.Interval = 60000;
            time.Elapsed += TimeElapsed;
        }

        public void TimeElapsed(object sender, ElapsedEventArgs e)
        {
            ScheduleService();
        }

        protected override void OnStop()
        {
        }

        public void ScheduleService()
        {
            

            //this.WriteToFile("Simple Service Mode: Interval" + " {0}");
            SqlConnection conn;
            SqlConnection conn1;
            SqlCommand cmd;
            SqlDataAdapter da;
            Random r = new Random();
            GridView gd = new GridView();
            DataTable dt = new DataTable();
            StringWriter sw = new StringWriter();
            DataTable dt1 = new DataTable();
            DataTable dt2 = new DataTable();
            string constring = "Data Source=(local);Initial Catalog=reportbuilder;Integrated Security=True";
            string constring2;
            string sql;
            string recuurance = "";
            int report_id = 0;
            string report_time = "";
            string save_location = "";
            string query_builder = "";
            string email_list = "";
            string week_days = "";
            string month_day = "";
            string[] days = { };
            string Current_time = DateTime.Now.ToString("hh:mm tt");

            using (conn = new SqlConnection(constring))
            {
                try
                {
                    conn.Open();
                    sql = "Select * from SchedulerReport";
                    cmd = new SqlCommand(sql, conn);
                    da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                    foreach (DataRow table in dt.Rows.Cast<DataRow>().ToList())
                    {

                        recuurance = table.Field<string>(2);
                        report_id = table.Field<int>(1);
                        report_time = table.Field<string>(4);
                        save_location = table.Field<string>(5) + "\\" + "Report_" + DateTime.Now.ToString("dd-MM-yyyy") + "(" + r.Next(0, 9999).ToString() + ").xls";
                        email_list = table.Field<string>(6);
                        if (table.Field<string>(8) != null && table.Field<string>(8) != "")
                        {
                            week_days = table.Field<string>(8);
                            month_day = table.Field<string>(8);
                        }


                        if (recuurance == "Daily")
                        {
                            if (report_time == Current_time)
                            {
                                //DataTable dt1 = new DataTable();
                                sql = "select QueryBuilder from SavedReport where Report_id = " + report_id;
                                cmd = new SqlCommand(sql, conn);
                                da = new SqlDataAdapter(cmd);
                                da.Fill(dt1);
                                query_builder = dt1.Rows[0]["QueryBuilder"].ToString();
                                constring2 = "Data Source=(local);Initial Catalog=NORTHWND;Integrated Security=True";

                                using (conn1 = new SqlConnection(constring2))
                                {
                                    try
                                    {
                                        //DataTable dt2 = new DataTable();
                                        conn1.Open();
                                        cmd = new SqlCommand(query_builder, conn1);
                                        da = new SqlDataAdapter(cmd);
                                        da.Fill(dt2);
                                        gd.DataSource = dt2;
                                        gd.DataBind();

                                        
                                        HtmlTextWriter htw = new HtmlTextWriter(sw);
                                        gd.RenderControl(htw);
                                        string renderedGridView = sw.ToString();
                                        File.WriteAllText(save_location, renderedGridView);

                                        if (email_list != null && email_list != "")
                                        {
                                            MailMessage mail = new MailMessage();
                                            SmtpClient SmtpServer = new SmtpClient("smtp.gmail.com");
                                            mail.From = new MailAddress("prabuganesh440@gmail.com");
                                            mail.To.Add(email_list);
                                            mail.Subject = "Report Mail";
                                            mail.Body = "Daily Report With Attachment";

                                            System.Net.Mail.Attachment attachment;
                                            attachment = new System.Net.Mail.Attachment(save_location);
                                            mail.Attachments.Add(attachment);

                                            SmtpServer.Port = 587;
                                            SmtpServer.Credentials = new System.Net.NetworkCredential("prabuganesh440@gmail.com", "prabuvikram");
                                            SmtpServer.EnableSsl = true;

                                            SmtpServer.Send(mail);
                                        }

                                    }
                                    catch (Exception ex)
                                    {
                                        throw ex;
                                    }
                                    finally
                                    {
                                        conn1.Close();
                                    }
                                }
                            }
                        }
                        else if (recuurance == "Weekly")
                        {
                            days = week_days.Split(',');

                            foreach (string day in days)
                            {
                                if (day == DateTime.Now.DayOfWeek.ToString())
                                {
                                    if (report_time == Current_time)
                                    {
                                        //DataTable dt1 = new DataTable();
                                        sql = "select QueryBuilder from SavedReport where Report_id = " + report_id;
                                        cmd = new SqlCommand(sql, conn);
                                        da = new SqlDataAdapter(cmd);
                                        da.Fill(dt1);
                                        query_builder = dt1.Rows[0]["QueryBuilder"].ToString();
                                        constring2 = "Data Source=(local);Initial Catalog=NORTHWND;Integrated Security=True";

                                        using (conn1 = new SqlConnection(constring2))
                                        {
                                            try
                                            {
                                                //DataTable dt2 = new DataTable();
                                                conn1.Open();
                                                cmd = new SqlCommand(query_builder, conn1);
                                                da = new SqlDataAdapter(cmd);
                                                da.Fill(dt2);
                                                gd.DataSource = dt2;
                                                gd.DataBind();

                                                //StringWriter sw = new StringWriter();
                                                HtmlTextWriter htw = new HtmlTextWriter(sw);
                                                gd.RenderControl(htw);
                                                string renderedGridView = sw.ToString();
                                                File.WriteAllText(save_location, renderedGridView);

                                                if (email_list != null && email_list != "")
                                                {
                                                    MailMessage mail = new MailMessage();
                                                    SmtpClient SmtpServer = new SmtpClient("smtp.gmail.com");
                                                    mail.From = new MailAddress("prabuganesh440@gmail.com");
                                                    mail.To.Add(email_list);
                                                    mail.Subject = "Report Mail";
                                                    mail.Body = "Daily Report With Attachment";

                                                    System.Net.Mail.Attachment attachment;
                                                    attachment = new System.Net.Mail.Attachment(save_location);
                                                    mail.Attachments.Add(attachment);

                                                    SmtpServer.Port = 587;
                                                    SmtpServer.Credentials = new System.Net.NetworkCredential("prabuganesh440@gmail.com", "prabuvikram");
                                                    SmtpServer.EnableSsl = true;

                                                    SmtpServer.Send(mail);
                                                }

                                            }
                                            catch (Exception ex)
                                            {
                                                throw ex;
                                            }
                                            finally
                                            {
                                                conn1.Close();
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        else if (recuurance == "Monthly")
                        {
                            if (month_day == DateTime.Now.ToString("dd"))
                            {
                                if (report_time == Current_time)
                                {
                                    
                                    sql = "select QueryBuilder from SavedReport where Report_id = " + report_id;
                                    cmd = new SqlCommand(sql, conn);
                                    da = new SqlDataAdapter(cmd);
                                    da.Fill(dt1);
                                    query_builder = dt1.Rows[0]["QueryBuilder"].ToString();
                                    constring2 = "Data Source=(local);Initial Catalog=NORTHWND;Integrated Security=True";

                                    using (conn1 = new SqlConnection(constring2))
                                    {
                                        try
                                        {
                                            
                                            conn1.Open();
                                            cmd = new SqlCommand(query_builder, conn1);
                                            da = new SqlDataAdapter(cmd);
                                            da.Fill(dt2);
                                            gd.DataSource = dt2;
                                            gd.DataBind();

                                            //StringWriter sw = new StringWriter();
                                            HtmlTextWriter htw = new HtmlTextWriter(sw);
                                            gd.RenderControl(htw);
                                            string renderedGridView = sw.ToString();
                                            File.WriteAllText(save_location, renderedGridView);

                                            if (email_list != null && email_list != "")
                                            {
                                                MailMessage mail = new MailMessage();
                                                SmtpClient SmtpServer = new SmtpClient("smtp.gmail.com");
                                                mail.From = new MailAddress("prabuganesh440@gmail.com");
                                                mail.To.Add(email_list);
                                                mail.Subject = "Report Mail";
                                                mail.Body = "Daily Report With Attachment";

                                                System.Net.Mail.Attachment attachment;
                                                attachment = new System.Net.Mail.Attachment(save_location);
                                                mail.Attachments.Add(attachment);

                                                SmtpServer.Port = 587;
                                                SmtpServer.Credentials = new System.Net.NetworkCredential("prabuganesh440@gmail.com", "prabuvikram");
                                                SmtpServer.EnableSsl = true;

                                                SmtpServer.Send(mail);
                                            }

                                        }
                                        catch (Exception ex)
                                        {
                                            throw ex;
                                        }
                                        finally
                                        {
                                            conn1.Close();
                                        }
                                    }
                                }
                            }
                        }
                    }

                }
                catch (Exception ex)
                {
                    throw ex;
                }
                finally
                {
                    conn.Close();
                }
            }
        }
    }
}
