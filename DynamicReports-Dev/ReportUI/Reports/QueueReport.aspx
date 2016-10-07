<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Reports/MasterPage.master" CodeFile="QueueReport.aspx.cs" Inherits="Reports_QueueReport" %>

<asp:Content ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type="text/javascript">


        //function SetTarget() {
        //    document.forms[0].target = "_blank";
        //}

    </script>
    <section class="content">

        <div class="row">
            <div class="col-xs-12">
                <div class="box">

                    <div class="box-body">


                        <div class="form-group col-lg-2">
                            <label>From Date:</label>
                            <div class="input-group">
                                <div>
                                    <input style="position: relative;" id="txtsfrom" runat="server" placeholder="DD/MM/YYYY" class="form-control input-sm" />
                                </div>
                            </div>
                        </div>

                        <div class="form-group col-lg-2">
                            <label>To Date:</label>
                            <div class="input-group">
                                <div style="position: relative;">
                                    <input type="text" id="txtsto" runat="server" placeholder="DD/MM/YYYY" class="form-control input-sm" />
                                </div>
                            </div>
                        </div>

                        <div class="form-group col-lg-2">
                            <label>Status</label>
                            <div class="has-feedback input-group">
                                <select class="form-control input-sm h-30" id="ddlStatus" runat="server">
                                    <option value="Please Select">Please Select</option>
                                    <option value="Queue">Queue</option>
                                    <option value="Completed">Completed</option>
                                </select>
                                <span class="glyphicon glyphicon-menu-down form-control-feedback"></span>
                            </div>
                        </div>

                        <div class="form-group col-lg-2">
                            <label>&nbsp;</label>
                            <div class="input-group">
                                <%--OnClick="btnSearch_Click"--%>
                                <asp:Button ID="btnSearch" runat="server" Text="Search" OnClientClick="return checkDate()" CssClass="btn btn-success btn-flat btn-pink btn-sm" OnClick="btnSearch_Click" />
                            </div>
                        </div>

                        <div class="form-group col-lg-4">
                            <label>&nbsp;</label>
                            <div class="input-group">
                                <asp:Button ID="btnRefresh" runat="server" Text="Refresh" CssClass="btn btn-success btn-flat btn-pink btn-sm" OnClick="btnSearch_Click" />
                            </div>
                        </div>
                        <table id="example2" class="table table-bordered table-striped">
                            <thead>
                                <tr>
                                    <th>Report Title</th>
                                    <th>Report Name</th>
                                    <th>Report Format</th>
                                    <th>Created By</th>
                                    <th>Created Date</th>
                                    <th>Generated Date</th>
                                    <th>Status</th>
                                    <th>View</th>
                                </tr>
                            </thead>

                            <tbody>
                                <asp:Repeater runat="server" ID="queueReport">
                                    <ItemTemplate>
                                        <%--  OnClientClick="SetTarget();"--%>
                                        <tr>
                                            <li class="input-group">
                                                <td><%#Eval("RPRT_TTL") %></td>
                                                <td><%#Eval("RPRT_NAM") %></td>
                                                <td><%#Eval("RPRT_FRMT") %></td>
                                                <td><%#Eval("CRTD_BY")%></td>
                                                <td><%# string.Format("{0:dd-MM-yyyy}", Eval("CRTD_DT"))%></td>
                                                <td><%# string.Format("{0:dd-MM-yyyy hh:mm:ss tt}", Eval("GNRTD_DT"))%></td>
                                                <td><%#Eval("STTS") %></td>
                                                <td>
                                                    <asp:LinkButton ID="btnView" runat="server" Text="View" CommandArgument='<%#Eval("FL_NAM")+";" +Eval("RPRT_FRMT")%>' OnClick="btnDownloadFile_Click"></asp:LinkButton></td>
                                            </li>
                                        </tr>

                                    </ItemTemplate>
                                </asp:Repeater>
                            </tbody>
                        </table>
                    </div>

                </div>
            </div>
        </div>
    </section>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#example2').DataTable({
                aaSorting: [],
                dom: 'lfrtip'
            })
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

            //$('#example5').DataTable({
            //    dom: 'lfrtip'
            //});
        });

        function viewReport(repid) {
            alert(repid);
        }
        //$("#btnRefresh").click(function () {
        //    location.reload();
        //});

        function checkDate() {
            var popf = document.getElementById('fdate');
            var popt = document.getElementById('tdate');

            if ($('#<%= txtsfrom.ClientID %>').val() != null && $('#<%= txtsfrom.ClientID %>').val() != "") {
                if ($('#<%= txtsto.ClientID %>').val() == null || $('#<%= txtsto.ClientID %>').val() == "") {
                    $('#<%= txtsto.ClientID %>').css("border-color", "red");
                    $('#<%= txtsfrom.ClientID %>').css("border-color", "#e1e1d0");
                    return false;
                }
                else {
                    $('#<%= txtsto.ClientID %>').css("border-color", "#e1e1d0");
                }
            }


            if ($('#<%= txtsto.ClientID %>').val() != null && $('#<%= txtsto.ClientID %>').val() != "") {
                if ($('#<%= txtsfrom.ClientID %>').val() == null || $('#<%= txtsfrom.ClientID %>').val() == "") {
                    $('#<%= txtsfrom.ClientID %>').css("border-color", "red");
                    $('#<%= txtsto.ClientID %>').css("border-color", "#e1e1d0");
                    return false;
                }
                else {
                    $('#<%= txtsfrom.ClientID %>').css("border-color", "#e1e1d0");
                }
            }


        }
    </script>
</asp:Content>
