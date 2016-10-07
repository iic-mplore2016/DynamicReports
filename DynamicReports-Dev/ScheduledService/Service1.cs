using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.ServiceProcess;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Timers;

namespace ScheduledService
{
    public partial class Service1 : ServiceBase
    {
        System.Timers.Timer time = new System.Timers.Timer();
        SchedulerServices services = new SchedulerServices();
        public Service1()
        {

            InitializeComponent();

            this.CanHandlePowerEvent = true;
            this.CanHandleSessionChangeEvent = true;
            this.CanPauseAndContinue = true;
            this.CanShutdown = true;
            this.CanStop = true;
        }

        protected override void OnStart(string[] args)
        {
            Thread t = new Thread(new ThreadStart(this.InitTimer));
            t.Start();
          
        }

        private void InitTimer()
        {
            // System.Diagnostics.Debugger.Launch();
           
            time.Start();
            
            time.Elapsed += TimeElapsed;
            time.Interval = 60000;
            time.Enabled = true;
        }

        public void TimeElapsed(object sender, ElapsedEventArgs e)
        {
            ScheduleService();
        }



        public void ScheduleService()
        {
            services.ExportExcel();
        }

        protected override void OnStop()
        {
            time.Enabled = false;
        }
    }
}
