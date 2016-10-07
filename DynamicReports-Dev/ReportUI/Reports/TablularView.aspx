<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TablularView.aspx.cs" MasterPageFile="~/Reports/MasterPage.master" Inherits="Reports_TablularView" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <table id="example1" class="table table-bordered table-striped" style="width: 100%;">
    </table>


    <script type="text/javascript">
        var qrStr = window.location.search;
        qrStr = qrStr.split("?")[1].split("=")[1];
        $(document).ready(function () {


            //  alert(id);
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
                // url: "http://192.168.1.29:8090/WebService/WebService.asmx;
                url: "/WebService/WebService.asmx/ViewReport?rID=" + qrStr + "",
                // url: "http://192.168.1.29:8090/WebService/WebService.asmx/ViewReport?rID=" + qrStr + "",
                // url: "http://192.168.1.29:8090/WebService/WebService.asmx/ViewReport",
                data: "{}",
                contentType: "application/json; charset=utf-8",

                dataType: 'json',
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
