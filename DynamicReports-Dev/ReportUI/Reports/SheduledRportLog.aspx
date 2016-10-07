<%@ Page Title="" Language="C#" MasterPageFile="~/Reports/MasterPage.master" AutoEventWireup="true" CodeFile="SheduledRportLog.aspx.cs" Inherits="Reports_SheduledRportLog" %>

<%@ Register Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" TagPrefix="ajax" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager ID="script" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <section class="content">
                            <div style="padding-left:40%;">
                                <h4>
                                   Scheduled Report Log
                                </h4>
                            
                            </div>
                            <div class="row">
                                <div class="col-xs-12">
                                    <div class="box box-primary query m-b-0">
                                        <div class="box-body">
                                            <div class="form-group col-lg-4">
                                                <label>From Date:</label>

                                                <div class="input-group">
                                                     <div style="position: relative;">                                                        
                                                        <input id="txtlogfrom" runat="server" placeholder="DD/MM/YYYY" class="form-control input-sm"/>
                                                    </div>
                                                    <%--<div class="input-group-addon">
                                                        <i class="fa fa-calendar"></i>
                                                    </div>
                                                    <asp:TextBox ID="txtlogfrom" runat="server" class="form-control input-sm" data-inputmask="'alias': 'dd/mm/yyyy'" />--%>
                                                </div>
                                                <%--<asp:Calendar ID="CalendarExtender3" TargetControlID="txtlogfrom" Format="dd/MM/yyyy" runat="server"></asp:Calendar>--%>
                                                <%--<ajax:CalendarExtender ID="CalendarExtender3" CssClass="black" TargetControlID="txtlogfrom" Format="dd/MM/yyyy" runat="server">
                                                </ajax:CalendarExtender>   --%>                                          
                                            </div>

                                            <div class="form-group col-lg-4">
                                                <label>To Date:</label>

                                                <div class="input-group">
                                                    <div style="position: relative;">                                                        
                                                        <input id="txtlogto" runat="server" placeholder="DD/MM/YYYY" class="form-control input-sm"/>
                                                    </div>
                                                    <%--<div class="input-group-addon">
                                                        <i class="fa fa-calendar"></i>
                                                    </div>
                                                    <asp:TextBox ID="txtlogto" runat="server" class="form-control input-sm" data-inputmask="'alias': 'dd/mm/yyyy'" />
                                                    <ajax:CalendarExtender ID="CalendarExtender4" CssClass="black" TargetControlID="txtlogto" Format="dd/MM/yyyy" runat="server">
                                                    </ajax:CalendarExtender>--%>
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
                                                    <div style="position: relative;" class="timepicker_position">
                                                        <input class="form-control input-sm" placeholder="HH:MM TT" runat="server" id="txtfromtime"/>                                                        
                                                    </div>
                                                    <%--<div class="bootstrap-timepicker">
                                                        <input type="text" class="form-control timepicker input-sm" runat="server" id="txtfromtime" value="00:00 AM" />

                                                    </div>
                                                    <div class="input-group-addon">
                                                        <i class="fa fa-clock-o"></i>
                                                    </div>--%>
                                                </div>

                                            </div>

                                            <div class="form-group col-lg-4">
                                                <label>To Time:</label>

                                                <div class="input-group">
                                                    <div style="position: relative;" class="timepicker_position">
                                                        <input class="form-control input-sm" placeholder="HH:MM TT" runat="server" id="txttotime"/>                                                        
                                                    </div>
                                                    <%--<div class="bootstrap-timepicker">
                                                        <input type="text" class="form-control timepicker input-sm" runat="server" id="txttotime" value="00:00 AM" />

                                                    </div>
                                                    <div class="input-group-addon">
                                                        <i class="fa fa-clock-o"></i>
                                                    </div>--%>
                                                </div>

                                            </div>
                                            <div class="form-group col-lg-4">
                                                <label>&nbsp;</label>

                                                <div class="input-group">
                                                    <asp:Button ID="btnlogSearch" runat="server" Text="Search" CssClass="btn btn-success btn-flat btn-pink btn-sm" OnClick="btnlogSearch_Click" />

                                                </div>

                                            </div>
                                            <div class="form-group col-lg-12">
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
                                        
                                        <div class="box-body new-db" style="display: none;">
                                        

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
                                                                <li class="input-group">
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
                                     
                                    <div class="box-body pre-db" style="display: none;">
                                        

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

    <script type="text/javascript">
        $(document).ready(function () {
            $("#date_between_input1").daterangepicker();
            $('#example4').DataTable({
                dom: 'lfrtip'
            });
            $('#example6').DataTable({
                dom: 'lfrtip'
            });
            $('#<%= txtfromtime.ClientID %>').ptTimeSelect({
                popupImage: '<img src="../icons/time.png" />',
                popupImageOnly: true
            });
            $('#<%= txttotime.ClientID %>').ptTimeSelect({
                popupImage: '<img src="../icons/time.png" />',
                popupImageOnly: true
            });
            $(".timepicker_position a").css("position:", "absolute");
            $(".timepicker_position a").css("right:", "5px");
            $(".timepicker_position a").css("top:", "5px");
            $(".timepicker_position a").css("index:", "2");
        });

        function toggle_dbwidget(obj) {
            var dbtype_val = $(obj).val();
            var show_part_class = (dbtype_val == 0) ? "new-db" : "pre-db"; //alert('show_part_class '+show_part_class);
            $(".new-db, .pre-db").slideUp();
            $("." + show_part_class).slideDown();
        }

        $(function () {
            $('#<%= txtlogfrom.ClientID %>').datepicker({
                changeMonth: true,
                changeYear: true,
                numberOfMonths: [1, 1],
                dateFormat: "dd/mm/yy",
                showOn: "button",
                buttonImage: "../icons/calendar.png",
                buttonImageOnly: true,
                showOn: "both",
            });

            $('#<%= txtlogto.ClientID %>').datepicker({
                changeMonth: true,
                changeYear: true,
                numberOfMonths: [1, 1],
                dateFormat: "dd/mm/yy",
                showOn: "button",
                buttonImage: "../icons/calendar.png",
                buttonImageOnly: true,
                showOn: "both",
            });

            <%--$('#<%= sfrmTime.ClientID %>').click(function (){
                return false;
            });--%>

            <%-- $('#<%= sfrmTime.ClientID %>').ptTimeSelect({
                popupImage: '<img src="../icons/time.png" />'
            });--%>

        });
    </script>
</asp:Content>

