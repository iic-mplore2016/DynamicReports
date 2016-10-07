<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Reports/MasterPage.master" CodeFile="DashBoard.aspx.cs" Inherits="Reports_DashBoard" Async="true" %>

<%@ Register Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" TagPrefix="ajax" %>

<asp:Content ID="content" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <asp:ScriptManager ID="script" runat="server"></asp:ScriptManager>

    <script type="text/javascript">
        $(document).ready(function () {
            //Helper function to keep table row from collapsing when being sorted
            var fixHelperModified = function (e, tr) {
                var $originals = tr.children();
                var $helper = tr.clone();
                $helper.children().each(function (index) {
                    $(this).width($originals.eq(index).width())
                });
                return $helper;
            };
        });

        //Renumber table rows
        function renumber_table(tableID) {
            $(tableID + " tr").each(function () {
                count = $(this).parent().children().index($(this)) + 1;
                $(this).find('.priority').html(count);
            });
        }
    </script>
    <script type="text/javascript">

        function SetTarget() {
            document.forms[0].target = "_blank";
        }
    </script>
    <div class="ui-loader-background" id="load">
        <img style="padding-left: 50%; padding-top: 20%;" id="Image1" src="/Images/loading.gif" alt="Processing" />
    </div>
    <section class="content-header">
        <div style="padding-left:40%;">
            <h4>List of Reports</h4>
        </div>
        <%--   <div class="pull-left head">
            <asp:UpdateProgress ID="UpdateProgress" runat="server">
                <ProgressTemplate>
                    <asp:Image ID="Image1" ImageUrl="~/Images/loading.gif" AlternateText="Processing" runat="server" />
                </ProgressTemplate>
            </asp:UpdateProgress>
            <ajax:ModalPopupExtender ID="modalPopup" runat="server" TargetControlID="UpdateProgress"
                PopupControlID="UpdateProgress" BackgroundCssClass="modalPopup">
            </ajax:ModalPopupExtender>
            
            <asp:Button ID="Button2" ClientIDMode="Static" class="btn btn-primary btn-block btn-flat btn-pink btn-sm" runat="server" Text="New Report" OnClick="Button1_Click" />
      
        </div>--%>

        <%--<div class="pull-right">
            <a href="QueueReport.aspx" class="btn btn-success btn-flat btn-sm">Queue Report</a>
            <a href="SheduledRportLog.aspx" class="btn btn-success btn-flat btn-sm">Scheduled Report Log</a>
            <a href="ScheduledReport.aspx" class="btn btn-success btn-flat btn-sm">Scheduled Report</a>
           
        </div>--%>

        <div class="clearfix"></div>
    </section>
    <!-- Main content -->
    <section class="content">
        <div class="row">
            <div class="col-xs-12">
                <div class="box box-primary query">
                    <div class="box-body">

                        <table id="example1" class="table table-bordered table-striped">
                            <thead>
                                <tr>
                                    <th>Report Name</th>
                                    <th>Assigned Role</th>
                                    <th>Queue Format Output</th>
                                    <th>Queue Priority</th>
                                    <th>Action</th>

                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater runat="server" ID="dashboardRepeater">
                                    <ItemTemplate>

                                        <tr>
                                            <li class="input-group">
                                                <td><%#Eval("RPRT_NAM") %></td>
                                                <td><%#Eval("ASSN_ROL") %></td>
                                                <td>
                                                    <div class="col-sm has-feedback">
                                                        <asp:DropDownList ID="ddlFormat" runat="server" class="form-control input-sm">
                                                            <asp:ListItem Value="0" Text="Excel"></asp:ListItem>
                                                            <asp:ListItem Value="1" Text="Html"></asp:ListItem>
                                                        </asp:DropDownList>
                                                        <span class="glyphicon glyphicon-menu-down form-control-feedback"></span>
                                                        <asp:HiddenField ID="hddnQuery" runat="server" Value='<%# Eval("QRY_STRNG") %>' />
                                                        <asp:HiddenField ID="hddnName" runat="server" Value='<%# Eval("RPRT_NAM") %>' />
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="col-sm has-feedback">
                                                        <asp:DropDownList ID="ddlPriority" runat="server" class="form-control input-sm">
                                                            <asp:ListItem Value="0" Text="High"></asp:ListItem>
                                                            <asp:ListItem Value="1" Text="Normal"></asp:ListItem>
                                                            <asp:ListItem Value="2" Text="Low"></asp:ListItem>
                                                        </asp:DropDownList>
                                                        <span class="glyphicon glyphicon-menu-down form-control-feedback"></span>

                                                    </div>
                                                </td>
                                                <td>
                                                    <asp:LinkButton ID="AnchorButton" CssClass='<%# ((DataBinder.Eval(Container.DataItem,"ASSN_ROL").ToString()=="Admin") ? "btn btn-warning btn-social btn-flat btn-sm" :"btn btn-warning btn-social btn-flat btn-sm disabled")%>' runat="server" OnClick="AnchorButton_Click" CommandArgument='<%# Eval("RPRT_Id") %>'><i class='fa fa-play'></i>Run as Queue</asp:LinkButton>
                                                    <asp:LinkButton ID="eidtButton" CssClass='btn btn-warning btn-social btn-flat btn-sm' runat="server" OnClick="eidtButton_Click" CommandArgument='<%# Eval("RPRT_Id") %>'>Edit</asp:LinkButton>
                                                    <asp:LinkButton ID="viewButton" CssClass='btn btn-success btn-social btn-flat btn-sm' runat="server" OnClick="viewButton_Click" CommandArgument='<%# Eval("QRY_STRNG")+" "+Eval("GRP_STRNG")%>' OnClientClick="SetTarget();">View</asp:LinkButton>
                                            </li>
                                        </tr>
                                     
                                    </ItemTemplate>

                                </asp:Repeater>
                            </tbody>
                        </table>

                        <asp:HiddenField runat="server" ClientIDMode="Static" ID="limitation" Value="" />
                        <asp:HiddenField runat="server" ClientIDMode="Static" ID="setlimit" Value="" />
                    </div>
                    <!-- /.box-body -->
                </div>
                <!-- /.box -->
            </div>
        </div>
        <!-- /.row -->
    </section>
    <div class="modal fade" id="modal-dialog">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header" style="background: #3c8dbc; color: #fff; padding: 6px 15px;">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">Scheduled Report</h4>
                </div>
                <asp:UpdatePanel ID="udpOutterUpdatePanel" runat="server">
                    <ContentTemplate>

                        <section class="content">
                            <div class="row">
                                <div class="col-xs-12">
                                    <div class="box box-primary query m-b-0">

                                        <div class="box-body">
                                            <div class="form-group col-lg-4">
                                                <label>From Date:</label>

                                                <div class="input-group">
                                                    <div class="input-group-addon">
                                                        <i class="fa fa-calendar"></i>
                                                    </div>
                                                    <div style="position: relative;">
                                                        <asp:TextBox ID="txtsfrom" runat="server" class="form-control input-sm" data-inputmask="'alias': 'dd/mm/yyyy'" />
                                                        <ajax:CalendarExtender ID="CalendarExtender1" CssClass="black" TargetControlID="txtsfrom" Format="dd/MM/yyyy" runat="server">
                                                        </ajax:CalendarExtender>
                                                    </div>

                                                </div>
                                                <!-- /.input group -->

                                            </div>

                                            <div class="form-group col-lg-4">
                                                <label>To Date:</label>

                                                <div class="input-group">
                                                    <div class="input-group-addon">
                                                        <i class="fa fa-calendar"></i>
                                                    </div>
                                                    <asp:TextBox ID="txtsto" runat="server" class="form-control input-sm" data-inputmask="'alias': 'dd/mm/yyyy'" />

                                                    <ajax:CalendarExtender ID="CalendarExtender2" CssClass="black" TargetControlID="txtsto" Format="dd/MM/yyyy" runat="server">
                                                    </ajax:CalendarExtender>

                                                </div>

                                            </div>


                                            <div class="form-group col-lg-4">
                                                <label>Status</label>
                                                <div class="has-feedback">
                                                    <select class="form-control input-sm h-30" id="ddlSearch" runat="server">
                                                        <option value="0">Start</option>
                                                        <option value="1">Stop</option>
                                                    </select>
                                                    <span class="glyphicon glyphicon-menu-down form-control-feedback"></span>
                                                </div>

                                            </div>


                                            <div class="form-group col-lg-4">
                                                <label>From Time:</label>

                                                <div class="input-group">
                                                    <div class="bootstrap-timepicker">
                                                        <input type="text" class="form-control timepicker input-sm" runat="server" id="sfrmTime" value="00:00 AM" />
                                                    </div>
                                                    <div class="input-group-addon">
                                                        <i class="fa fa-clock-o"></i>
                                                    </div>
                                                </div>

                                            </div>

                                            <div class="form-group col-lg-4">
                                                <label>To Time:</label>

                                                <div class="input-group">
                                                    <div class="bootstrap-timepicker">
                                                        <input type="text" class="form-control timepicker input-sm" runat="server" id="stoTime" value="00:00 AM" />

                                                    </div>
                                                    <div class="input-group-addon">
                                                        <i class="fa fa-clock-o"></i>
                                                    </div>
                                                </div>

                                            </div>
                                            <div class="form-group col-lg-4">
                                                <label>&nbsp;</label>

                                                <div class="input-group">
                                                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-success btn-flat btn-pink btn-sm" OnClick="btnSearch_Click" />

                                                </div>

                                            </div>

                                        </div>

                                    </div>

                                    <div class="box-body">

                                        <table id="example2" class="table table-bordered table-striped">
                                            <thead>
                                                <tr>
                                                    <th>Show/Hide</th>
                                                    <th>Report Name</th>
                                                    <th>Role</th>
                                                    <th>Shedule Report Date</th>
                                                    <th>Shedule Report Time</th>
                                                    <th>Status</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <asp:Repeater runat="server" ID="scheduledRepeater">
                                                    <ItemTemplate>


                                                        <tr>
                                                            <li class="input-group m-b-5">
                                                                <asp:HiddenField ID="hddnReportID" runat="server" Value='<%# Eval("RPRT_ID") %>' />
                                                                <td>
                                                                    <asp:LinkButton ID="btnhideandshow" runat="server" Text='<%# ((DataBinder.Eval(Container.DataItem,"PROV").ToString()=="Show")?"Hide":"Show") %>' CommandArgument='<%# Eval("PROV") %>' class='btn btn-warning btn-social btn-flat btn-sm' OnClick="btnhideandshow_Click"></asp:LinkButton>
                                                                    <%--                <input id="chckProvision" type="checkbox" runat="server" /></td>--%>
                                                                    <td><%#Eval("RPRT_NAM") %>                                                          
                                                                    </td>
                                                                    <td><%#Eval("ASSN_ROL") %></td>
                                                                    <td><%# string.Format("{0:dd-MM-yyyy}", Eval("RPRT_DT"))%></td>

                                                                    <td><%#Eval("RPRT_TM") %></td>
                                                                    <td>
                                                                        <asp:LinkButton ID="btnStatus" runat="server" Text='<%# ((DataBinder.Eval(Container.DataItem,"QUE_ACTY").ToString()=="Start")?"Stop":"Start") %>' CommandArgument='<%# Eval("QUE_ACTY") %>' class='btn btn-success btn-social btn-flat btn-sm' OnClick="btnStatus_Click"></asp:LinkButton>
                                                                    </td>
                                                            </li>
                                                        </tr>

                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </tbody>
                                        </table>


                                    </div>

                                    <!-- /.box-body -->

                                    <!-- /.box -->
                                </div>
                            </div>
                            <!-- /.row -->
                        </section>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default pull-left btn-flat btn-sm" data-dismiss="modal">Close</button>

                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>

    <div class="modal fade" id="modal-dialog2">

        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header" style="background: #3c8dbc; color: #fff; padding: 6px 15px;">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">Scheduled Report Log</h4>
                </div>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <section class="content">
                            <div class="row">
                                <div class="col-xs-12">
                                    <div class="box box-primary query m-b-0">
                                        <div class="box-body">
                                            <div class="form-group col-lg-4">
                                                <label>From Date:</label>

                                                <div class="input-group">
                                                    <div class="input-group-addon">
                                                        <i class="fa fa-calendar"></i>
                                                    </div>
                                                    <asp:TextBox ID="txtlogfrom" runat="server" class="form-control input-sm" data-inputmask="'alias': 'dd/mm/yyyy'" />
                                                </div>
                                                <%--<asp:Calendar ID="CalendarExtender3" TargetControlID="txtlogfrom" Format="dd/MM/yyyy" runat="server"></asp:Calendar>--%>
                                                <ajax:CalendarExtender ID="CalendarExtender3" CssClass="black" TargetControlID="txtlogfrom" Format="dd/MM/yyyy" runat="server">
                                                </ajax:CalendarExtender>
                                            </div>

                                            <div class="form-group col-lg-4">
                                                <label>To Date:</label>

                                                <div class="input-group">
                                                    <div class="input-group-addon">
                                                        <i class="fa fa-calendar"></i>
                                                    </div>
                                                    <asp:TextBox ID="txtlogto" runat="server" class="form-control input-sm" data-inputmask="'alias': 'dd/mm/yyyy'" />
                                                    <ajax:CalendarExtender ID="CalendarExtender4" CssClass="black" TargetControlID="txtlogto" Format="dd/MM/yyyy" runat="server">
                                                    </ajax:CalendarExtender>
                                                </div>
                                                <!-- /.input group -->

                                            </div>

                                            <div class="form-group col-lg-4">
                                                <br />
                                                <br />
                                                <div class="radio-inline">
                                                </div>

                                            </div>



                                            <div class="form-group col-lg-4">
                                                <label>From Time:</label>

                                                <div class="input-group">
                                                    <div class="bootstrap-timepicker">
                                                        <input type="text" class="form-control timepicker input-sm" runat="server" id="txtfromtime" value="00:00 AM" />

                                                    </div>
                                                    <div class="input-group-addon">
                                                        <i class="fa fa-clock-o"></i>
                                                    </div>
                                                </div>

                                            </div>

                                            <div class="form-group col-lg-4">
                                                <label>To Time:</label>

                                                <div class="input-group">
                                                    <div class="bootstrap-timepicker">
                                                        <input type="text" class="form-control timepicker input-sm" runat="server" id="txttotime" value="00:00 AM" />

                                                    </div>
                                                    <div class="input-group-addon">
                                                        <i class="fa fa-clock-o"></i>
                                                    </div>
                                                </div>

                                            </div>
                                            <div class="form-group col-lg-4">
                                                <label>&nbsp;</label>

                                                <div class="input-group">
                                                    <asp:Button ID="btnlogSearch" runat="server" Text="Search" CssClass="btn btn-success btn-flat btn-pink btn-sm" OnClick="btnlogSearch_Click" />

                                                </div>

                                            </div>
                                            <div class="form-group col-lg-4">
                                                <br />
                                                <div class="radio-inline">
                                                    <label>
                                                        <input type="radio" value="0" id="pre_db_con" name="type" onclick="toggle_dbwidget(this)" />

                                                        Sheduled Reports
                                                    </label>
                                                </div>
                                                <div class="radio-inline">
                                                    <label>
                                                        <input type="radio" value="1" id="new_db_con" name="type" onclick="toggle_dbwidget(this)" />
                                                        Queue Reports
                                                    </label>
                                                </div>

                                            </div>

                                        </div>


                                    </div>
                                    <div class="new-db" style="display: none;">
                                        <div class="box-body">

                                            <table id="example4" class="table table-bordered table-striped">
                                                <thead>
                                                    <tr>
                                                        <th>Report Name</th>
                                                        <th>Role</th>
                                                        <th>Scheduler Report Date</th>
                                                        <th>Scheduler Report Time</th>
                                                        <th>Scheduler Generated Date</th>
                                                        <th>Scheduler Generated Time</th>

                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <asp:Repeater runat="server" ID="repeaterLogStatus">
                                                        <ItemTemplate>


                                                            <tr>
                                                                <li class="input-group m-b-5">
                                                                    <asp:HiddenField ID="hddnReportID" runat="server" Value='<%# Eval("SCHLD_ID") %>' />
                                                                    <td><%#Eval("RPRT_NAM") %> </td>

                                                                    <td><%#Eval("ASSN_ROL") %></td>

                                                                    <td><%# string.Format("{0:dd-MM-yyyy}", Eval("RPRT_DT"))%></td>
                                                                    <td><%#Eval("RPRT_TM") %></td>

                                                                    <td><%# string.Format("{0:dd-MM-yyyy}", Eval("GNRD_DT"))%></td>
                                                                    <td><%#Eval("GRND_TM") %></td>
                                                                </li>
                                                            </tr>
                                                        </ItemTemplate>
                                                    </asp:Repeater>
                                                </tbody>
                                            </table>


                                        </div>
                                    </div>
                                    <div class="pre-db" style="display: none;">
                                        <div class="box-body">

                                            <table id="example6" class="table table-bordered table-striped">
                                                <thead>
                                                    <tr>
                                                        <th>Report Name</th>
                                                        <th>Role</th>
                                                        <th>Queue Generated Date</th>
                                                        <%-- <th>Queue Generated Time</th>--%>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <asp:Repeater runat="server" ID="qrepeate1">
                                                        <ItemTemplate>


                                                            <tr>
                                                                <li class="input-group m-b-5">
                                                                    <asp:HiddenField ID="hddnReportID" runat="server" Value='<%# Eval("QUE_ID") %>' />
                                                                    <td><%#Eval("RPRT_NAM") %> </td>

                                                                    <td><%#Eval("ASSN_ROL") %></td>

                                                                    <%-- <td><%# string.Format("{0:dd-MM-yyyy}", Eval("RPRT_DT"))%></td>
                                                                    <td><%#Eval("RPRT_TM") %></td>--%>

                                                                    <td><%# string.Format("{0:dd-MM-yyyy}", Eval("UPDT_DT"))%></td>
                                                                    <%--<td><%#Eval("UPDT_DT") %></td>--%>
                                                                </li>
                                                            </tr>
                                                        </ItemTemplate>
                                                    </asp:Repeater>
                                                </tbody>
                                            </table>


                                        </div>
                                    </div>
                                    <!-- /.box-body -->

                                    <!-- /.box -->
                                </div>
                            </div>
                            <!-- /.row -->
                        </section>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <div class="modal-footer">
                    <%-- <asp:Button ID="Button2" runat="server" Text="Save" CssClass="btn btn-success btn-flat btn-pink btn-sm" />--%>
                    <button type="button" class="btn btn-default pull-left btn-flat btn-sm" data-dismiss="modal">Close</button>

                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>

    <div class="modal fade" id="modal-dialog3">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header" style="background: #3c8dbc; color: #fff; padding: 6px 15px;">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">Queue Settings</h4>
                </div>
                <div style="padding: 4px 10px 4px 10px">
                    <div id="comp_field" class="pull-left" style="width: 50%">
                        <div class="col-sm-6 control-label">Max limit</div>
                        <div class="input-group">
                            <input type="text" placeholder="Limit" class="form-control input-sm" runat="server" id="txtDay" value="5" />
                        </div>
                    </div>
                    <div class="clearfix"></div>
                </div>
                <div class="modal-content">
                    <div class="modal-header" style="padding: 6px 15px;">

                        <h4 class="modal-title">Queued Report</h4>
                    </div>
                    <section class="content">
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="box box-primary query">

                                    <div class="box-body">
                                        <table id="example5" class="table table-bordered table-striped">
                                            <thead>
                                                <tr>
                                                    <th>Report Name</th>
                                                    <th>Role</th>
                                                    <th>Queue Report Format</th>
                                                    <th>Queue Report Date</th>

                                                </tr>
                                            </thead>
                                            <asp:Repeater runat="server" ID="qRepeater">
                                                <ItemTemplate>

                                                    <tbody>
                                                        <tr>
                                                            <li class="input-group m-b-5">

                                                                <td><%#Eval("RPRT_NAM") %></td>

                                                                <td><%#Eval("ASSN_ROL") %></td>
                                                                <td><%#Eval("RPRT_FRMT") %></td>

                                                                <td><%# string.Format("{0:dd-MM-yyyy}", Eval("UPDT_DT"))%></td>
                                                            </li>
                                                        </tr>
                                                    </tbody>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </table>


                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" CssClass="btn btn-success btn-flat btn-pink btn-sm" />
                    <button type="button" class="btn btn-default pull-left btn-flat btn-sm" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>


    <script type="text/javascript">


        $(document).ready(function () {

            //$('#Button2').click(function () {
            //    alert("hi");
            //    $(this).attr('disabled', 'disabled');

            //});

            $("#date_between_input1").daterangepicker();

            $('#example1').DataTable({
                dom: 'lfrtip'
            })

            //$('#example6').DataTable({
            //    dom: 'lfrtip'
            //})

            //$('#example2').DataTable({
            //    dom: 'lfrtip'
            //})
        });


        function toggle_dbwidget(obj) {
            var dbtype_val = $(obj).val();
            var show_part_class = (dbtype_val == 0) ? "new-db" : "pre-db"; //alert('show_part_class '+show_part_class);
            $(".new-db, .pre-db").slideUp();
            $("." + show_part_class).slideDown();
        }

        $("#Button2").click(function () {
            $("#load").show();
        });

    </script>
</asp:Content>
