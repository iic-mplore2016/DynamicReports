<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Reports/MasterPage.master" CodeFile="ReportViewer.aspx.cs" Inherits="Reports_ReportViewer" %>

<asp:Content ID="Content" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <script>
        function goBack() {
            window.history.back()
        }
    </script>
    <section class="content-header">
        <%--<div class="pull-left head">
            <h1>Table Report <small>(Report Name, Location)</small></h1>
        </div>--%>
        <div class="pull-right">
            <%--  <a href="#modal-dialog" data-toggle="modal" class="btn btn-success btn-flat btn-sm">Save Report</a>--%>
            <%--  <a href="#" data-toggle="modal" class="btn btn-success btn-flat btn-sm" onclick="goBack()">Back</a>            
            <a href="Query_Builder.aspx" class="btn btn-success btn-flat btn-sm btn-pink">New Report</a>--%>
        </div>
        <div class="clearfix"></div>
    </section>
    <div class="ui-loader-background" id="load">
        <img style="padding-left: 50%; padding-top: 20%;" id="Image1" src="/Images/loading.gif" alt="Processing" />
    </div>
    <section class="content">
        <!-- Small boxes (Stat box) -->
        <div class="row" style="padding-bottom: 10px;">
            <div class="col-sm-12">
                <div>
                    <div>
                        <a id="closePage" class="pull-right btn btn-warning btn-flat btn-sm" href="javascript:window.open('','_self').close();">Close Window</a>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-12">
                <div class="box box-primary tables select-hide">
                    <div class="box-header with-border">
                        <h3 class="box-title">Filter</h3>

                        <!-- <span class="label label-primary pull-right"><i class="fa fa-html5"></i></span> -->
                    </div>

                    <!-- /.box-header -->
                    <div class="box-body">

                        <div class="table-responsive">
                            <asp:Repeater runat="server" ID="filterRepeater" OnItemDataBound="OnItemDataBound">
                                <ItemTemplate>
                                    <li class="input-group m-b-5 filter">
                                        <table class="table table-bordered table-striped" id="filterTable">
                                            <tbody>
                                                <tr>

                                                    <td style="width: 400px;"><span class="form-control" id="<%#Eval("LabelColumn") %>"><%#Eval("LabelColumn") %></span></td>
                                                    <asp:HiddenField ID="hfcName" runat="server" Value='<%# Eval("LabelColumn") %>' />
                                                    <td>
                                                        <div class="has-feedback">
                                                            <asp:DropDownList ID="ddlFilter" runat="server" class="form-control input-sm"></asp:DropDownList>
                                                            <span class="glyphicon glyphicon-menu-down form-control-feedback"></span>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="form-group m-0">
                                                            <asp:TextBox ID="txtFilter" runat="server" class="form-control input-sm"></asp:TextBox>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="has-feedback">
                                                            <asp:DropDownList ID="ddlMore" runat="server" class="form-control input-sm"></asp:DropDownList>

                                                            <span class="glyphicon glyphicon-menu-down form-control-feedback"></span>
                                                        </div>
                                                    </td>
                                                </tr>

                                            </tbody>
                                        </table>

                                    </li>
                                </ItemTemplate>
                            </asp:Repeater>

                        </div>
                        <div class="text-right">
                            <asp:Button ID="btnRun" Style="display: none;" ClientIDMode="Static" runat="server" class="btn btn-primary btn-flat btn-sm" OnClick="btnRun_Click" Text="Run" />
                        </div>
                        <div class="clearfix"></div>

                    </div>
                    <!-- /.box-body -->
                </div>
                <!-- /.box -->
            </div>
        </div>
        <!-- /.row -->
        <div class="row">
            <div class="col-xs-12">
                <div class="box box-primary query">
                    <div class="box-header with-border" style="visibility: hidden;">
                        <div class="col-md-9 no-padding clearfix">
                            <span class="alert alert-dismissable filter-list">filter <a aria-hidden="true" data-dismiss="alert" class="close" type="button"><i class="fa fa-close"></i></a></span>
                            <span class="alert alert-dismissable filter-list">filter <a aria-hidden="true" data-dismiss="alert" class="close" type="button"><i class="fa fa-close"></i></a></span>
                            <span class="alert alert-dismissable filter-list">filter <a aria-hidden="true" data-dismiss="alert" class="close" type="button"><i class="fa fa-close"></i></a></span>
                        </div>
                        <%-- <div class="col-md-3 text-right">
                            <div class="tooltip2"><a href="reports.html" class="btn btn-primary btn-flat m-b-10 export-btn btn-sm"><i class="fa fa-table"></i><span class="tooltiptext2">Table Report</span></a></div>
                            <div class="tooltip2"><a href="reports-groupby.html" class="btn btn-warning btn-flat m-b-10 export-btn btn-sm"><i class="fa fa-indent"></i><span class="tooltiptext2">Groupby Report</span></a></div>
                            <div class="tooltip2"><a href="reports-summary.html" class="btn btn-success btn-flat m-b-10 export-btn btn-sm"><i class="fa fa-file-text"></i><span class="tooltiptext2">Summary Report</span></a></div>
                        </div>--%>
                        <div class="clearfix"></div>
                    </div>
                    <div class="box-body">
                        <table id="example1" class="table table-bordered table-striped" style="width: 100%;">
                        </table>
                    </div>
                    <!-- /.box-body -->
                </div>
                <div class="popup">
                    <span class="popuptext" id="error" style="background-color: red;left: 113%;">Session was cleared..!</span>
                </div>
                <!-- /.box -->
            </div>
        </div>
        <!-- /.row -->
    </section>

    <script type="text/javascript">
        $(document).ready(function () {
            $("#load").show();
            var currentdate = new Date();
            var datetime = "" + currentdate.getDate() + "-" + (currentdate.getMonth() + 1) + "-" + currentdate.getFullYear() + "("
                        + currentdate.getHours() + ""
                        + currentdate.getMinutes() + ""
                        + currentdate.getSeconds() + ")";

            var dvTable = $("#example1");
            var pope = document.getElementById('error');
            $.ajax({
                type: "POST",
                url: "/WebService/Report_Viewer.asmx/ViewReport",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d == "[]" || data.d == "0" || data.d == "") {
                        if (data.d == "0") {
                            pope.classList.toggle('show');
                            setTimeout(function () {
                                pope.classList.toggle('show');
                            }, 3000);
                        }
                        $("#load").hide();
                        data.d = "[]";

                    }
                    console.log(data.d);
                //    var datad = data.d.replace(/\s+/g, "");
                    var sd = JSON.parse(data.d);
                    console.log(sd);
                    makeTable(sd);
                    $("#load").hide();
                    $('#example1').DataTable({
                        scrollX: true,
                        aaSorting: [],
                        dom: 'Blfrtip',
                        buttons: [
                            {
                                extend: 'excel',
                                text: '<i class="fa fa-file-excel-o"></i><span class="tooltiptext2">Export Excel</span>',
                                filename: 'Report_' + datetime.toString(),
                                title: 'Report Generation',
                                className: 'tooltip2 btn btn-success btn-flat m-b-10 export-btn btn-sm pright',
                                exportOptions: {
                                    modifier: {
                                        search: 'none'
                                    },
                                }
                            },
                            {
                                extend: 'csv',
                                text: '<i class="fa fa-file-excel-o"></i><span class="tooltiptext2">Export CSV</span>',
                                filename: 'Report_' + datetime.toString(),
                                title: 'Report Generation',
                                className: 'tooltip2 btn btn-success btn-flat m-b-10 export-btn btn-sm',
                                exportOptions: {
                                    modifier: {
                                        search: 'none'
                                    },
                                }
                            }
                        ]
                    });
                },
                failure: function (reponse) {
                    console.log(reponse);
                    alert("failure");
                },
                error: function (reponse) {
                    alert("error");
                    console.log(reponse);
                },

            });

            function makeTable(mydata) {
                if (mydata.length <= 0) return "";
                return $('#example1').append("<thead><tr>" + $.map(mydata[0], function (val, key) {
                    return "<th>" + key + "</th>";
                }).join("\n") + "</tr><tbody>").append($.map(mydata, function (index, value) {
                    return "<tr>" + $.map(index, function (val, key) {
                        return "<td>" + val + "</td>";
                    }).join("\n") + "</tr>";
                }).join("\n"));
            };

            var rowCount = $("#filterTable tbody tr").length;

            if (rowCount != 0) {
                $("#btnRun").show();
            }
            else {
                $("#btnRun").hide();
            }
        });

        //$("#closePage").click(function () {
        //    window.open('','_self').close(); 
        //});
    </script>

</asp:Content>

