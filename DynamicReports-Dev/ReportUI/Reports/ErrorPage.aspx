<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ErrorPage.aspx.cs" MasterPageFile="~/Reports/MasterPage.master" Inherits="Reports_ErrorPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="alert alert-danger alert-dismissable">
        <button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
        Error in query.
    </div>
    <button onclick="goBack()">Go Back</button>

    <script>
        function goBack() {
            window.history.back();
        }
    </script>


</asp:Content>
