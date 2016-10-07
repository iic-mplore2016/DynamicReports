<%@ Page Title="" Language="C#" MasterPageFile="~/Reports/MasterPage.master" AutoEventWireup="true" CodeFile="ScheduledReport.aspx.cs" Inherits="Reports_ScheduledReport" %>
<%@ Register Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" TagPrefix="ajax" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
    <asp:ScriptManager ID="script" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="udpOutterUpdatePanel" runat="server">
                    <ContentTemplate>

                        <section class="content">
                            <div style="padding-left:40%;">
                                <h4>
                                   Scheduled Report
                                </h4>
                            
                            </div>
                            <div class="row">
                                <div class="col-xs-12">
                                    <div class="box box-primary query m-b-0">

                                        <div class="box-body">
                                            <div class="form-group col-lg-4">
                                                <label>From Date:</label>

                                                <div class="input-group">
                                                    <%--<div class="input-group-addon">
                                                        <i class="fa fa-calendar"></i>
                                                    </div>--%>
                                                    <div style="position: relative;">
                                                        <%--<asp:TextBox ID="txtsfrom" runat="server" class="form-control input-sm" data-inputmask="'alias': 'dd/mm/yyyy'" />
                                                        <ajax:CalendarExtender ID="CalendarExtender1" CssClass="black" TargetControlID="txtsfrom" Format="dd/MM/yyyy" runat="server">
                                                        </ajax:CalendarExtender>--%>
                                                        <input id="txtsfrom" runat="server" placeholder="DD/MM/YYYY" class="form-control input-sm"/>
                                                    </div>

                                                </div>
                                                <!-- /.input group -->

                                            </div>

                                            <div class="form-group col-lg-4">
                                                <label>To Date:</label>

                                                <div class="input-group">
                                                    <div style="position: relative;">                                                        
                                                        <input type="text" id="txtsto" runat="server" placeholder="DD/MM/YYYY" class="form-control input-sm"/>
                                                    </div>
                                                   <%-- <div class="input-group-addon">
                                                        <i class="fa fa-calendar"></i>
                                                    </div>
                                                    <asp:TextBox ID="txtsto" runat="server" class="form-control input-sm" data-inputmask="'alias': 'dd/mm/yyyy'" />

                                                    <ajax:CalendarExtender ID="CalendarExtender2" CssClass="black" TargetControlID="txtsto" Format="dd/MM/yyyy" runat="server">
                                                    </ajax:CalendarExtender>--%>

                                                </div>

                                            </div>


                                            <div class="form-group col-lg-4">
                                                <label>Status</label>
                                                <div class="has-feedback input-group">
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
                                                    <div style="position: relative;" class="timepicker_position">
                                                        <input class="form-control input-sm" placeholder="HH:MM TT" runat="server" id="sfrmTime"/>                                                        
                                                    </div>
                                                </div>                                               

                                            </div>

                                            <div class="form-group col-lg-4">
                                                <label>To Time:</label>
                                                <div class="input-group">                                                   
                                                    <div style="position: relative;" class="timepicker_position">
                                                        <input class="form-control input-sm" placeholder="HH:MM TT" runat="server" id="stoTime"/>                                                        
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
            $('#example2').DataTable({
                dom: 'lfrtip'
            })
            $('#<%= sfrmTime.ClientID %>').ptTimeSelect({
                popupImage: '<img src="../icons/time.png" />',
                popupImageOnly: true
            });
            $('#<%= stoTime.ClientID %>').ptTimeSelect({
                popupImage: '<img src="../icons/time.png" />',
                popupImageOnly: true
            });
            $(".timepicker_position a").css("position:", "absolute");
            $(".timepicker_position a").css("right:", "5px");
            $(".timepicker_position a").css("top:", "5px");
            $(".timepicker_position a").css("index:", "2");
        });

        $(function () {
            $('#<%= txtsfrom.ClientID %>').datepicker({
                changeMonth: true,
                changeYear: true,
                numberOfMonths: [1, 1],
                dateFormat: "dd/mm/yy",
                showOn: "button",
                buttonImage: "../icons/calendar.png",
                buttonImageOnly: true,
                showOn: "both",
            });

            $('#<%= txtsto.ClientID %>').datepicker({
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

