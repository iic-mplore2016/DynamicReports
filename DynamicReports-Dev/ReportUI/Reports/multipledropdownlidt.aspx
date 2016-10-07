<%@ Page Language="C#" AutoEventWireup="true" CodeFile="multipledropdownlidt.aspx.cs" Inherits="Reports_multipledropdownlidt" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:ScriptManager ID="script" runat="server">
            </asp:ScriptManager>
            <asp:UpdatePanel ID="panel" runat="server">
                <ContentTemplate>
                    <div style="margin-left: 70px; margin-top: 20px; border-width: 1px; border-color: Black; border-style: solid; width: 85%;">
                        <%-- <div id="DivCostume" runat="server">
                                
                        </div>
                        --%>
                        <div style="margin-top: 15px; margin-left: 20px;">
                            <asp:GridView ID="Gridview1" runat="server" AutoGenerateColumns="false" ShowFooter="false"
                                BorderStyle="None" BorderColor="White" ShowHeader="false" Width="800px">
                                <Columns>
                                    <asp:TemplateField HeaderText="Header 1">
                                        <ItemTemplate>
                                            <asp:Label ID="dance" runat="server" Text="Dance Style :"></asp:Label>
                                            <asp:DropDownList ID="DropDownList1" runat="server" AppendDataBoundItems="true" Height="22px"
                                                OnSelectedIndexChanged="DropDownA_SelectedIndexChanged" Width="150px" AutoPostBack="true">
                                                <asp:ListItem Value="0">--Select--</asp:ListItem>
                                            </asp:DropDownList>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Header 2">
                                        <ItemTemplate>
                                            <asp:Label ID="costume" runat="server" Text="Costume Style :"></asp:Label>
                                            <asp:DropDownList ID="DropDownList2" runat="server" AppendDataBoundItems="true" AutoPostBack="true"
                                                Width="150px" Height="22px">
                                                <asp:ListItem Value="0">--Select--</asp:ListItem>
                                            </asp:DropDownList>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Header 1">
                                        <ItemTemplate>
                                            <asp:Label ID="dance1" runat="server" Text="Dance Style :"></asp:Label>
                                            <asp:DropDownList ID="DropDownList3" runat="server" AppendDataBoundItems="true" Height="22px"
                                                OnSelectedIndexChanged="DropDownB_SelectedIndexChanged" Width="150px" AutoPostBack="true">
                                                <asp:ListItem Value="0">--Select--</asp:ListItem>
                                            </asp:DropDownList>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Header 2">
                                        <ItemTemplate>
                                            <asp:Label ID="costume1" runat="server" Text="Costume Style :"></asp:Label>
                                            <asp:DropDownList ID="DropDownList4" runat="server" AppendDataBoundItems="true" AutoPostBack="true"
                                                Width="150px" Height="22px">
                                                <asp:ListItem Value="0">--Select--</asp:ListItem>
                                            </asp:DropDownList>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Header 1">
                                        <ItemTemplate>
                                            <asp:Button ID="ButtonRomove" runat="server" Text="Remove" OnClick="ButtonRomove_Click" />
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                </Columns>
                            </asp:GridView>
                        </div>
                        <br />
                        <div id="Divbuttonadd" runat="server" style="width: 80%; margin-top: -25px; margin-left: 680px">
                            <asp:Button ID="ButtonAdd" runat="server" Text="Add Costume" OnClick="ButtonAdd_Click" />

                        </div>
                        <br />
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </form>
</body>
</html>
