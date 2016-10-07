<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Connect_to_Server.aspx.cs" Inherits="Reports_Connect_to_Server" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>

    <link rel="stylesheet" href="../CSS/bootstrap.css" />
    <!-- Font Awesome -->
    <link rel="stylesheet" href="../CSS/font-awesome.min.css" />

    <link rel="stylesheet" href="../CSS/ionicons.min.css" />

    <link rel="stylesheet" href="../CSS/AdminLTE.css" />

    <link rel="stylesheet" href="../CSS/custom.css" />

</head>
<body class="hold-transition login-page select-hide">
    <form id="form" runat="server" class="form-horizontal">
        <div class="login-box">
            <div class="login-logo">
                <img src="../Images/iinterchange.png" alt="logo" />

            </div>
            <!-- /.login-logo -->
            <div class="login-box-body">
                <div class="login-box-head">Reporting Tool - Connect a Database</div>


                <div class="pre-db">
                    <%-- <div class="form-group has-feedback">
                        <label class="col-sm-4 control-label">Server Type</label>
                        <div class="col-sm-8">
                            <asp:DropDownList ID="ddlServerType" runat="server" CssClass="form-control input-sm"></asp:DropDownList>
                            <span class="glyphicon glyphicon-menu-down form-control-feedback"></span>
                        </div>
                    </div>--%>
                    <div class="form-group has-feedback">
                        <label class="col-sm-4 control-label">ConnectionString</label>
                        <div class="col-sm-8">
                            <input id="dataSource" type="text" class="form-control input-sm" placeholder="ConnectionString" runat="server" />
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-xs-12">
                            <asp:Button ID="btnConnect" runat="server" Text="Connect" OnClick="btnConnect_Click" class="btn btn-primary btn-block btn-flat btn-pink" />
                        </div>
                    </div>
                    <div class="col-xs-12 m-t-10">
                        <div class="alert alert-danger alert-dismissable" id="errMassege" runat="server" visible="false">
                            <button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
                            Status is error.
                        </div>
                        <%--<div class="alert alert-success alert-dismissable" > 
                            <button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
                            Status is success.
                        </div>--%>
                    </div>
                </div>
                <a href="ReportViewer.aspx" target="_blank"></a>
                <!-- /.login-box-body -->
            </div>
        </div>
    </form>

</body>
</html>


