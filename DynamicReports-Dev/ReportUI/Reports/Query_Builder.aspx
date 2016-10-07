<%@ Page Language="C#" AutoEventWireup="true" ValidateRequest="false" MasterPageFile="~/Reports/MasterPage.master" CodeFile="Query_Builder.aspx.cs" Inherits="Reports_Query_Builder" %>

<%@ Register Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" TagPrefix="ajax" %>
<asp:Content ID="content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <script type="text/javascript">

        function selectAll(InputCheck) {

        }

        function SetTarget() {
            document.forms[0].target = "_blank";
        }
        var expanded = false;
        $(".select2").select2();

    </script>


    <asp:ScriptManager EnablePartialRendering="true" ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <aside class="main-sidebar">

        <section class="sidebar select-table">
            <div class="ui-loader-background" id="load1">
                <img style="padding-left: 50%; padding-top: 20%;" id="Image2" src="/Images/loading.gif" alt="Processing" />
            </div>
            <%--  <div class="menu-heading">List of Tables</div>--%>
            <%-- <ul class="sidebar-menu m-b-10" id="ulparent" runat="server">--%>
            <div class="form-group has-feedback" style="width: 92%; margin: 0 4% 3% 4%;">

                <select id="ddlPriority" onchange="toggle_dbwidget(true)" class="form-control input-sm" style="width: 100%;">
                    <option value="0">Select Table/View</option>
                    <option value="Tables">Tables</option>
                    <option value="Views">Views</option>
                    <option value="Both">Both</option>
                </select>
                <span class="glyphicon glyphicon-menu-down form-control-feedback"></span>

            </div>
            <table id="example10" class="dataTables_filter" style="width: 100% !important; margin-bottom: 5px;">

                <thead>

                    <tr>
                        <th class="no-sort" style="padding-right: 0;">

                            <div class="menu-heading">
                                <asp:Label runat="server" ClientIDMode="Static" ID="lbltov" Text=""></asp:Label>
                            </div>
                        </th>
                    </tr>
                </thead>

                <tbody>
                </tbody>

            </table>

            <div class="col-sm-12 m-b-20">

                <button id="btnSelect" type="button" class="btn btn-primary btn-block btn-flat btn-pink btn-sm" style="display: none;">Select</button>

            </div>
            <%--<div class="col-sm-12 m-b-20" id="tinfo" style="display: none; background-color: orange;">
                <span class="info" style="color: white;"><i class="fa fa-info-circle"></i>Selected Fields are highlighted in RED COLOUR.</span>
            </div>--%>
        </section>

        <!-- /.sidebar -->
    </aside>

    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <div class="pull-left head">
                <h1>Report Designer</h1>
            </div>
            <div class="pull-right">
                <a href="#modal-dialogsd" id="svreport" data-toggle="modal" style="display: none;" class="btn btn-success btn-flat btn-sm">Save Report</a>
                <%--  <a href="ReportViewer.aspx" target="_blank" id="btngeneratereport1" style="display: none;" class="btn btn-primary btn-flat btn-pink btn-sm">Generate Report</a>--%>
                <asp:Button ID="btnGenerates" Style="display: none; visibility: hidden;" ClientIDMode="Static" runat="server" Text="Generate Report" class="btn btn-primary btn-flat btn-pink btn-sm" OnClick="btngeneratereport_Click" />
            </div>
            <div class="clearfix"></div>
        </section>
        <!-- Main content -->
        <section class="content">
            <!-- Small boxes (Stat box) -->
            <div class="row">
                <div class="col-sm-12">
                    <div class="box box-primary tables">
                        <div class="box-header with-border">
                            <div class="pull-left">
                                <h3 class="box-title">Selected Columns</h3>
                                <div class="btn bg-purple btn-flat btn-sm tooltip2"><a href="#modal-dialog2" data-toggle="modal" id="modal-dialog2_href"><i class="fa fa-list"></i></a><span class="tooltiptext2">GroupBy</span></div>
                                <div class="btn bg-purple btn-flat btn-sm tooltip2"><a href="#modal-dialog3" data-toggle="modal" id="modal-dialog3_href"><i class="fa fa-desktop"></i></a><span class="tooltiptext2">Computing</span></div>
                                <%--                  <div class="btn bg-purple btn-flat btn-sm tooltip2"><a href="#modal-dialog4" data-toggle="modal"><i class="fa fa-sort"></i></a><span class="tooltiptext2">Sort Order</span></div>--%>
                            </div>
                            <div class="pull-right" style="width: 50%">
                                <div class="form-horizontal">
                                    <div class="form-group has-feedback m-b-0">
                                        <label class="col-sm-5 control-label text-left">Type of Report</label>
                                        <div class="col-sm-7">
                                            <select class="form-control input-sm" id="report_option" onchange="return show_tab();">
                                                <option value="tbl_report">Table Report</option>
                                                <%--   <option value="groupby_report">Group by Report</option>
                                                <option value="sub_report">Sub Report</option>--%>
                                            </select>
                                            <span class="glyphicon glyphicon-menu-down form-control-feedback"></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>

                        <!-- /.box-header -->
                        <div class="box-body" style="background: #a5a5a5;">
                            <div class="nav-tabs-custom">
                                <ul class="nav nav-tabs">
                                    <li id="li_tbl_report" class="active"><a href="#table-report" data-toggle="tab">Table Report</a></li>
                                    <li id="li_sub_report" style="display: none;"><a href="#sub-report" data-toggle="tab">Sub Report</a></li>
                                </ul>

                                <div class="tab-content no-padding">
                                    <div class="tab-pane active" id="table-report">
                                        <div class="form-horizontal">
                                            <div class="row">
                                                <div class="col-md-4 m-b-10">
                                                    <span class="drag-info"><i class="fa fa-info-circle"></i>Re-ordering the fields by drag and drop</span>
                                                    <%--    <ul class="justList"></ul>--%>
                                                    <%-- <ul class="selectedField" id="input_group_widget1">
                                                    </ul>--%>
                                                    <asp:HiddenField ID="HddnselectedField" runat="server" Value="" ClientIDMode="Static" />
                                                    <ul class="selectedField" id="input_group_widget">
                                                    </ul>
                                                </div>

                                                <div class="col-md-4 m-b-10">
                                                    <div class="font-white" id="form_group_widget">
                                                        <button type="button" onclick="closeTab(false)" class="close" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                        <label id="lbl_colname" class="lbl_head">&nbsp;</label>

                                                        <div class="form-group">
                                                            <label class="col-sm-4" for="">isDisplay</label>
                                                            <div class="col-sm-8">
                                                                <input id="tisDisplay" type="checkbox" checked />
                                                                <%-- <asp:CheckBox ID="tisDisplay" runat="server" Checked="true" />--%>
                                                                <%-- <input type="checkbox" id="tisDisplay" checked runat="server" />--%>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="col-sm-4" for="">Display Name</label>
                                                            <div class="col-sm-8">
                                                                <asp:TextBox ID="tdisplayName" CssClass="form-control input-sm" runat="server" Text="" ClientIDMode="Static"></asp:TextBox>
                                                                <%-- <input type="text" placeholder="Enter Name" id="tdisplayName" class="form-control input-sm" runat="server" />--%>
                                                            </div>
                                                        </div>
                                                        <div style="border: ridge rgba(26, 163, 255, .1);">
                                                            <div class="form-group">
                                                                <label class="col-sm-4" for="">isFilter</label>
                                                                <div class="col-sm-8">
                                                                    <input id="tisFilter" type="checkbox" />
                                                                </div>
                                                            </div>
                                                            <div class="form-group has-feedback">
                                                                <label class="col-sm-4" for="">Data Type</label>
                                                                <div class="col-sm-8">
                                                                    <asp:DropDownList ID="ddlDataType" runat="server" onchange="master_datatype(this,lbl_colname)" CssClass="form-control input-sm"></asp:DropDownList>
                                                                    <span class="glyphicon glyphicon-menu-down form-control-feedback"></span>
                                                                </div>

                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="col-sm-4" for="">Precondition</label>
                                                            <div class="col-sm-8">
                                                                <input type="checkbox" class="preCondition" id="preCondition" disabled />

                                                            </div>
                                                        </div>
                                                        <div class="form-group has-feedback">
                                                            <label class="col-sm-4" for="">Aggregation</label>
                                                            <div class="col-sm-8">
                                                                <asp:DropDownList ID="ddlagregation" runat="server" CssClass="form-control input-sm"></asp:DropDownList>
                                                                <span class="glyphicon glyphicon-menu-down form-control-feedback"></span>
                                                            </div>
                                                        </div>

                                                        <div class="form-group has-feedback">
                                                            <label class="col-sm-4" for="">Sort by</label>
                                                            <div class="col-sm-8">
                                                                <asp:DropDownList ID="ddlsortOrder" runat="server" CssClass="form-control input-sm"></asp:DropDownList>
                                                                <span class="glyphicon glyphicon-menu-down form-control-feedback"></span>
                                                            </div>
                                                        </div>

                                                        <div class="form-group has-feedback">
                                                            <label class="col-sm-4" for=""></label>

                                                            <div class="col-sm-8">
                                                                <asp:Button ID="btnreset" ClientIDMode="Static" runat="server" Text="Reset" class="btn btn-warning btn-sm btn-flat pull-right m-r-10 m-b-10" />
                                                                <asp:Button ID="btnreorderSave" ClientIDMode="Static" Style="display: none;" runat="server" Text="Save" class="btn btn-success btn-sm btn-flat pull-right m-r-10 m-b-10" />
                                                            </div>
                                                        </div>

                                                    </div>
                                                </div>

                                                <div class="col-md-4 m-b-10">
                                                    <div class="font-white" id="form_group_widget2" style="background: #3c8dbc; padding: 10px; height: auto; min-height: 314px; display: none;">
                                                        <%--<button type="button" onclick="closeTabMaster(false)" class="close" aria-label="Close"><span aria-hidden="true">&times;</span></button>--%>
                                                        <label id="" class="lbl_head">MASTER</label>
                                                        <asp:HiddenField ID="lbltext" runat="server" ClientIDMode="Static" Value="" />
                                                        <div class="form-group has-feedback">
                                                            <label class="col-sm-4" for="">Table/View</label>
                                                            <div class="col-sm-8">
                                                                <select id="ddlmLookup" onchange="master_lookup()" class="form-control input-sm " style="width: 100%;">
                                                                    <option value="0">Choose Table/View</option>
                                                                    <option value="Tables">Tables</option>
                                                                    <option value="Views">Views</option>

                                                                </select>
                                                                <span class="glyphicon glyphicon-menu-down form-control-feedback"></span>
                                                            </div>
                                                        </div>


                                                        <div class="form-group has-feedback">
                                                            <label class="col-sm-4" for="" id="tvname"></label>
                                                            <div class="col-sm-8 selectbox">
                                                                <select id="ddlmlookuptable" class="form-control input-sm select2" onchange="master_lookup_table()" style="width: 100%;">
                                                                    <option value="0">Please Choose</option>

                                                                </select>
                                                                <span class="glyphicon glyphicon-menu-down form-control-feedback"></span>
                                                            </div>
                                                        </div>

                                                        <div class="form-group">
                                                            <label class="col-sm-4" for="">Column Name</label>
                                                            <div class="col-sm-8 mtable" id="lookupdiv">
                                                                <table id="lookuptable">

                                                                    <thead>
                                                                    </thead>

                                                                    <tbody>
                                                                    </tbody>



                                                                </table>
                                                            </div>

                                                        </div>

                                                        <div class="form-group has-feedback">
                                                            <label class="col-sm-4" for="">Mapping Fields</label>
                                                            <div class="col-sm-8">
                                                                <select id="ddlmlookupfields" onchange="changemapfield()" class="form-control input-sm" style="width: 100%;">
                                                                    <option value="0">Select Fields</option>

                                                                </select>
                                                                <span class="glyphicon glyphicon-menu-down form-control-feedback"></span>
                                                            </div>
                                                        </div>


                                                        <div class="form-group">
                                                            <div class="col-lg-8">
                                                                <div class="popup">
                                                                    <span class="popuptext" id="ltype" style="background-color: red;">Please Choose Lookup Type</span>
                                                                    <span class="popuptext" id="tbl" style="background-color: red;">Please Choose Table</span>
                                                                    <span class="popuptext" id="aofield" style="background-color: red;">Select Atleast One Field</span>
                                                                    <span class="popuptext" id="mfield" style="background-color: red;">Please Choose Mapping Field</span>
                                                                    <span class="popuptext" id="aname" style="background-color: red;">Please Give Alias Name for Selected Fields.</span>
                                                                </div>
                                                            </div>
                                                            <div class="col-sm-4 text-right">
                                                                <asp:Button ID="btnmApply" ClientIDMode="Static" runat="server" Text="Apply" class="btn btn-warning btn-flat btn-sm" />

                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <div class="col-sm-12">
                                                                <div class="box box-primary collapsed-box query">

                                                                    <div class="box-header with-border">
                                                                        <label id="lbllookupquery" style="color: #666; word-wrap: break-word;"></label>

                                                                    </div>

                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>


                                                <div class="col-md-4 m-b-10">
                                                    <div class="font-white" id="form_control_widget">
                                                        <div>
                                                            <label class="lbl_head" id="lbl_colname2">&nbsp;</label>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-md-5">
                                                                <div class="col-md-12 form-group has-feedback">
                                                                    <select class="form-control input-sm" id="in_between">
                                                                        <option value="">=</option>
                                                                        <option value="between">between</option>
                                                                        <option value="in">in</option>
                                                                    </select>
                                                                    <span class="glyphicon glyphicon-menu-down form-control-feedback"></span>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-5">
                                                                <div class="form-group" id="as_name">
                                                                    <input class="form-control input-sm" type="form-control" placeholder="">
                                                                </div>
                                                                <div class="form-group" id="date_between" style="display: none;">
                                                                    <input class="form-control input-sm" type="form-control" placeholder="date range" id="date_between_input">
                                                                </div>
                                                            </div>
                                                            <div class="col-md-2">
                                                                <a href="#" class="btn btn-warning btn-sm btn-flat"><i class="fa fa-plus-square"></i></a>
                                                            </div>
                                                        </div>
                                                        <div class="clearfix m-b-20"></div>
                                                    </div>
                                                </div>

                                            </div>

                                            <button id="btnClearFields" style="display: none;" class="btn btn-warning btn-sm btn-flat pull-right m-r-10 m-b-10">Clear</button>


                                            <%-- OnClick="btnreorderSave_Click"--%>
                                            <div class="clearfix"></div>
                                        </div>
                                    </div>
                                    <%-- for toast messages --%>
                                    <div class="popup">
                                        <span class="popuptext" id="cleared">Successfully Cleared..!</span>
                                        <span class="popuptext" id="saved">Successfully Saved..!</span>
                                        <span class="popuptext" id="vserror" style="background-color: red;">Error in Query..!</span>
                                        <span class="popuptext" id="popie" style="background-color: red; text-wrap: inherit;"></span>
                                        <span class="popuptext" id="vsuccess">Query Validated Successfully Saved..!</span>
                                        <span class="popuptext" id="verror" style="background-color: red;">There is no Referential Integrity..! Please Make Manual Join</span>
                                        <span class="popuptext" id="jerror" style="background-color: red;">There is no Referential Integrity..!</span>
                                        <span class="popuptext" id="fillmust" style="background-color: red;">Fill Display Name..!</span>
                                        <span class="popuptext" id="nonone" style="background-color: red;">Please Select Data Type..!</span>
                                        <span class="popuptext" id="rsaved">Successfully Saved..!</span>
                                    </div>
                                    <%-- for toast messages --%>
                                    <div class="tab-pane" id="sub-report">

                                        <div class="row">
                                            <div class="col-md-4 m-b-10">
                                                <span class="drag-info"><i class="fa fa-info-circle"></i>Re-ordering the fields by drag and drop</span>

                                                <ul id="input_group_widget">
                                                    <asp:Repeater runat="server" ID="subRepeater">
                                                        <ItemTemplate>
                                                            <li class="input-group m-b-5">
                                                                <span class="input-group-addon">
                                                                    <input type="radio" name="colmuns">
                                                                </span>
                                                                <span class="form-control" id="colname<%#Eval("tableField") %>"><%#Eval("tableField") %></span>
                                                                <span class="form-control-feedback font-white" id="right_arrow"></span>
                                                            </li>
                                                        </ItemTemplate>
                                                    </asp:Repeater>

                                                </ul>

                                            </div>

                                            <div class="col-md-4 m-b-10">
                                                <div class="font-white" id="form_group_widget">

                                                    <!-- <div class="form-group">
																	<label class="col-sm-12" id="lbl_colname">&nbsp;</label>
																</div> -->
                                                    <label id="lbl_colnameaaa" class="lbl_head" style="">&nbsp;</label>
                                                    <div class="form-group">
                                                        <label class="col-sm-4" for="">isDisplay</label>
                                                        <div class="col-sm-8">
                                                            <input type="checkbox" id="" checked>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-sm-4" for="">Display Name</label>
                                                        <div class="col-sm-8">
                                                            <input type="text" placeholder="Enter Name" id="" class="form-control input-sm">
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-sm-4" for="">isFilter</label>
                                                        <div class="col-sm-8">
                                                            <input type="checkbox" id="">
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-sm-4" for="">Precondition</label>
                                                        <div class="col-sm-8">
                                                            <input type="checkbox" id="" />
                                                        </div>
                                                    </div>
                                                    <div class="form-group has-feedback">
                                                        <label class="col-sm-4" for="">Aggregation</label>
                                                        <div class="col-sm-8">
                                                            <select class="form-control input-sm">
                                                                <option>None</option>
                                                                <option>Sum</option>
                                                                <option>Min</option>
                                                                <option>Avg</option>
                                                                <option>Count</option>
                                                                <option>Max</option>
                                                            </select>
                                                            <span class="glyphicon glyphicon-menu-down form-control-feedback"></span>
                                                        </div>
                                                    </div>

                                                </div>
                                            </div>

                                            <div class="col-md-4 m-b-10">
                                                <div class="font-white" id="form_control_widget1">
                                                    <div>
                                                        <label id="lbl_colname2" class="lbl_head" style="">&nbsp;</label>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-5">
                                                            <div class="col-md-12 form-group has-feedback">
                                                                <select class="form-control input-sm" id="in_between">
                                                                    <option value="">=</option>
                                                                    <option value="between">between</option>
                                                                    <option value="in">in</option>
                                                                </select>
                                                                <span class="glyphicon glyphicon-menu-down form-control-feedback"></span>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-5">
                                                            <div class="form-group" id="as_name">
                                                                <input class="form-control input-sm" type="form-control" placeholder="">
                                                            </div>
                                                            <div class="form-group" id="date_between" style="display: none;">
                                                                <input class="form-control input-sm" type="form-control" placeholder="date range" id="date_between_input">
                                                            </div>
                                                        </div>
                                                        <div class="col-md-2">
                                                            <button class="btn btn-warning btn-sm btn-flat"><i class="fa fa-plus-square"></i></button>
                                                        </div>
                                                    </div>
                                                    <div class="clearfix m-b-20"></div>
                                                </div>
                                            </div>


                                            <%--<div class="col-md-4 m-b-10">
                                                <div class="font-white" id="form_group_widget2">

                                                   
                                                    <div class="form-group has-feedback">
                                                        <label class="col-sm-4" for="">Table Name</label>
                                                        <div class="col-sm-8">
                                                            <select class="form-control input-sm">
                                                                <option>Table1</option>
                                                                <option>Table2</option>
                                                          
                                                            </select>
                                                            <span class="glyphicon glyphicon-menu-down form-control-feedback"></span>
                                                        </div>
                                                    </div>

                                                    <div class="form-group has-feedback">
                                                        <label class="col-sm-4" for="">Column Name</label>
                                                        <div class="col-sm-8">
                                                            <select class="form-control input-sm">
                                                                <option>Column1</option>
                                                                <option>Column2</option>
                                                                <option>Column3</option>
                                                                                                                           
                                                            </select>
                                                            <span class="glyphicon glyphicon-menu-down form-control-feedback"></span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>--%>
                                        </div>
                                        <button class="btn btn-success btn-sm btn-flat pull-right m-r-10 m-b-10" name="sub" type="submit" id="submit_btn">Save</button>
                                        <div class="clearfix"></div>

                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- /.box-body -->
                    </div>
                    <!-- /.box -->
                </div>
            </div>
            <!-- /.row -->
            <div class="text-right pull-right" style="padding-bottom: 10px;">
                <br />
                <%--OnClick="btnvalidate_Click"--%>

                <asp:Button ID="btnGenerate" Style="display: none; visibility: hidden" ClientIDMode="Static" runat="server" Text="Generate Report" OnClientClick="SetTarget();" class="btn btn-primary btn-flat btn-pink btn-sm" OnClick="btngeneratereport_Click" />
                <button id="btnvalidate" style="display: none;" type="button" onclick="validate(true)" class="btn btn-warning btn-flat btn-sm">Validate</button>
                <%--<a href="ReportViewer.aspx" target="_blank" id="btngeneratereport" style="display: none;" class="btn btn-primary btn-flat btn-pink btn-sm">Generate Report</a>--%>
            </div>
            <div class="row">
                <div class="col-sm-12">
                    <div class="box box-primary collapsed-box query">

                        <div class="box-header with-border">
                            <h3 class="box-title">Manual Join</h3>
                            <div class="box-tools pull-right">
                                <button id="manual" data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-plus"></i></button>
                            </div>

                        </div>
                        <!-- /.box-header -->
                        <div class="box-body">


                            <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                <ContentTemplate>

                                    <div class="row">
                                        <div class="col-lg-12">
                                            <table class="table table-bordered" id="table_feilds">
                                                <thead>
                                                    <tr>
                                                        <th>Table Name</th>
                                                        <th>Column Name</th>
                                                        <th>Join Type</th>
                                                        <th>Table Name</th>
                                                        <th>Column Name</th>
                                                        <th>&nbsp;</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                        <%--<div class="col-lg-1">
                                                        <button type="button" id="2" class="btn btn-error btn-flat btn-sm" onclick="return delRow((this).id)"><i class="fa fa-minus-circle"></i></button>
                                                    </div>--%>
                                        <div class="clearfix"></div>
                                        <div class="col-lg-12">
                                            <div class="pull-left text-left">
                                                <label style="display: none; color: red;" id="mjValidation">For Manual Joining You Need Atleast Two Tables..!</label>
                                                <div class="tooltip2">
                                                    <button type="button" style="display: none;" id="clearJoining" class="btn btn-warning btn-sm btn-flat pull-left m-r-10 m-b-10">Clear</button><span class="tooltiptext2">Clear Join</span>
                                                </div>
                                            </div>
                                            <div class="pull-right text-right">

                                                <div class="tooltip2">
                                                    <button type="button" id="add_mjoin" class="btn btn-success btn-flat btn-sm m-r-10"><i class="fa fa-plus-square"></i></button>
                                                    <span class="tooltiptext2">Add Join</span>
                                                </div>
                                                <button type="button" id="saveJoining" style="display: none;" class="btn btn-success btn-flat btn-pink btn-sm pull-right">Apply</button>
                                            </div>
                                            <div class="clearfix"></div>
                                        </div>
                                        <div class="popup" style="padding-left: 20%;">
                                            <span class="popuptext" id="mjerror" style="background-color: red;">Select All Fields..!</span>
                                            <span class="popuptext" id="mjsaved">Successfully Saved..!</span>
                                            <span class="popuptext" id="mjnone">There is no Join in Table, Please Make Manual join..!</span>
                                        </div>


                                        <asp:HiddenField ID="master_tables" runat="server" Value="" ClientIDMode="static" />
                                        <asp:HiddenField ID="mjquery" runat="server" Value="" ClientIDMode="static" />
                                    </div>

                                </ContentTemplate>
                            </asp:UpdatePanel>


                            <div class="clearfix"></div>


                            <!-- /.box-body -->
                        </div>


                        <div class="text-right pull-right">
                        </div>
                        <!-- /.box -->
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-sm-12">
                    <div class="box box-primary collapsed-box query">

                        <div class="box-header with-border">
                            <h3 class="box-title">Build Query</h3>
                            <div class="box-tools pull-right">
                                <button id="ssss" data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-plus"></i></button>
                            </div>
                            <!-- <span class="label label-primary pull-right"><i class="fa fa-html5"></i></span> -->
                        </div>
                        <!-- /.box-header -->
                        <div class="box-body">
                            <div>
                                <table class="table table-bordered table-striped">
                                    <tbody>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblquery" name="lblquery" runat="server" ClientIDMode="Static"></asp:Label></td>
                                        </tr>
                                    </tbody>
                                </table>

                                <div class="clearfix"></div>

                            </div>
                            <!-- /.box-body -->
                        </div>


                        <div class="text-right pull-right">
                        </div>
                        <!-- /.box -->
                    </div>
                </div>
            </div>
            <!-- /.row -->
        </section>
        <!-- /.content -->
    </div>

    <asp:HiddenField ID="hddnFields" runat="server" Value="" ClientIDMode="Static" />
    <asp:HiddenField ID="subhddnFields" runat="server" Value="" ClientIDMode="Static" />
    <asp:HiddenField ID="hddnreorderField" runat="server" Value="" ClientIDMode="Static" />
    <div class="modal fade" id="modal-dialogsd">
        <div class="modal-dialog">
            <div class="modal-content">
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>
                        <div class="modal-header" style="background: #3c8dbc; color: #fff; padding: 6px 15px;">
                            <button type="button" onclick="modelClose()" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">Save Report</h4>
                        </div>
                        <div class="modal-body">

                            <div class="form-horizontal">
                                <div class="form-group">
                                    <label class="col-sm-3 control-label" for="">Report Name</label>
                                    <div class="col-sm-9">
                                        <input type="text" placeholder="Report Name" id="txtrName" onblur="validatereportName()" class="form-control input-sm" runat="server" />
                                    </div>
                                    <span id="rep_name" class="errorl">Fill Report Name</span>
                                </div>

                                <%--<label id="rep_name" visible="false" style="color:red;">Fill Report Name</label>--%>

                                <div class="form-group has-feedback">
                                    <label class="col-sm-3 control-label" for="">Module</label>
                                    <div class="col-sm-9">
                                        <asp:DropDownList ID="ddlModule" runat="server" CssClass="form-control input-sm"></asp:DropDownList>

                                        <span class="glyphicon glyphicon-menu-down form-control-feedback"></span>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-offset-1 col-sm-4">
                                        <div class="checkbox-inline">
                                            <input type="checkbox" id="chckWebview" runat="server" value="W" />
                                            Web View Report
                                        </div>
                                    </div>
                                    <div class="col-sm-7">
                                        <div class="checkbox-inline">
                                            <input type="checkbox" id="chckSchedule" runat="server" value="S" />
                                            Scheduled <span class="tooltiptext">(Filters won't be applied)</span>
                                        </div>
                                    </div>
                                    <br />
                                    <span id="rep_type" visible="false" class="errorl" style="margin-left: 10%;">Choose Report Type</span>
                                </div>
                                <div id="schedule_rep">
                                    <div class="col-sm-12">
                                        <label class="calendar"><i class="fa fa-calendar"></i>Occurrence</label>
                                    </div>
                                    <div class="form-group m-0">
                                        <div class="col-sm-12">
                                            <div class="box box-primary">
                                                <div class="box-body">
                                                    <div class="col-sm-4">
                                                        <div class="form-group">
                                                            <div class="radio">
                                                                <label>
                                                                    <input type="radio" value="Daily" id="optionDaily" runat="server" />
                                                                    Daily
                                                                </label>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <div class="radio">
                                                                <label>
                                                                    <input type="radio" value="Weekly" id="optionsWeekly" runat="server" />
                                                                    Weekly
                                                                </label>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <div class="radio">
                                                                <label>
                                                                    <input type="radio" value="Monthly" id="optionsMonthly" runat="server" />
                                                                    Monthly
                                                                </label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-8" id="week_scdl">
                                                        <div class="day">
                                                            <div class="input-group">
                                                                <span class="input-group-addon">
                                                                    <input type="checkbox" id="chckSunday" value="Sunday" runat="server" />
                                                                </span>
                                                                <span value="Sunday" class="form-control">Sunday</span>
                                                            </div>
                                                        </div>
                                                        <div class="day">
                                                            <div class="input-group">
                                                                <span class="input-group-addon">
                                                                    <input type="checkbox" value="Monday" id="chckMonday" runat="server" />
                                                                </span>
                                                                <span value="Monday" class="form-control">Monday</span>
                                                            </div>
                                                        </div>
                                                        <div class="day">
                                                            <div class="input-group">
                                                                <span class="input-group-addon">
                                                                    <input id="chckTuesday" type="checkbox" value="Tuesday" runat="server" />
                                                                </span>
                                                                <span value="Tuesday" class="form-control">Tuesday</span>
                                                            </div>
                                                        </div>
                                                        <div class="day">
                                                            <div class="input-group">
                                                                <span class="input-group-addon">
                                                                    <input id="chckWenesday" type="checkbox" value="Wednesday" runat="server" />
                                                                </span>
                                                                <span value="Wednesday" class="form-control">Wednesday</span>
                                                            </div>
                                                        </div>
                                                        <div class="day">
                                                            <div class="input-group">
                                                                <span class="input-group-addon">
                                                                    <input id="chckThursday" type="checkbox" value="Thursday" runat="server" />
                                                                </span>
                                                                <span value="Thursday" class="form-control">Thursday</span>
                                                            </div>
                                                        </div>
                                                        <div class="day">
                                                            <div class="input-group">
                                                                <span class="input-group-addon">
                                                                    <input id="chckFriday" type="checkbox" value="Friday" runat="server" />
                                                                </span>
                                                                <span value="Friday" class="form-control">Friday</span>
                                                            </div>
                                                        </div>
                                                        <div class="day">
                                                            <div class="input-group">
                                                                <span class="input-group-addon">
                                                                    <input id="chckSaturday" type="checkbox" value="Saturday" runat="server" />
                                                                </span>
                                                                <span value="Saturday" class="form-control">Saturday</span>
                                                            </div>
                                                        </div>
                                                        <div class="clearfix m-b-10"></div>
                                                        <span id="wdays" class="errorl" style="margin-left: 0%;">Select Week Days</span>
                                                    </div>

                                                    <div class="col-sm-offset-4 col-sm-12" id="month_scdl">
                                                        <div class="form-group">
                                                            <div class="col-sm-1 radio no-padding">
                                                                <label class="control-label">
                                                                    <input type="radio" value="Day" id="optionsDay" name="Day" runat="server">Day</label>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <div class="input-group">
                                                                    <input type="text" placeholder="10" class="form-control input-sm" runat="server" id="txtDay" />
                                                                </div>
                                                            </div>
                                                            <div class="col-sm-5 control-label" style="vertical-align: middle; text-align: left;">of every month.</div>
                                                        </div>
                                                        <span id="montdays" class="errorl" style="margin-left: 0%;">Give Which Day</span>
                                                        <span id="betdays" class="errorl" style="margin-left: 0%;">Give Day Between 1 - 28</span>
                                                    </div>
                                                </div>
                                                <span id="rep_stype" class="errorl" style="margin-left: 0%;">Choose Report Shedule Type</span>
                                            </div>
                                        </div>

                                    </div>

                                    <div class="bootstrap-timepicker">
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label" for="">Time</label>
                                            <div class="col-sm-4">
                                                <div class="input-group">
                                                    <div style="position: relative;" class="timepicker_position">
                                                        <input class="form-control input-sm" placeholder="HH:MM TT" runat="server" id="txtTime" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <%--<div class="form-group">
                                        <div class="col-sm-offset-1 col-sm-5 pull-left">
                                            <label class="checkbox-inline">
                                                Save Sever Location
                                            </label>
                                        </div>
                                        <div class="col-sm-6 pull-right">
                                            <div class="input-group">
                                                <input type="text" class="form-control input-sm" value="C:\" id="txtLocation" runat="server" />
                                                <div class="input-group-addon">
                                                    <i class="fa fa-folder"></i>
                                                </div>
                                            </div>
                                            <span id="sv_loc" class="errorl" style="margin-left: 0%;">Give Report Saving Location</span>
                                        </div>
                                    </div>--%>
                                    <div class="form-group">
                                        <div class="col-sm-offset-1 col-sm-5 pull-left">
                                            <label class="checkbox-inline">
                                                Send as email
                                            </label>
                                        </div>
                                        <div class="col-sm-6 pull-right">
                                            <textarea class="form-control input-sm" placeholder="Please type email ids separated with comma." id="txtareaEmail" runat="server"></textarea>
                                        </div>
                                        <div class="clearfix"></div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-offset-1 col-sm-5 pull-left">
                                            <label class="checkbox-inline">
                                                Report Format
                                            </label>
                                        </div>
                                        <div class="col-sm-6 pull-right">
                                            <asp:DropDownList runat="server" ID="report_format" class="form-control input-sm">
                                                <asp:ListItem Selected Value="excel">EXCEL</asp:ListItem>
                                                <asp:ListItem Value="pdf">PDF</asp:ListItem>
                                                <asp:ListItem Value="html">HTML</asp:ListItem>
                                            </asp:DropDownList>
                                            <span class="glyphicon glyphicon-menu-down form-control-feedback"></span>
                                        </div>
                                        <div class="clearfix"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" onclick="modelClose()" class="btn btn-default pull-left btn-flat btn-sm" data-dismiss="modal">Close</button>
                            <div class="popup">
                                <span class="popuptext" style="left: -58%; background-color: red;" id="popuprep">Report Name Already Exist..!</span>
                            </div>
                            <asp:Button ID="btnsave" runat="server" Text="Save" OnClientClick="return saveReportFunctionalities()" ClientIDMode="Static" class="btn btn-success btn-flat btn-sm" OnClick="btnsave_Click" />
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
            <!-- /.modal-content -->
        </div>
        <div class="ui-loader-background" id="load">
            <img style="padding-left: 50%; padding-top: 20%;" id="Image1" src="/Images/loading.gif" alt="Processing" />
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->
    <div class="modal fade" id="modal-dialog2">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header" style="background: #3c8dbc; color: #fff; padding: 6px 15px;">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">GroupBy</h4>
                </div>
                <div class="modal-body">
                    <div class="row">

                        <div style="">
                            <span class="col-lg-12 m-b-10">GroupBy</span>
                            <div class="col-lg-6">
                                <div class="form-group has-feedback">
                                    <select class="form-control">
                                        <option>Category.CategoryID</option>
                                        <option></option>
                                    </select>
                                    <span class="glyphicon glyphicon-menu-down form-control-feedback"></span>
                                </div>
                            </div>
                            <div class="col-lg-5">
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox">
                                        Sort By
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div style="margin-left: 20px;">
                            <span class="col-lg-12 m-b-10">Thenby</span>
                            <div class="col-lg-6">
                                <div class="form-group has-feedback">
                                    <select class="form-control">
                                        <option>Category.CategoryName</option>
                                        <option></option>
                                    </select>
                                    <span class="glyphicon glyphicon-menu-down form-control-feedback"></span>
                                </div>
                            </div>
                            <div class="col-lg-5">
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox">
                                        Sort By
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div style="margin-left: 40px;">
                            <span class="col-lg-12 m-b-10">Thenby</span>
                            <div class="col-lg-6">
                                <div class="form-group has-feedback">
                                    <select class="form-control">
                                        <option>Employees.EmployeeID</option>
                                        <option></option>
                                    </select>
                                    <span class="glyphicon glyphicon-menu-down form-control-feedback"></span>
                                </div>
                            </div>
                            <div class="col-lg-5">
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox">
                                        Sort By
                                    </label>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-success btn-flat btn-pink btn-sm" data-dismiss="modal">Save</button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="modal-dialog3">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header" style="background: #3c8dbc; color: #fff; padding: 6px 15px;">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">Computing Fields</h4>
                </div>
                <div>
                    <div id="comp_field" class="pull-left">
                    </div>
                    <div class="pull-right">
                        <div class="col-lg-1">
                            <div class="form-group has-feedback">
                                <button type="button" id="add_comp" class="btn btn-success btn-flat btn-sm"><i class="fa fa-plus-square"></i></button>
                            </div>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-success btn-flat btn-pink btn-sm" data-dismiss="modal">Save</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="modal-dialog4">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header" style="background: #3c8dbc; color: #fff; padding: 6px 15px;">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">Sort Order</h4>
                </div>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-lg-12">
                                    <table class="table table-condensed pull-left" id="sorder_feilds">
                                        <thead>
                                            <tr>
                                                <th>Fields</th>
                                                <th>Order By</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                            </tr>
                                        </tbody>
                                    </table>

                                    <div class="col-lg-1 pull-right tooltip2">
                                        <div class="form-group has-feedback">
                                            <button type="button" id="add_sorder" onclick="return addsrfield(0);" class="btn btn-success btn-flat btn-sm"><i class="fa fa-plus-square"></i></button>
                                            <span class="tooltiptext2">Add Sort Order</span>
                                        </div>
                                    </div>
                                    <asp:HiddenField ID="hfSelectedValue" runat="server" Value="" ClientIDMode="Static" />
                                    <asp:HiddenField ID="computing_query" runat="server" Value="" ClientIDMode="Static" />

                                    <div class="clearfix"></div>
                                    <asp:TextBox runat="server" ID="hf" ClientIDMode="Static" Visible="false"></asp:TextBox>
                                    <div class="modal-footer">
                                        <%--OnClick="btnsortorder_Click" OnClientClick="GetValue()" --%>
                                        <div class="pull-left popup">
                                            <span class="popuptext" id="ssaved">Successfully Saved..!</span>
                                            <span class="popuptext" id="sfallf" style="background-color: red;">Choose a valid sort operation..!</span>
                                        </div>
                                        <asp:Button ID="btnsortorder" ClientIDMode="Static" runat="server" Text="Save" class="btn btn-success btn-flat btn-pink btn-sm pull-right" />
                                        <div class="clearfix"></div>
                                        <asp:HiddenField ID="Hlblquery" runat="server" ClientIDMode="Static" Value="" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>


    <script type="text/javascript">
        var primary;

        $(document).ready(function () {


            primary = "1";
            var prePopUp = [];

            $("#rep_name").hide();
            $("#rep_type").hide();
            $("#rep_stype").hide();
            //$("#sv_loc").hide();
            $("#wdays").hide();
            $("#betdays").hide();
            $("#montdays").hide();
            $("#mjValidation").show();

            $("#successQuery").hide();
            $('#<%= ddlDataType.ClientID %>').prop("disabled", true);

            $('#<%= txtTime.ClientID %>').ptTimeSelect({
                popupImage: '<img src="../icons/time.png" />',
                popupImageOnly: true,
                zIndex: 6000
            });

            $(".timepicker_position a").css("position:", "relative");
            $(".timepicker_position a").css("right:", "5px");
            $(".timepicker_position a").css("top:", "5px");



            $("#btnreorderSave").click(function () {

                var user = {};
                user.LabelColumn = $('#lbl_colname').text();
                user.isDisplay = $('#tisDisplay').is(":checked");
                user.IsFilter = $('#tisFilter').is(":checked");
                user.DisplayName = $("[id*=tdisplayName]").val().trim();
                user.Aggregation = $('#<%= ddlagregation.ClientID %>').val();
                user.SortBy = $('#<%= ddlsortOrder.ClientID %>').val();
                user.parameterType = $('#<%= ddlDataType.ClientID %>').val();

                if (user.IsFilter == true || user.Aggregation != "None") {
                    if (user.DisplayName == null || user.DisplayName == "" || user.parameterType == "None") {
                        var popupf = document.getElementById('fillmust');
                        var popp = document.getElementById('nonone');

                        if (user.parameterType == "None") {
                            popp.classList.toggle('show');
                            setTimeout(function () {
                                popp.classList.toggle('show')
                            }, 3000);
                        }
                        else {
                            popupf.classList.toggle('show');
                            setTimeout(function () {
                                popupf.classList.toggle('show')
                            }, 3000);
                            $("#tdisplayName").css("border-color", "red");
                        }

                        return false;
                    }
                }

                primary = "1";
                $.ajax({
                    type: "POST",
                    url: "Query_Builder.aspx/SaveUser",
                    data: '{user: ' + JSON.stringify(user) + '}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        $("#tdisplayName").css("border-color", "white");
                        var popup = document.getElementById('saved');
                        popup.classList.toggle('show');
                        setTimeout(function () {
                            popup.classList.toggle('show')
                        }, 3000);
                        //$("#btnreorderSave").hide();
                        isdis = true;
                        isfilter = false;
                        disName = "";
                        aggre = "None";
                        sortBy = "None";
                        parameterType = "None";
                        $('#tisDisplay').prop("checked", true);
                        $('#tisFilter').prop("checked", false);
                        $("[id*=tdisplayName]").val("");
                        $('#<%= ddlagregation.ClientID %>').val("None");
                        $('#<%= ddlsortOrder.ClientID %>').val("None");
                        $('#<%= ddlDataType.ClientID %>').val("None");
                        closeTab(true);
                        //$('#ddlmlookuptable').empty();
                        //$('#ddlmlookupfields').val("Please Select");
                        //$("#lookuptable tbody tr").remove();
                        //$('#ddlmLookup').val("Please Choose");
                        //$('#lbllookupquery').empty();

                        closeTabMaster(true);

                    }
                });
                return false;
            });

            $("#btnClearFields").click(function () {

                $.ajax({
                    type: "POST",
                    url: "Query_Builder.aspx/btnClearFields_Click",
                    data: '{}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        $("#tdisplayName").css("border-color", "white");
                        var popup = document.getElementById('cleared');
                        popup.classList.toggle('show');
                        setTimeout(function () {
                            popup.classList.toggle('show')
                        }, 3000);

                        $.each($("input[type='checkbox']"), function () {
                            $(this).parent('p').css({
                                color: '#dddddd'
                            });

                        });

                        $('.selectedField li').remove();
                        $('#HddnselectedField').val("");
                        //$("#Hlblquery").val("");
                        $('#lblquery').text("");
                        $('#mjquery').val("");
                        $("#svreport").hide();
                        $("#btnGenerate").hide();
                        $("#btngeneratereport").hide();
                        $("#table-report #form_group_widget").hide();
                        $("#table_feilds tbody tr").remove();
                        //$("#btnreorderSave").hide();
                        $("#btnClearFields").hide();
                        $("#btnvalidate").hide();
                        //  $("#add_mjoin").hide();
                        $("#mjValidation").show();
                        $("#master_tables").val("");
                        master = [];
                        $("#clearJoining").hide();
                        $("#saveJoining").hide();
                        $('#form_group_widget2').hide();
                        primary = "1";
                        modelClose();
                    }
                });
                return false;
            });

            //  CommonFunction();
            $("#clearJoining").click(function () {
                $.ajax({
                    type: "POST",
                    url: "Query_Builder.aspx/ClearManualJoin",
                    data: '{}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        var popup = document.getElementById('cleared');
                        popup.classList.toggle('show');
                        setTimeout(function () {
                            popup.classList.toggle('show')
                        }, 3000);
                        $('#mjquery').val("");
                        $("#table_feilds tbody tr").remove();
                        $("#saveJoining").hide();
                        $("#clearJoining").hide();
                    }
                });
                return false;
            });

            var favorite = [];
            $("#btnSelect").click(function () {
                CommonFunction();
                $('#sorder_feilds tbody tr').remove();
                $('#table_feilds tbody tr').remove();
                primary = "1";
                // addmjoin();
                //alert("clicked....");
            });

            var master = [];
            function CommonFunction() {

                var selectedFields = "";
                var oTable = $('#example10').dataTable();
                oTable.fnPageChange('first');
                var rowcollection = oTable.$("input[type='checkbox']:checked", { "page": "all" });
                //if ($.inArray('vikash', selectedFields) >= 0) {

                //$.each($("#example10 input[type='checkbox']:checked"), function ()
                rowcollection.each(function (index, elem) {
                    var hl = $(elem).parents('ul').attr("id");
                    master.push($(elem).parents('ul').attr("id"));
                    //   alert(hl);
                    var val = $(elem).val();
                    var concat = hl + '.' + val;
                    if (val != 'on' && val != 'W' && val != 'S') {
                        $(elem).parent('p').css({
                            color: '#FF0000'
                        });
                        selectedFields += concat + ",";
                        var li_id = "" + hl;
                        //alert(li_id);
                        //'<button type="button" onclick="" class="close" aria-label="Close"><span aria-hidden="true">&times;</span></button>' +
                        $('<li class="input-group m-b-5" id="' + li_id + '" role="menuitem" style="height:15%;">' +
                            '<span class="input-group-addon">' +
                            '<img src="/Images/close.png" width="15px" height="15px" onclick="return delColumn(&#39;' + li_id + '&#39;,this) "/>' +
                            '</span>' +
                            '<span  style="width:100%;" class="input-group-addon" id="rspan_' + concat + '" onclick="return showColumnWidget(&#39;' + li_id + '&#39;,this)">' +
                               '<input type="radio" class="pull-left" name="colmuns" id="radio_' + concat + '"/>' +
                               '<span style="padding-left:5px;width:90%;text-align: left;" class="pull-left" id="colname_' + concat + '" >' + concat + '</span>' +
                            '</span>' +
                            '<span class="form-control-feedback font-white" id="right_arrow" style="height:100%;"></span>' +
                            '</li>', { html: concat }).appendTo('ul.selectedField');
                        reorder_fields();
                        $(elem).removeAttr("checked");
                        $("#btnClearFields").show();
                        $("#btnvalidate").show();
                        $("#svreport").hide();
                        $("#btnGenerate").hide();
                        $("[id^=colname_]").removeClass("form-control");
                    }

                    addsrfield();
                    $('#HddnselectedField').val(selectedFields);
                    //aaf" data-toggle="modal"
                    $(".aaf").attr("data-toggle", "modal");

                });
                $(".selectedField").sortable();
                master = jQuery.unique(master);
                //alert(master);
                $("#master_tables").val(master);

                //  };
            }

            var num = 0;
            var num2 = 0;

            addRow();
            function addRow() {
                //alert("addrow");
                num2 = num2 + 1;
                var text1 = "compop_1_" + num2;
                var text2 = "compop_2_" + num2;

                var html = '<div class="modal-body"><div class="row"><div class="col-lg-3"><div class="form-group has-feedback">' +
                            '<select class="form-control" id=' + text1 + ' >' +
                            '</select>' +
                            '<span class="glyphicon glyphicon-menu-down form-control-feedback"></span>' +
                        '</div>' +
                    '</div>' +
                    '<div class="col-lg-2">' +
                        '<div class="form-group has-feedback">' +
                            '<select class="form-control">' +
                                '<option>+</option>' +
                                '<option>x</option>' +
                            '</select>' +
                            '<span class="glyphicon glyphicon-menu-down form-control-feedback"></span>' +
                        '</div>' +
                    '</div>' +
                    '<div class="col-lg-3">' +
                        '<div class="form-group has-feedback">' +
                            '<select class="form-control" id=' + text2 + ' >' +
                            '</select>' +
                            '<span class="glyphicon glyphicon-menu-down form-control-feedback"></span>' +
                        '</div>' +
                    '</div>' +
                    '<div class="col-lg-3">' +
                        '<div class="form-group">' +
                            '<input type="text" class="form-control" placeholder="As Name">' +
                        '</div>' +
                    '</div>' +
                '</div>';

                $(html).appendTo($('#comp_field'));

                var compops1 = $("#" + text1);
                var compops2 = $("#" + text2);


            }

            $("#add_comp").click(addRow);

            //$("modal-dialog5_href").click(function () {
            //    alert("clicked..");
            //})







            addsrfield(0);
            function addsrfield(allow) {
                //alert("allow"+allow);
                if (allow == 0)
                    num = num + 1;
                //alert("num" + num);
                var text = "ddlsort1_" + num;
                var text1 = "ddlsort_1_" + num;
                if (!isNaN(num)) {
                    //   alert(num);
                    htmlp = '<tr>' +
                                           '<td>' +
                                               '<div class="form-group has-feedback">' +
                                                   '<Select id=' + text + ' class="form-control"></Select>' +
                                                   '<span class="glyphicon glyphicon-menu-down form-control-feedback"></span>' +
                                               '</div>' +
                                           '</td>' +
                                           '<td>' +
                                               '<div class="form-group has-feedback">' +
                                                   '<Select id=' + text1 + ' class="form-control">' +
                                                    '<option value="0">Select Order</option>' +
                                                    '<option value=", as ASC">ASC</option>' +
                                                    '<option value=", as DESC">DESC</option>' +
                                                   '</Select>' +

                                                   '<span class="glyphicon glyphicon-menu-down form-control-feedback"></span>' +
                                               '</div>' +
                                           '</td>' +
                                       '</tr>'; console.log('onload :' + htmlp);
                    $("#sorder_feilds tbody").append(htmlp);

                    var ddlsort = $("#" + text);

                    ddlsort.empty().append('<option selected="selected" value="0">Please select</option>');

                    $('#input_group_widget [id^=colname_]').each(function () {
                        ddlsort.append($("<option></option>").val($(this).html()).html($(this).html()));
                    });

                }
            }

            $("#add_sorder").bind("click", function () {
                addsrfield(0);
            });

            //function GetValue() {
            //    $('[id*=hfSelectedValue]').val($('[id*=text]').val());
            //}

            var prm = Sys.WebForms.PageRequestManager.getInstance();
            if (prm != null) {
                prm.add_endRequest(function (sender, e) {
                    if (sender._postBackSettings.panelsToUpdate != null) {

                        SaveReport();
                        $("#load").hide();
                        var popup = document.getElementById('rsaved');
                        popup.classList.toggle('show');
                        $('#modal-dialogsd').modal('toggle');
                        setTimeout(function () {
                            popup.classList.toggle('show')
                        }, 3000);
                    }
                });
            };

            //----Save Report --  
            SaveReport();
            function SaveReport() {
                $('#active_tabs').val("li_tbl_report");

                $("#rep_name").hide();
                $("#schedule_rep").hide();
                $("#rep_type").hide();
                $("#rep_stype").hide();
                $("#wdays").hide();
                $("#montdays").hide();
                $("#betdays").hide();
                //$("#sv_loc").hide();

                $('#<%= chckSchedule.ClientID %>').click(function () {
                    var checked_check = $('#<%= chckSchedule.ClientID %>').is(":checked");

                    if (checked_check) {
                        $("#schedule_rep").show();
                        $('#<%= chckWebview.ClientID %>').prop("checked", false);
                    }
                    else {
                        $("#schedule_rep").hide();
                    }
                });

                $('#<%= chckWebview.ClientID %>').click(function () {
                    var checked_check = $('#<%= chckWebview.ClientID %>').is(":checked");

                    if (checked_check) {
                        $("#schedule_rep").hide();
                        $('#<%= chckSchedule.ClientID %>').prop("checked", false);
                    }

                });

                //---Schedule  -----

                $('#week_scdl').hide();
                $('#month_scdl').hide();

                $("#<%= optionDaily.ClientID %>").click(function () {
                    var daily = $("#<%= optionDaily.ClientID %>").is(":checked");

                    if (daily) {
                        $('#week_scdl').hide();
                        $('#month_scdl').hide();
                    }
                });

                $("#<%= optionsWeekly.ClientID %>").click(function () {
                    var weekly = $("#<%= optionsWeekly.ClientID %>").is(":checked");

                    if (weekly) {
                        $('#week_scdl').show();
                        $('#month_scdl').hide();
                    }
                });

                $("#<%= optionsMonthly.ClientID %>").click(function () {
                    var monthly = $("#<%= optionsMonthly.ClientID %>").is(":checked");

                    if (monthly) {
                        $('#week_scdl').hide();
                        $('#month_scdl').show();
                    }
                });
            }

            //Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
            //function EndRequestHandler(sender, args) {
            //    if (args.get_error() != undefined) {
            //        args.set_errorHandled(true);
            //        SaveReport();
            //    }
            //}

        });

        function clearBVal() {
            $.ajax({
                type: "POST",
                url: "Query_Builder.aspx/ClearManualJoin",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    //alert("success");
                    $('#mjquery').val("");
                    $("#table_feilds tbody tr").remove();

                    //$("#saveJoining").hide();
                    //$("#clearJoining").hide();
                },

            });
        }
        //$("#btnvalidate").click(function

        function clearBVal() {
            $.ajax({
                type: "POST",
                url: "Query_Builder.aspx/ClearManualJoin",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    //alert("success");
                    $('#mjquery').val("");
                    $("#table_feilds tbody tr").remove();
                },

            });
        }
        function validate(cond) {
            var cond1;
            console.log(isdis + " = " + $('#tisDisplay').is(":checked"));
            console.log(isfilter + " = " + $('#tisFilter').is(":checked"));
            console.log(disName + " = " + $("[id*=tdisplayName]").val());
            console.log(aggre + " = " + $('#<%= ddlagregation.ClientID %>').val());
            console.log(sortBy + " = " + $('#<%= ddlsortOrder.ClientID %>').val());
            console.log(parameterType + " = " + $('#<%= ddlDataType.ClientID %>').val());
            if (cond)
                clearBVal();
            if (isdis != $('#tisDisplay').is(":checked") || isfilter != $('#tisFilter').is(":checked") || disName != $("[id*=tdisplayName]").val() || aggre != $('#<%= ddlagregation.ClientID %>').val() || sortBy != $('#<%= ddlsortOrder.ClientID %>').val() || parameterType != $('#<%= ddlDataType.ClientID %>').val())
                cond1 = confirm('Are you sure move from this without saving ?');
            else
                cond1 = true;

            if (cond1) {
                $("#table-report #input_group_widget input:radio").attr("checked", false);
                primary = "1";
                //$("#btnreorderSave").hide();
                $("#table-report #form_group_widget").hide();
                $('#form_group_widget2').hide();
                $("#table-report [id^=right_arrow]").removeClass("glyphicon glyphicon-menu-right");
                $("#tdisplayName").css("border-color", "white");
                setTimeout("bind()", 500);
            }
            else {
                return false;
            }
        }
        var flg = 0;
        function bind() {

            $("#load1").show();
            var tReportItems = new Array();
            var sReportItems = new Array();
            var hfields = {};

            $('#table-report #input_group_widget [id^=colname_]').each(function () {
                var tItems = $(this).html();
                tReportItems.push(tItems);
            });


            if ($('#hfSelectedValue').val() != null && $('#hfSelectedValue').val() != "")
                var sfields = $('#hfSelectedValue').val();
            else
                var sfields = "-1";

            if ($('#mjquery').val() != null && $('#mjquery').val() != "")
                var mjquery = $('#mjquery').val();
            else
                var mjquery = "-1";

            //$('#sub-report #input_group_widget [id^=colname]').each(function () {
            //    var sReports = $(this).html();
            //    sReportItems.push(sReports);
            //});


            console.log($('#hfSelectedValue').val());
            //   alert(prePopUp[0]);

            $.ajax({
                type: "POST",
                url: "Query_Builder.aspx/btnvalidate_Click",
                data: '{fields: ' + JSON.stringify(tReportItems) + ',sfields: ' + JSON.stringify(sfields) + ',mjquery: ' + JSON.stringify(mjquery) + ',mjoins: ' + JSON.stringify(mjoins) + '}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {

                    $("#load1").hide();
                    console.log(response);
                    var popups = document.getElementById('vsuccess');
                    var popupe = document.getElementById('verror');
                    var popej = document.getElementById('jerror');
                    var popvs = document.getElementById('vserror');
                    var popie = document.getElementById('popie');
                    if (response.d.condition == "yes" || response.d.condition != "") {
                        if (response.d.condition == "yes") {
                            popups.classList.toggle('show');
                            setTimeout(function () {

                                popups.classList.toggle('show')
                            }, 3000);
                        }
                        if (response.d.condition != "yes" && response.d.condition != "") {
                            //var text = response.d.condition;
                            //var ss = '<p style="color:red;">' + text + '</p>';
                            //$("#popie").html("Sucessfully Saved ....." + ss);

                            $("#popie").text(response.d.condition + " no Referential Integrity");
                            popie.classList.toggle('show');
                            setTimeout(function () {

                                popie.classList.toggle('show')
                            }, 3000);
                        }
                        //alert("hi");
                        $("#lblquery").text(response.d.query);
                        //$("#successQuery").show();
                        $("#svreport").show();
                        $("#btnGenerate").show();
                        $("#btngeneratereport").show();
                        if (response.d.ReturnJoin != null) {
                            if (response.d.ReturnJoin)
                                //$('#table_feilds tbody tr').remove();

                                var item = response.d.ReturnJoin.split(',');
                            prePopUp = item;

                            prePopUp = $.grep(prePopUp, function (n) {
                                return (n);
                            });
                            $.each(prePopUp, function (index, value) {
                                var tbl = value.split('=');

                                var ftable = tbl[0];
                                var stable = tbl[1];


                                var ltable = ftable.split('.');
                                var lval = ltable[0].trim();
                                var lclm = ltable[1].trim();
                                var rtable = stable.split('.');
                                var rval = rtable[0].trim();
                                var rclm = rtable[1].trim();
                                //alert(lval);
                                //  alert(rval);

                                // loadFieldready(lval);
                                num = num + 1;
                                var tfields = "tfields_" + num;
                                var tfields1 = "tfields1_" + num;
                                var tname = "tname_" + num;
                                var tname1 = "tname1_" + num;
                                var join = "join_" + num;
                                var del_id = num;
                                var row_id = "row_" + num;
                                var farray = [];
                                var fields = $('#HddnselectedField').val();

                                if ($('#HddnselectedField').val()) {
                                    farray = fields.split(',');
                                }

                                var htmlt = '<tr id=' + row_id + '>' +
                                            '<td>' +
                                            '<div class="form-group has-feedback">' +
                                                '<Select id=' + tname + ' class="form-control" onchange="return loadFields((this).id)"></Select>' +
                                                '<span class="glyphicon glyphicon-menu-down form-control-feedback"></span>' +
                                            '</div>' +
                                            '</td>' +
                                            '<td>' +
                                            '<div class="form-group has-feedback">' +
                                                '<Select id=' + tfields + ' class="form-control"></Select>' +
                                                '<span class="glyphicon glyphicon-menu-down form-control-feedback"></span>' +
                                            '</div>' +
                                            '</td>' +
                                            '<td>' +
                                               '<div class="form-group has-feedback">' +
                                                   '<Select id=' + join + ' class="form-control">' +
                                                      '<option value="LEFT JOIN">Left Join</option>' +
                                                      '<option value="RIGHT JOIN">Right Join</option>' +
                                                      '<option value="INNER JOIN">Inner Join</option>' +
                                                      '<option value="OUTER JOIN">Outer Join</option>' +
                                                    '</Select>' +
                                                   '<span class="glyphicon glyphicon-menu-down form-control-feedback"></span>' +
                                                '</div>' +
                                            '</td>' +
                                            '<td>' +
                                            '<div class="form-group has-feedback">' +
                                                '<Select id=' + tname1 + ' class="form-control" onchange="return loadFields1((this).id)"></Select>' +
                                                '<span class="glyphicon glyphicon-menu-down form-control-feedback"></span>' +
                                            '</div>' +
                                            '</td>' +
                                            '<td>' +
                                            '<div class="form-group has-feedback">' +
                                                '<Select id=' + tfields1 + ' class="form-control"></Select>' +
                                                '<span class="glyphicon glyphicon-menu-down form-control-feedback"></span>' +
                                            '</div>' +
                                            '</td>' +
                                            '<td>' +
                                            '<div class="form-group has-feedback tooltip2">' +
                                              '<button type="button" id=' + del_id + ' class="btn btn-error btn-flat btn-sm" onclick="return delRow((this).id)" ><i class="fa fa-minus-circle"></i></button>' +
                                              '<span class="tooltiptext2">Remove Joining</span>' +
                                             '</div>' +
                                            '</td>' +
                                            '</tr>';

                                var mtables = [];
                                mtables = $("#master_tables").val().split(',');
                                mtables = $.grep(mtables, function (n) {
                                    return (n);
                                });

                                if (farray.length != 0 && mtables.length > 1) {
                                    $("#table_feilds tbody").append(htmlt);
                                    $("#mjValidation").hide();
                                    var tbl1 = $("#" + tname);
                                    var tbl2 = $("#" + tname1);
                                    var clmn1 = $("#" + tfields);
                                    var clmn2 = $("#" + tfields1);
                                    console.log("tables" + mtables);

                                    if (mtables != "") {

                                        //  alert(rval);
                                        tbl1.append($("<option value=0>Select Table</option>"));
                                        tbl2.append($("<option value=0>Select Table</option>"));

                                        $.each(mtables, function (index, value) {
                                            if (value != null && value != "") {
                                                console.log(value);
                                                tbl1.append($("<option value=" + value + ">" + value + "</option>"));
                                                tbl2.append($("<option value=" + value + ">" + value + "</option>"));
                                            }
                                        });
                                        // alert(rval);
                                        tbl1.val(lval);
                                        tbl2.val(rval);
                                        //var lastChar = htmlt.substr(htmlt.length - 1);
                                        $.ajax({
                                            type: "POST",
                                            url: "Query_Builder.aspx/getFields",
                                            data: '{table: ' + JSON.stringify(lval) + '}',
                                            contentType: "application/json; charset=utf-8",
                                            dataType: "json",
                                            success: function (response) {
                                                // $("#tfields_" + lastChar).empty();
                                                var datad = response.d.replace(/\s+/g, "");
                                                //console.log("aaa"+datad);
                                                var sd = JSON.parse(datad);
                                                console.log("before console");
                                                console.log(sd);
                                                // $("#tfields_" + lastChar).append($("<option value=0>Select Field</option>"));
                                                clmn1.append($("<option value=0>Select Field</option>"));
                                                // clmn2.append($("<option value=0>Select Field</option>"));
                                                $.each(sd, function (index, value) {
                                                    //alert(value.All_Columns);
                                                    if (value != null && value != "") {
                                                        //alert(value);
                                                        //clmn1.append($("<option value=" + value + ">" + value + "</option>"));
                                                        //clmn2.append($("<option value=" + value + ">" + value + "</option>"));
                                                        clmn1.append($("<option value=" + value.ALL_COLUMNS + ">" + value.ALL_COLUMNS + "</option>"));
                                                        //  clmn2.append($("<option value=" + value.All_Columns + ">" + value.All_Columns + "</option>"));

                                                        //   $("#tfields_" + lastChar).append($("<option value=" + value.All_Columns + ">" + value.All_Columns + "</option>"));
                                                    }

                                                });

                                                clmn1.val(lclm);
                                                //clmn2.val(rclm);
                                                //alert(rclm);
                                            }
                                        });
                                        $.ajax({
                                            type: "POST",
                                            url: "Query_Builder.aspx/getFields",
                                            data: '{table: ' + JSON.stringify(rval) + '}',
                                            contentType: "application/json; charset=utf-8",
                                            dataType: "json",
                                            success: function (response) {
                                                // $("#tfields_" + lastChar).empty();
                                                var datad = response.d.replace(/\s+/g, "");
                                                //console.log("aaa"+datad);
                                                var sd = JSON.parse(datad);
                                                console.log("before console");
                                                console.log(sd);
                                                // $("#tfields_" + lastChar).append($("<option value=0>Select Field</option>"));
                                                // clmn1.append($("<option value=0>Select Field</option>"));
                                                clmn2.append($("<option value=0>Select Field</option>"));

                                                $.each(sd, function (index, value) {
                                                    //alert(value.All_Columns);
                                                    if (value != null && value != "") {
                                                        //alert(value);
                                                        //clmn1.append($("<option value=" + value + ">" + value + "</option>"));
                                                        //clmn2.append($("<option value=" + value + ">" + value + "</option>"));
                                                        // clmn1.append($("<option value=" + value.All_Columns + ">" + value.All_Columns + "</option>"));
                                                        clmn2.append($("<option value=" + value.ALL_COLUMNS + ">" + value.ALL_COLUMNS + "</option>"));

                                                        //   $("#tfields_" + lastChar).append($("<option value=" + value.All_Columns + ">" + value.All_Columns + "</option>"));
                                                    }

                                                });

                                                // clmn1.val(lclm);
                                                clmn2.val(rclm);
                                                // alert(rclm);
                                            }
                                        });
                                    }

                                    // $("#add_mjoin").show();
                                }

                                var tblCount = $("#table_feilds tbody tr").length;
                                if (tblCount > 0) {
                                    $("#saveJoining").show();
                                    $("#clearJoining").show();
                                }
                                else {
                                    $("#saveJoining").hide();
                                    $("#clearJoining").hide();
                                }
                            });

                            //   setTimeout("addmjoin()", 900);

                        }
                    }
                    else if (response.d.condition == "no") {
                        $("#load1").hide();
                        if (flg == 1) {
                            flg = 0;
                            popej.classList.toggle('show');
                            setTimeout(function () {
                                popej.classList.toggle('show')
                            }, 3000);
                            $("#lblquery").text(response.d.query);
                        }
                        else if (flg == 0) {
                            flg = 0;
                            var mtables = [];
                            mtables = $("#master_tables").val().split(',');
                            mtables = $.grep(mtables, function (n) {
                                return (n);
                            });

                            if (mtables.length == 1) {
                                popvs.classList.toggle('show');
                                setTimeout(function () {
                                    popvs.classList.toggle('show')
                                }, 3000);

                            }
                            else {
                                popupe.classList.toggle('show');
                                setTimeout(function () {
                                    popupe.classList.toggle('show')
                                }, 3000);

                            }
                            $("#lblquery").text(response.d.query);
                        }
                    }

                }
            });
            return false;
        }
        var mjoins = [];
        $("#saveJoining").click(function () {

            var mquery = "";
            var popups = document.getElementById('mjsaved');
            var popupe = document.getElementById('mjerror');

            if ($("[id^=tname_]").val() != 0) {
                var ftable = $("[id^=tname_]").val();
                mquery = " FROM " + ftable + " ";
            }
            else
                mquery = "";

            mjoins = [];
            $("[id^=row_]").each(function () {
                var lc = (this).id.substr((this).id.length - 1);

                var ftName = $("#tname_" + lc).val();
                var ffName = $("#tfields_" + lc).val();
                var joint = $("#join_" + lc).val();
                var stName = $("#tname1_" + lc).val();
                var sfName = $("#tfields1_" + lc).val();

                if (ftName != 0 && ffName != 0 && ftName != null && ffName != null && joint != 0 && stName != 0 && sfName != 0 && stName != null && sfName != null) {

                    var joinTable = ftName + "." + ffName + ":" + joint + ":" + stName + "." + sfName;
                    mjoins.push(joinTable);

                    var jquer = joint + " " + stName + " ON " + ftName + "." + ffName + "=" + stName + "." + sfName;
                    mquery += jquer + " ";
                    $("#mjquery").val(mquery);

                }
                else {
                    //alert("sdsdsdsd");
                    popupe.classList.toggle('show');
                    setTimeout(function () {
                        popupe.classList.toggle('show');
                    }, 3000);
                    mquery = "";
                }
            });
            if (mquery != "") {
                flg = 1;
                validate();
            }
        });

        function reloadTables() {
            var master1 = [];
            $("#master_tables").val("");
            $(".selectedField li").each(function () {
                if (master1.indexOf($(this).attr("id")) == -1)
                    master1.push($(this).attr("id"));
            });
            $("#master_tables").val(master1);
        }
        function delColumn(id, obj) {
            var farray = [];
            var mstble = [];
            var hmsfields = "";

            if (isdis != $('#tisDisplay').is(":checked") || isfilter != $('#tisFilter').is(":checked") || disName != $("[id*=tdisplayName]").val() || aggre != $('#<%= ddlagregation.ClientID %>').val() || sortBy != $('#<%= ddlsortOrder.ClientID %>').val() || parameterType != $('#<%= ddlDataType.ClientID %>').val())
                cond = confirm('Are you sure move from this without saving ?');
            if (cond) {
                $("#tdisplayName").css("border-color", "white");
                $("#table-report #input_group_widget input:radio").attr("checked", false);
                $("#table-report [id^=right_arrow]").removeClass("glyphicon glyphicon-menu-right");
                primary = "1";
                //$("#btnreorderSave").hide();
                $("#mjquery").val("");
                $(obj).closest("li").hide().remove();
                $("#master_tables").val("");
                $('.selectedField li').each(function () {
                    mstble.push((this).id);
                    hmsfields += $(this).children('span').text() + ",";
                });
                $('#HddnselectedField').val(hmsfields);
                var master = jQuery.unique(mstble);
                console.log(master);
                $("#master_tables").val(master);
                $("#table_feilds tbody tr").remove();
                // $("#add_mjoin").hide();
                $("#mjValidation").show();

                var tfields1 = $('#HddnselectedField').val();
                $("#table-report #form_group_widget").hide();
                $('#form_group_widget2').hide();
                var fieldsName = $(obj).closest("li").children('span').text();
                var oTable = $('#example10').dataTable();
                var rowcollection = oTable.$("input[type='checkbox']", { "page": "all" });

                $.ajax({
                    type: "POST",
                    url: "Query_Builder.aspx/DeleteField",
                    data: '{fieldName: ' + JSON.stringify(fieldsName) + '}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                    }
                });

                if (tfields1.indexOf(fieldsName) !== -1) {
                }
                else {
                    rowcollection.each(function (index, elem) {
                        var hl = $(elem).parents('ul').attr("id");
                        var val = $(elem).val();
                        var concat = hl + '.' + val;
                        if (fieldsName == concat) {
                            //alert("yes matched = " + concat);
                            $(elem).parent('p').css({
                                color: '#dddddd'
                            });
                        }
                    });
                }

                isdis = true;
                isfilter = false;
                disName = "";
                aggre = "None";
                sortBy = "None";
                parameterType = "None";
                $('#tisDisplay').prop("checked", true);
                $('#tisFilter').prop("checked", false);
                $("[id*=tdisplayName]").val("");
                $('#<%= ddlagregation.ClientID %>').val("None");
                $('#<%= ddlsortOrder.ClientID %>').val("None");
                $('#<%= ddlDataType.ClientID %>').val("None");
                addmjoin(false);
            }

        }
        var num = 0;
        function addmjoin(joinCond) {
            reloadTables();
            // alert("hi");
            //alert("entered...");
            num = num + 1;
            var tfields = "tfields_" + num;
            var tfields1 = "tfields1_" + num;
            var tname = "tname_" + num;
            var tname1 = "tname1_" + num;
            var join = "join_" + num;
            var del_id = num;
            var row_id = "row_" + num;
            var farray = [];
            var fields = $('#HddnselectedField').val();

            if ($('#HddnselectedField').val()) {
                farray = fields.split(',');
            }



            var htmlt = '<tr id=' + row_id + '>' +
                        '<td>' +
                        '<div class="form-group has-feedback">' +
                            '<Select id=' + tname + ' class="form-control" onchange="return loadFields((this).id)"></Select>' +
                            '<span class="glyphicon glyphicon-menu-down form-control-feedback"></span>' +
                        '</div>' +
                        '</td>' +
                        '<td>' +
                        '<div class="form-group has-feedback">' +
                            '<Select id=' + tfields + ' class="form-control"></Select>' +
                            '<span class="glyphicon glyphicon-menu-down form-control-feedback"></span>' +
                        '</div>' +
                        '</td>' +
                        '<td>' +
                           '<div class="form-group has-feedback">' +
                               '<Select id=' + join + ' class="form-control">' +
                                  '<option value="LEFT JOIN">Left Join</option>' +
                                  '<option value="RIGHT JOIN">Right Join</option>' +
                                  '<option value="INNER JOIN">Inner Join</option>' +
                                  '<option value="OUTER JOIN">Outer Join</option>' +
                                '</Select>' +
                               '<span class="glyphicon glyphicon-menu-down form-control-feedback"></span>' +
                            '</div>' +
                        '</td>' +
                        '<td>' +
                        '<div class="form-group has-feedback">' +
                            '<Select id=' + tname1 + ' class="form-control" onchange="return loadFields1((this).id)"></Select>' +
                            '<span class="glyphicon glyphicon-menu-down form-control-feedback"></span>' +
                        '</div>' +
                        '</td>' +
                        '<td>' +
                        '<div class="form-group has-feedback">' +
                            '<Select id=' + tfields1 + ' class="form-control"></Select>' +
                            '<span class="glyphicon glyphicon-menu-down form-control-feedback"></span>' +
                        '</div>' +
                        '</td>' +
                        '<td>' +
                        '<div class="form-group has-feedback tooltip2">' +
                          '<button type="button" id=' + del_id + ' class="btn btn-error btn-flat btn-sm" onclick="return delRow((this).id)" ><i class="fa fa-minus-circle"></i></button>' +
                          '<span class="tooltiptext2">Remove Joining</span>' +
                         '</div>' +
                        '</td>' +
                        '</tr>';

            var mtables = [];
            mtables = $("#master_tables").val().split(',');
            mtables = $.grep(mtables, function (n) {
                return (n);
            });
            // alert(mtables);
            if (mtables.length == 0) {
                $("#svreport").hide();
                $("#btnGenerate").hide();
                $("#btngeneratereport").hide();
                //$("#btnreorderSave").hide();
                $("#btnClearFields").hide();
                $("#btnvalidate").hide();
            }

            if (joinCond) {
                if (farray.length != 0 && mtables.length > 1) {
                    $("#table_feilds tbody").append(htmlt);
                    $("#mjValidation").hide();
                    var tbl1 = $("#" + tname);
                    var tbl2 = $("#" + tname1);
                    console.log("tables" + mtables);

                    if (mtables != "") {
                        tbl1.append($("<option value=0>Select Table</option>"));
                        tbl2.append($("<option value=0>Select Table</option>"));

                        $.each(mtables, function (index, value) {
                            if (value != null && value != "") {
                                console.log(value);
                                tbl1.append($("<option value=" + value + ">" + value + "</option>"));
                                tbl2.append($("<option value=" + value + ">" + value + "</option>"));
                                //   tbf.push(value);
                            }

                        });
                    }
                    // $("#add_mjoin").show();
                }

                var tblCount = $("#table_feilds tbody tr").length;
                if (tblCount > 0) {
                    $("#saveJoining").show();
                    $("#clearJoining").show();
                }
                else {
                    $("#saveJoining").hide();
                    $("#clearJoining").hide();
                }
            }

            var tblCount = $("#table_feilds tbody tr").length;
            if (tblCount > 0) {
                $("#saveJoining").show();
                $("#clearJoining").show();
            }
            else {
                $("#saveJoining").hide();
                $("#clearJoining").hide();
            }


        }

        $("#add_mjoin").bind("click", function () {
            addmjoin(true);
        });

        function modelClose() {
            $("#<%= txtrName.ClientID %>").val("");
            $("#<%= txtDay.ClientID %>").val("");

            $("#<%= txtareaEmail.ClientID %>").val("");
            $("#<%= chckWebview.ClientID %>").attr("checked", false);
            $("#<%= chckSchedule.ClientID %>").attr("checked", false);
            $("#<%= optionDaily.ClientID %>").attr("checked", false);
            $("#<%= optionsWeekly.ClientID %>").attr("checked", false);
            $("#<%= optionsMonthly.ClientID %>").attr("checked", false);
            $("#<%= chckSunday.ClientID %>").attr("checked", false);
            $("#<%= chckMonday.ClientID %>").attr("checked", false);
            $("#<%= chckTuesday.ClientID %>").attr("checked", false);
            $("#<%= chckWenesday.ClientID %>").attr("checked", false);
            $("#<%= chckThursday.ClientID %>").attr("checked", false);
            $("#<%= chckFriday.ClientID %>").attr("checked", false);
            $("#<%= chckSaturday.ClientID %>").attr("checked", false);
            $("#<%= optionsDay.ClientID %>").attr("checked", false);

            $("#<%= chckWenesday.ClientID %>").attr("checked", false);

            $("#<%= txtrName.ClientID %>").css("border-color", "#e0ebeb");

            $("#rep_name").hide();
            $("#rep_type").hide();
            $("#rep_stype").hide();
            //$("#sv_loc").hide();
            $("#wdays").hide();
            $("#betdays").hide();
            $("#montdays").hide();
        }

        function delRow(obj_id) {

            rowId = "row_" + obj_id;
            $("#" + rowId).remove();
            primary = "1";
            var tblCount = $("#table_feilds tbody tr").length;
            if (tblCount > 0) {
                $("#saveJoining").show();
                $("#clearJoining").show();
            }
            else {
                $("#saveJoining").hide();
                $("#clearJoining").hide();
                $('#mjquery').val("");
            }

        }

        function loadFields(obj_id) {
            var tableName = $("#" + obj_id).val();
            var lastChar = obj_id.substr(obj_id.length - 1);

            $.ajax({
                type: "POST",
                url: "Query_Builder.aspx/getFields",
                data: '{table: ' + JSON.stringify(tableName) + '}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    $("#tfields_" + lastChar).empty();
                    var datad = response.d.replace(/\s+/g, "");
                    var sd = JSON.parse(datad);
                    console.log(sd);
                    $("#tfields_" + lastChar).append($("<option value=0>Select Field</option>"));
                    $.each(sd, function (index, value) {
                        if (value != null && value != "") {
                            //console.log(value);
                            $("#tfields_" + lastChar).append($("<option value=" + value.ALL_COLUMNS + ">" + value.ALL_COLUMNS + "</option>"));
                        }

                    });
                }
            });
        }
        function loadFields1(obj_id) {
            var tableName = $("#" + obj_id).val();
            var lastChar = obj_id.substr(obj_id.length - 1);

            $.ajax({
                type: "POST",
                url: "Query_Builder.aspx/getFields",
                data: '{table: ' + JSON.stringify(tableName) + '}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    $("#tfields1_" + lastChar).empty();
                    var datad = response.d.replace(/\s+/g, "");
                    var sd = JSON.parse(datad);
                    console.log(sd);
                    $("#tfields1_" + lastChar).append($("<option value=0>Select Field</option>"));
                    $.each(sd, function (index, value) {
                        if (value != null && value != "") {
                            //console.log(value);
                            $("#tfields1_" + lastChar).append($("<option value=" + value.ALL_COLUMNS + ">" + value.ALL_COLUMNS + "</option>"));
                        }

                    });
                }
            });
        }


        $('#btnsortorder').click(function () {
            var sort_fields = "";
            var i = 1;
            var order;
            $("[id^=ddlsort1_]").each(function () {
                //alert($(this).val());                
                order = $('#ddlsort_1_' + i).val();

                var popus = document.getElementById('ssaved');
                var popuf = document.getElementById('sfallf');

                if ($(this).val() != "0" && order != "0") {
                    sort_fields += $(this).val() + "" + order + ",";
                    popus.classList.toggle('show');
                    setTimeout(function () {
                        popus.classList.toggle('show')
                    }, 3000);
                }
                else {
                    popuf.classList.toggle('show');
                    setTimeout(function () {
                        popuf.classList.toggle('show')
                    }, 3000);
                }


                //alert(sort_fields);
                i += 1;
            })
            $('#hfSelectedValue').val("");
            $('#hfSelectedValue').val(sort_fields);
            return false;
        });
        $('#btnreorderSave').click(function getlist() {

            var label = $('#lbl_colname').text();

            $('#hddnreorderField').val(label);

            $('#hddnreorderField').empty();

<%--            $("#<%=tisDisplay%>").removeAttr('checked');
            $("#<%=tisFilter%>").removeAttr('checked');
         
            $("#<%=tdisplayName%>").val("");
            $("#<%=ddlagregation%>").val("None")--%>

        });

        //-----Save Report Validations -----       

        function saveReportFunctionalities() {

            var txtrName = $.trim($("#<%= txtrName.ClientID %>").val());
            var reptype = $("#<%= chckWebview.ClientID %>").is(":checked");
            var reptype1 = $("#<%= chckSchedule.ClientID %>").is(":checked");
            var repstyped = $("#<%= optionDaily.ClientID %>").is(":checked");
            var repstypew = $("#<%= optionsWeekly.ClientID %>").is(":checked");
            var repstypem = $("#<%= optionsMonthly.ClientID %>").is(":checked");
            var wds = $("#<%= chckSunday.ClientID %>").is(":checked");
            var wdm = $("#<%= chckMonday.ClientID %>").is(":checked");
            var wdt = $("#<%= chckTuesday.ClientID %>").is(":checked");
            var wdw = $("#<%= chckWenesday.ClientID %>").is(":checked");
            var wdth = $("#<%= chckThursday.ClientID %>").is(":checked");
            var wdf = $("#<%= chckFriday.ClientID %>").is(":checked");
            var wdst = $("#<%= chckSaturday.ClientID %>").is(":checked");
            var mdsr = $("#<%= optionsDay.ClientID %>").is(":checked");
            var mdsd = $.trim($("#<%= txtDay.ClientID %>").val());
            var loc = "C:\\";

            if (txtrName == "") {
                $("#rep_name").show();
                return false;
            } else { $("#rep_name").hide(); }

            if (!reptype && !reptype1) {
                $("#rep_type").show();
                return false;
            } else { $("#rep_type").hide(); }

            if (reptype1) {
                if (!repstyped && !repstypew && !repstypem) {
                    $("#rep_stype").show();
                    return false;
                } else { $("#rep_stype").hide(); }


            }
            //if (reptype1) {
            //    if (loc == "") {
            //        $("#sv_loc").show();
            //        return false;
            //    } else { $("#sv_loc").hide(); }
            //}

            if (repstypew) {
                if (!wds && !wdm && !wdt && !wdw && !wdth && !wdf && !wdst) {
                    $("#wdays").show();
                    return false;
                } else { $("#wdays").hide(); }
            }

            if (repstypem) {

                if (mdsd != "") {
                    if (parseInt(mdsd) > 0 && parseInt(mdsd) <= 28) {
                        $("#betdays").hide();
                    } else {
                        $("#betdays").show();
                        return false;
                    }
                }

                if (!mdsr || mdsd == "") {
                    $("#montdays").show();
                    return false;
                } else { $("#montdays").hide(); }

                var textval = $("#<%= txtrName.ClientID %>").val();
                if (textval != "" && textval != null) {
                    $.ajax({
                        type: "POST",
                        url: "Query_Builder.aspx/validateReportname",
                        data: "{ repName: '" + textval + "' }",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            if (response.d == "true") {
                                //alert("Name Already Exists"); 
                                $("#<%= txtrName.ClientID %>").css("border-color", "red");
                                $("#<%= txtrName.ClientID %>").focus();
                                var poprep = document.getElementById('popuprep');
                                poprep.classList.toggle('show');
                                setTimeout(function () {
                                    poprep.classList.toggle('show');
                                }, 3000);
                                $("#<%= txtrName.ClientID %>").val("");
                                return false;
                            }
                            else {
                                //alert("Name Available");     
                                $("#<%= txtrName.ClientID %>").css("border-color", "#e0ebeb");
                            }
                        }
                    });
                }
            }

            $("#load").show();

        }

        function closeTabMaster(cond1) {
            if (!cond1)
                $("#table-report #form_group_widget2").hide();
            else
                $("#table-report #form_group_widget2").hide();
        }

        function closeTab(cond1) {
            if (!cond1) {
                $("#tdisplayName").css("border-color", "white");
                if (isdis != $('#tisDisplay').is(":checked") || isfilter != $('#tisFilter').is(":checked") || disName != $("[id*=tdisplayName]").val() || aggre != $('#<%= ddlagregation.ClientID %>').val() || sortBy != $('#<%= ddlsortOrder.ClientID %>').val() || parameterType != $('#<%= ddlDataType.ClientID %>').val())
                    cond = confirm('Are you sure move from this without saving ?');
                if (cond) {
                    $("#table-report [id^=right_arrow]").removeClass("glyphicon glyphicon-menu-right");
                    $("#table-report #form_group_widget").hide();
                    $("#table-report #input_group_widget input:radio").attr("checked", false);
                    primary = "1";
                    //$("#btnreorderSave").hide();
                    $('#form_group_widget2').hide();
                    isdis = true;
                    isfilter = false;
                    disName = "";
                    aggre = "None";
                    sortBy = "None";
                    parameterType = "None";
                    $('#tisDisplay').prop("checked", true);
                    $('#tisFilter').prop("checked", false);
                    $("[id*=tdisplayName]").val("");
                    $('#<%= ddlagregation.ClientID %>').val("None");
                    $('#<%= ddlsortOrder.ClientID %>').val("None");
                    $('#<%= ddlDataType.ClientID %>').val("None");
                }
            }
            else {
                $("#tdisplayName").css("border-color", "white");
                $("#table-report [id^=right_arrow]").removeClass("glyphicon glyphicon-menu-right");
                $("#table-report #form_group_widget").hide();
                $("#table-report #input_group_widget input:radio").attr("checked", false);
                primary = "1";
                //$("#btnreorderSave").hide();
                $('#form_group_widget2').hide();
            }

        }

        var precond_lbl = "Precondition - ";
        //TABLE REPORT STARTS
        var tab_prefix = "table";
        var sub_prefix = "sub";
        var cond = true;
        var gcnd = true;
        var isdis = true;
        var isfilter = false;
        var disName = "";
        var aggre = "None";
        var sortBy = "None";
        var parameterType = "None";
        function showColumnWidget(li_id, obj) {
            $("#btnreorderSave").show();
            radiobtn_id = $(obj).children("[id^=radio_]").attr("id");

            if (primary != "1") {
                if (isdis != $('#tisDisplay').is(":checked") || isfilter != $('#tisFilter').is(":checked") || disName != $("[id*=tdisplayName]").val() || aggre != $('#<%= ddlagregation.ClientID %>').val() || sortBy != $('#<%= ddlsortOrder.ClientID %>').val() || parameterType != $('#<%= ddlDataType.ClientID %>').val())
                    cond = confirm('Are you sure move from this without saving ?');
                else
                    cond = true;
            }
            else {
                $(obj).children("input").prop("checked", true);
                primary = "0";
                isdis = $('#tisDisplay').is(":checked");
                isfilter = $('#tisFilter').is(":checked");
                disName = $("[id*=tdisplayName]").val();
                aggre = $('#<%= ddlagregation.ClientID %>').val();
                sortBy = $('#<%= ddlsortOrder.ClientID %>').val();
                parameterType = $('#<%= ddlDataType.ClientID %>').val();
            }

            if ($('#tisFilter').is(":checked")) {
                $('#<%= ddlDataType.ClientID %>').prop("disabled", false);
            } else {
                $('#<%= ddlDataType.ClientID %>').prop("disabled", true);
            }

            if (cond == true) {
                var lbl = radiobtn_id.replace("radio_", "");
                $("#" + tab_prefix + "-report #form_group_widget").slideDown('fast');
                $("#" + tab_prefix + "-report [id^=right_arrow]").removeClass("glyphicon glyphicon-menu-right");
                $(obj).next("span").addClass("glyphicon glyphicon-menu-right");
                $("#" + tab_prefix + "-report #lbl_colname").html(lbl);
                $("#" + tab_prefix + "-report #lbl_colname2").html(precond_lbl + lbl);
                $(obj).children("input").prop("checked", true);
                $("#ddlmlookuptable").empty();
                $("#select2-ddlmlookuptable-container").text("Please Choose");
                $("#ddlmlookupfields").empty();
                //$(".mtable").slimScroll();


                $("#lbllookupquery").text("");
                $('#form_group_widget2').hide();

                $("#ddlmlookupfields").append('<option value="' + 0 + '">Select Option</option>');
                $.ajax({
                    type: "POST",
                    url: "Query_Builder.aspx/getUser",
                    data: '{label: ' + JSON.stringify(lbl) + '}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        //console.log(response);

                        $('#tisDisplay').prop("checked", response.d.IsDisplay);
                        $('#tisFilter').prop("checked", response.d.IsFilter);
                        $("[id*=tdisplayName]").val(response.d.DisplayName);
                        $('#<%= ddlagregation.ClientID %>').val(response.d.Aggregation);
                        $('#<%= ddlsortOrder.ClientID %>').val(response.d.SortBy);
                        $('#<%= ddlDataType.ClientID %>').val(response.d.parameterType);

                        isdis = $('#tisDisplay').is(":checked");
                        isfilter = $('#tisFilter').is(":checked");
                        disName = $("[id*=tdisplayName]").val();
                        aggre = $('#<%= ddlagregation.ClientID %>').val();
                    sortBy = $('#<%= ddlsortOrder.ClientID %>').val();
                        parameterType = $('#<%= ddlDataType.ClientID %>').val();
                        $("#lookuptable tbody tr").remove();
                        var dtype = $('#<%= ddlDataType.ClientID %>').val();

                    if ($('#tisFilter').is(":checked")) {
                        $('#<%= ddlDataType.ClientID %>').prop("disabled", false);
                        } else {
                            $('#<%= ddlDataType.ClientID %>').prop("disabled", true);
                        }

                        if (dtype == "Master") {
                            $('#form_group_widget2').show();

                            $.ajax({
                                type: "POST",
                                url: "Query_Builder.aspx/getmaster",
                                data: '{label: ' + JSON.stringify(lbl) + '}',
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function (response) {
                                    //console.log("MasterLookup");
                                    //console.log(response.d);
                                    $("#ddlmLookup").val(response.d.LookUpType);
                                    ////////----
                                    var dtype1 = $("#ddlmLookup").val();
                                    if (dtype1 != "0") {
                                        //$("#load1").show();
                                        $.ajax({
                                            type: "POST",
                                            url: "Query_Builder.aspx/GetTables",
                                            data: "{ table: '" + dtype1 + "' }",
                                            contentType: "application/json; charset=utf-8",
                                            dataType: "json",
                                            success: function (responses) {
                                                var mlookup = responses.d.replace(/\s+/g, "");
                                                var lookupdata = JSON.parse(mlookup);
                                                var sel = $('#ddlmlookuptable');
                                                $('#ddlmlookuptable').empty();
                                                console.log(lookupdata);
                                                if (lookupdata.length != 0) {
                                                    $.each(lookupdata, function (key, value) {
                                                        console.log("name = " + value.NAME);
                                                        sel.append('<option value="' + value.NAME + '">' + value.NAME + '</option>');

                                                    });
                                                }
                                                else {

                                                    $("#load1").hide();
                                                }

                                                //---------------------------------------------
                                                $("#ddlmlookuptable").val(response.d.TableName);
                                                $("#select2-ddlmlookuptable-container").text(response.d.TableName);

                                                //alert(response.d.LookUpQuery);


                                                /////
                                                var dtype = $("#ddlmlookuptable").val();
                                                //alert(dtype);
                                                if (dtype != "0") {
                                                    //alert(dtype);
                                                    $("#load1").show();
                                                    $.ajax({
                                                        type: "POST",
                                                        url: "Query_Builder.aspx/getFields",
                                                        data: '{table: ' + JSON.stringify(dtype) + '}',
                                                        contentType: "application/json; charset=utf-8",
                                                        dataType: "json",
                                                        success: function (data) {

                                                            var mlookup = data.d.replace(/\s+/g, "");
                                                            var lookupdata = JSON.parse(mlookup);
                                                            $("#lookuptable tbody tr").remove();
                                                            $.each(lookupdata, function (key, value) {

                                                                $("#lookuptable tbody").append('<tr id="row_' + value.ALL_COLUMNS + '" >' +
                                                                                    '<td >' +
                                                                                        '<ul class="sidebar-menu m-b-10"  runat="server" >' +
                                                                                            '<li id="mlookuplist_' + value.ALL_COLUMNS + '" class="lookup" style="width: 100%;">' +
                                                                                             ' <span ><input type="checkbox" class="lookup_chk" name="checkbox" id="' + value.ALL_COLUMNS + '" onclick="mappingClick(this);" ></span> ' +
                                                                                                 '<span><label for="mlook">' + value.ALL_COLUMNS + '</label> </span>' +
                                                                                                 '<span><input type="text" id="txtmField_' + value.ALL_COLUMNS + '" class="form-control input-sm" style="color:#666;height:28px;" onclick="changemapfield()" name="textbox" value=' + value.ALL_COLUMNS + '></span>' +
                                                                                            '</li>' +

                                                                                        '</ul>' +
                                                                                    '</td>' +
                                                                                '</tr>');

                                                                //if (value.ALL_COLUMNS == response.d.TableName) {
                                                                //    alert("true");
                                                                //    alert(response.d.DisplayName);
                                                                //}
                                                                //else {
                                                                //    alert("false");

                                                                //}
                                                                $("#load1").hide();
                                                            });
                                                            $("#lbllookupquery").empty();
                                                            //console.log("------------------------------------");
                                                            //console.log(response.d.LookUpColumn);
                                                            if (response.d.LookUpColumn.Count != 0) {
                                                                $("#ddlmlookupfields").empty();
                                                                $("#ddlmlookupfields").append('<option value="' + 0 + '">Select Option</option>');
                                                                $.each(response.d.LookUpColumn, function (index, value) {
                                                                    $("#lookuptable .lookup_chk").each(function () {
                                                                        var lookup_chk_id = $(this).attr("id");
                                                                        if (lookup_chk_id == value.LookUpActualColumn) {
                                                                            $(this).prop("checked", true);
                                                                            mappingClick(this);
                                                                            $("#btnreorderSave").show();
                                                                        }
                                                                        $("#txtmField_" + value.LookUpActualColumn).val(value.LookUpAliasColumn)
                                                                    });

                                                                });

                                                                $("#ddlmlookupfields").val(response.d.MappingField);
                                                                $("#lbllookupquery").text(response.d.LookUpQuery);
                                                                $("#load1").hide();
                                                            }
                                                            else {
                                                                $("#load1").hide();
                                                            }
                                                        },
                                                        failure: function (failure) {
                                                            $("#load1").hide();
                                                        },
                                                        error: function (error) {

                                                            $("#load1").hide();
                                                        }
                                                    });
                                                }


                                            }
                                        });
                                    }
                                    else {
                                        $('#form_group_widget2').hide();
                                    }

                                },
                                failure: function (response) {

                                    $("#load1").hide();
                                },
                                error: function (response) {

                                    $("#load1").hide();
                                }
                            });
                        }
                        ////////----

                    }
                });
            }
            else {
                return false;
            }

        }
        <%--   var precond_lbl = "Precondition - ";
       
        var tab_prefix = "table";
        function colum_radion_btn() {

            //alert('colum_radion_btn');
            $("#" + tab_prefix + "-report #input_group_widget input:radio").click(function () {
                if ($(this).is(":checked")) {
                    $("#" + tab_prefix + "-report #form_group_widget").slideDown('fast');
                    var lbl = $(this).parent().next(".form-control").text();//alert($(this).parent().next().next().attr('class'));//lbl_colname
                    $("#" + tab_prefix + "-report [id^=right_arrow]").removeClass("glyphicon glyphicon-menu-right");
                    $(this).parent().next().next("#right_arrow").addClass("glyphicon glyphicon-menu-right");
                    $("#" + tab_prefix + "-report #lbl_colname").html(lbl);
                    $("#" + tab_prefix + "-report #lbl_colname2").html(precond_lbl + lbl);

                    //     $('#btnvalidate').attr("disabled", true);
                    $("#btnreorderSave").show();
                    $.ajax({
                        type: "POST",
                        url: "Query_Builder.aspx/getUser",
                        data: '{label: ' + JSON.stringify(lbl) + '}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            console.log(response);

                            $('#tisDisplay').prop("checked", response.d.IsDisplay);
                            $('#tisFilter').prop("checked", response.d.IsFilter);
                            $("[id*=tdisplayName]").val(response.d.DisplayName);
                            $('#<%= ddlagregation.ClientID %>').val(response.d.Aggregation);
                            $('#<%= ddlsortOrder.ClientID %>').val(response.d.SortBy);
                        }
                    });

                } else {
                    $("#" + tab_prefix + "-report #form_group_widget").slideUp('fast');
                    $("#" + tab_prefix + "-report #form_control_widget").slideUp('fast');
                    $("#lbl_colname").html("");
                }
            });
        }--%>

        // $('a[id^=tbl_list_href_]').click(
        function loadTFields(obj) {

            var href_id = $(obj).attr('id');
            var tbl_name = href_id.split('tbl_list_href_')[1];
            var tblColumns;
            var len = $("#" + tbl_name).has("li").has("a").length;

            if (jQuery(obj).next().is(':hidden') == true && len == 0) {
                $("#load1").show();
                $.ajax({

                    type: 'POST',
                    dataType: 'json',
                    url: "Query_Builder.aspx/getFields",
                    contentType: 'application/json; charset=utf-8',
                    data: "{ table: '" + tbl_name + "' }",

                    success: function (response) {
                        if (response.d.length == 0) {
                            $("#load1").hide();
                        }
                        var datad = response.d.replace(/\s+/g, "");
                        var sd = JSON.parse(datad);
                        console.log(sd);
                        var tblId = $("#chldtree_" + tbl_name);
                        $("#chldtree_" + tbl_name + " a").each(function () {
                            $(obj).remove();
                        });

                        $.each(sd, function (index, value) {
                            tblColumns = '<a>' +
                                          '<div><p>' +
                                          '<input type="checkbox" class="chkExpo" id="InputCheck" value=' + value.ALL_COLUMNS + ' />' + value.ALL_COLUMNS + '' +
                                          '</p></div>' +
                                          '</a>';

                            tblId.append(tblColumns);
                        });
                        $("#load1").hide();
                    },
                    error: function (err) {
                        alert('Error');
                    }
                })
            }
        }


        function toggle_dbwidget(clr) {
            //  $("#example10 > tr").remove();
            // $('#example10').empty()
            if (clr)
                clearViewChange();

            var dtype = document.getElementById("ddlPriority").value;
            //alert(dtype);
            if (dtype != "0") {

                if (dtype == "Tables") {
                    $("#lbltov").text("List Of Tables");
                }
                else if (dtype == "Views") {
                    $("#lbltov").text("List Of Views");
                }
                else if (dtype == "Both") {
                    $("#lbltov").text("List Of Tables and Views");
                }

                $("#load1").show();
                $.ajax({
                    type: "POST",
                    url: "Query_Builder.aspx/GetTables",
                    data: "{ table: '" + dtype + "' }",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        $("#btnSelect").show();
                        //$("#tinfo").show();
                        $("#example10").dataTable().fnDestroy();
                        OnSuccess(response);
                    },
                    failure: function (response) {
                        $("#btnSelect").hide();
                        //$("#tinfo").hide();
                        $("#load1").hide();
                    },
                    error: function (response) {
                        $("#btnSelect").hide();
                        //$("#tinfo").hide();
                        $("#load1").hide();
                    }
                });
            }

        }


        function master_lookup_table() {
            $("#btnreorderSave").hide();
            var dtype = document.getElementById("ddlmlookuptable").value;
            $("#ddlmlookupfields").empty();
            $("#ddlmlookupfields").append('<option value="' + 0 + '">Select Option</option>');
            if (dtype != "0") {
                $("#load1").show();
                $.ajax({
                    type: "POST",
                    url: "Query_Builder.aspx/getFields",
                    data: '{table: ' + JSON.stringify(dtype) + '}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {

                        var mlookup = response.d.replace(/\s+/g, "");
                        var lookupdata = JSON.parse(mlookup);
                        $("#lookuptable tbody tr").remove();
                        $.each(lookupdata, function (key, value) {

                            $("#lookuptable tbody").append('<tr id="row_' + value.ALL_COLUMNS + '" >' +
                                                '<td >' +
                                                    '<ul class="sidebar-menu m-b-10"  runat="server" >' +
                                                        '<li id="mlookuplist_' + value.ALL_COLUMNS + '" class="lookup" style="width: 100%;">' +
                                                         ' <span ><input type="checkbox" class="lookup_chk" name="checkbox" id="' + value.ALL_COLUMNS + '" onclick="mappingClick(this);" ></span> ' +
                                                             '<span><label for="mlook">' + value.ALL_COLUMNS + '</label> </span>' +
                                                             '<span><input type="text" id="txtmField_' + value.ALL_COLUMNS + '" onkeypress="return applyClickTxt(event)" class="form-control input-sm" style="color:#666;height:28px;" name="textbox" value=' + value.ALL_COLUMNS + '></span>' +
                                                        '</li>' +

                                                    '</ul>' +
                                                '</td>' +
                                            '</tr>');


                            $("#load1").hide();
                        });
                        //setTimeout("dummy()", 3000);
                        $("#lbllookupquery").empty();
                        //$("#lookupdiv").addClass(".mtable");
                        //$(".mtable").slimScroll();
                    },
                    failure: function (response) {

                        $("#load1").hide();
                    },
                    error: function (response) {

                        $("#load1").hide();
                    }
                });
            }

        }

        $("#btnmApply").click(function () {
            var mFields = {};

            mFields.LookUpType = $('#ddlmLookup').val();
            mFields.TableName = $('#ddlmlookuptable').val();
            mFields.MappingField = $('#ddlmlookupfields').val();
            mFields.LabelColumn = $("#lbltext").val();
            var mColumns = new Array();

            var poplt = document.getElementById('ltype');
            var poptbl = document.getElementById('tbl');
            var popao = document.getElementById('aofield');
            var popmf = document.getElementById('mfield');
            var popan = document.getElementById('aname');
            var allow = true;


            $.each($("#lookuptable input[type='checkbox']:checked"), function () {

                var chckval = $(this).attr("id");
                var txtid = $(this).parent().next().next('span').children('input').attr("id");
                var txtval = $("#" + txtid).val();
                var finals = chckval + ":" + txtval;
                mColumns.push(finals);

                if (txtval == null || txtval == "") {
                    allow = false;
                }
            });

            if (allow) {
                if (mFields.LookUpType != "0") {
                    if (mFields.TableName != "0") {
                        if (mColumns.length != 0) {
                            if (mFields.MappingField != "0") {

                                $.ajax({
                                    type: "POST",
                                    url: "Query_Builder.aspx/MasterLookUpSave",
                                    data: '{mFields: ' + JSON.stringify(mFields) + ',mColumns: ' + JSON.stringify(mColumns) + '}',
                                    contentType: "application/json; charset=utf-8",
                                    dataType: "json",
                                    success: function (response) {
                                        $("#lbllookupquery").text(response.d);
                                        $("#btnreorderSave").show();
                                    }
                                })

                            }
                            else {
                                popmf.classList.toggle('show');
                                setTimeout(function () {
                                    popmf.classList.toggle('show');
                                }, 3000);
                            }
                        }
                        else {
                            popao.classList.toggle('show');
                            setTimeout(function () {
                                popao.classList.toggle('show');
                            }, 3000);
                        }
                    }
                    else {
                        poptbl.classList.toggle('show');
                        setTimeout(function () {
                            poptbl.classList.toggle('show');
                        }, 3000);
                    }
                }
                else {
                    poplt.classList.toggle('show');
                    setTimeout(function () {
                        poplt.classList.toggle('show');
                    }, 3000);

                }
            }
            else {
                popan.classList.toggle('show');
                setTimeout(function () {
                    popan.classList.toggle('show');
                }, 3000);
            }

            return false;
        });


        function mappingClick(obj) {
            $("#btnreorderSave").hide();
            var dtype = $(obj).attr("id");
            var mFieds = $('#ddlmlookupfields');
            var chec = $(obj).prop("checked");

            if (chec) {
                mFieds.append('<option value="' + dtype + '">' + dtype + '</option>');
            }
            else {
                $("#ddlmlookupfields option[value='" + dtype + "']").remove();
            }

        }


        function master_datatype(obj, lblname) {
            var lblid = $(lblname).attr("id");

            var lbltext = $("#" + lblid).text();
            $("#lbltext").val(lbltext);

            var dtype = $('#<%= ddlDataType.ClientID %>').val();
            //alert(lblname);
            if (dtype == "Master") {

                $("#btnreorderSave").hide();

                $('#form_group_widget2').show();

                //------------------------------------------------------
                $.ajax({
                    type: "POST",
                    url: "Query_Builder.aspx/getmaster",
                    data: '{label: ' + JSON.stringify(lbltext) + '}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        //console.log("MasterLookup");
                        //console.log(response.d);
                        $("#ddlmLookup").val(response.d.LookUpType);
                        ////////----
                        var dtype1 = $("#ddlmLookup").val();
                        if (dtype1 != "0") {
                            //$("#load1").show();
                            $.ajax({
                                type: "POST",
                                url: "Query_Builder.aspx/GetTables",
                                data: "{ table: '" + dtype1 + "' }",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function (responses) {
                                    var mlookup = responses.d.replace(/\s+/g, "");
                                    var lookupdata = JSON.parse(mlookup);
                                    var sel = $('#ddlmlookuptable');
                                    $('#ddlmlookuptable').empty();
                                    sel.append('<option value="' + 0 + '">Please Choose</option>');
                                    console.log(lookupdata);
                                    if (lookupdata.length != 0) {
                                        $.each(lookupdata, function (key, value) {
                                            console.log("name = " + value.NAME);
                                            sel.append('<option value="' + value.NAME + '">' + value.NAME + '</option>');

                                        });
                                    }
                                    else {

                                        $("#load1").hide();
                                    }

                                    //---------------------------------------------
                                    $("#ddlmlookuptable").val(response.d.TableName);
                                    $("#select2-ddlmlookuptable-container").text(response.d.TableName);

                                    //alert(response.d.LookUpQuery);


                                    /////
                                    var dtype = $("#ddlmlookuptable").val();
                                    //alert(dtype);
                                    if (dtype != "0") {
                                        //alert(dtype);
                                        $("#load1").show();
                                        $.ajax({
                                            type: "POST",
                                            url: "Query_Builder.aspx/getFields",
                                            data: '{table: ' + JSON.stringify(dtype) + '}',
                                            contentType: "application/json; charset=utf-8",
                                            dataType: "json",
                                            success: function (data) {

                                                var mlookup = data.d.replace(/\s+/g, "");
                                                var lookupdata = JSON.parse(mlookup);
                                                $("#lookuptable tbody tr").remove();
                                                $.each(lookupdata, function (key, value) {

                                                    $("#lookuptable tbody").append('<tr id="row_' + value.ALL_COLUMNS + '" >' +
                                                                        '<td >' +
                                                                            '<ul class="sidebar-menu m-b-10"  runat="server" >' +
                                                                                '<li id="mlookuplist_' + value.ALL_COLUMNS + '" class="lookup" style="width: 100%;">' +
                                                                                 ' <span ><input type="checkbox" class="lookup_chk" name="checkbox" id="' + value.ALL_COLUMNS + '" onclick="mappingClick(this);" ></span> ' +
                                                                                     '<span><label for="mlook">' + value.ALL_COLUMNS + '</label> </span>' +
                                                                                     '<span><input type="text" id="txtmField_' + value.ALL_COLUMNS + '" class="form-control input-sm" style="color:#666;height:28px;" name="textbox" value=' + value.ALL_COLUMNS + '></span>' +
                                                                                '</li>' +

                                                                            '</ul>' +
                                                                        '</td>' +
                                                                    '</tr>');

                                                    //if (value.ALL_COLUMNS == response.d.TableName) {
                                                    //    alert("true");
                                                    //    alert(response.d.DisplayName);
                                                    //}
                                                    //else {
                                                    //    alert("false");

                                                    //}
                                                    $("#load1").hide();
                                                });
                                                $("#lbllookupquery").empty();
                                                //console.log("------------------------------------");
                                                //console.log(response.d.LookUpColumn);
                                                if (response.d.LookUpColumn.Count != 0) {
                                                    $("#ddlmlookupfields").empty();
                                                    $("#ddlmlookupfields").append('<option value="' + 0 + '">Select Option</option>');
                                                    $.each(response.d.LookUpColumn, function (index, value) {
                                                        $("#lookuptable .lookup_chk").each(function () {
                                                            var lookup_chk_id = $(this).attr("id");
                                                            if (lookup_chk_id == value.LookUpActualColumn) {
                                                                $(this).prop("checked", true);
                                                                mappingClick(this);
                                                                //$("#btnreorderSave").show();
                                                            }
                                                            $("#txtmField_" + value.LookUpActualColumn).val(value.LookUpAliasColumn)
                                                        });

                                                    });

                                                    $("#ddlmlookupfields").val(response.d.MappingField);
                                                    $("#lbllookupquery").text(response.d.LookUpQuery);
                                                    $("#load1").hide();
                                                }
                                                else {
                                                    $("#load1").hide();
                                                }
                                            },
                                            failure: function (failure) {
                                                $("#load1").hide();
                                            },
                                            error: function (error) {

                                                $("#load1").hide();
                                            }
                                        });
                                    }

                                    /////                    


                                }
                            });
                        }
                        else {
                            //$('#form_group_widget2').hide();
                            var sel = $('#ddlmlookuptable');
                            $('#ddlmlookuptable').empty();
                            sel.append('<option value="' + 0 + '">Please Choose</option>');
                        }

                    },
                    failure: function (response) {

                        $("#load1").hide();
                    },
                    error: function (response) {

                        $("#load1").hide();
                    }
                });
                //------------------------------------------------------
            }
            else {
                $('#form_group_widget2').hide();
                $("#btnreorderSave").show();
            }
        };
        function master_lookup() {
            $("#btnreorderSave").hide();
            var dtype = document.getElementById("ddlmLookup").value;
            if (dtype != "0") {
                if (dtype == "Tables") {
                    $("#tvname").text("Table");
                }
                else if (dtype == "Views") {
                    $("#tvname").text("View");
                }

                $("#load1").show();

                $.ajax({
                    type: "POST",
                    url: "Query_Builder.aspx/GetTables",
                    data: "{ table: '" + dtype + "' }",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",

                    success: function (response) {
                        var mlookup = response.d.replace(/\s+/g, "");
                        var lookupdata = JSON.parse(mlookup);
                        var sel = $('#ddlmlookuptable');
                        $('#ddlmlookuptable').empty();
                        console.log(lookupdata);
                        sel.append('<option value="' + 0 + '">Please Choose</option>');
                        if (lookupdata.length != 0) {
                            $.each(lookupdata, function (key, value) {
                                console.log("name = " + value.NAME);
                                sel.append('<option value="' + value.NAME + '">' + value.NAME + '</option>');

                                $("#load1").hide();
                            });
                        }
                        else {

                            $("#load1").hide();
                        }

                    },
                    failure: function (response) {

                        $("#load1").hide();
                    },
                    error: function (response) {

                        $("#load1").hide();
                    }
                });
            }

        }
        // TableScreen();
        function TableScreen() {

            $('#example10').DataTable({
                destroy: true,
                scrollY: "400px",
                dom: 'frtp',
                "pageLength": 10,
                "order": [],
                "columnDefs": [{
                    "targets": 'no-sort',
                    "orderable": false,
                }]
            })
        }
        function OnSuccess(response) {

            var datad = response.d.replace(/\s+/g, "");
            var customers = JSON.parse(datad);
            console.log(customers);
            if (customers.length == 0) {
                $("#btnSelect").hide();
                //$("#tinfo").hide();
                $("#load1").hide();
            }

            $("#example10 tbody tr").remove();
            $.each(customers, function (index, value) {
                console.log("name = " + value.name);
                // alert(value.name);
                $("#example10 tbody").append('<tr>' +
                                    '<td>' +
                                        '<ul class="sidebar-menu m-b-10" id="ulparent" runat="server">' +
                                            '<li class="treeview" id="parantli" runat="server">' +
                                                '<a class="aaf" data-toggle="modal" id="tbl_list_href_' + value.NAME + '" onclick="return loadTFields(this)"><i class="fa fa-plus-circle"></i><i class="fa fa-minus-circle"></i><i class="fa fa-folder"></i><i class="fa fa-folder-open"></i>' +
                                                    '<span>' + value.NAME + '</span>' +
                                                '</a>' +
                                                '<ul class="treeview-menu" id=' + value.NAME + '>' +
                                                    '<li id="chldtree_' + value.NAME + '"></li>' +
                                                '</ul>' +
                                            '</li>' +
                                        '</ul>' +
                                    '</td>' +
                                '</tr>');

                $("#ulparent").addClass("sidebar-menu");
                $("#ulparent").addClass("m-b-10");
                $("#parantli").addClass("treeview");
                $("[id^=tbl_list_href_]").addClass("aaf");
                $("#" + value.name).addClass("treeview-menu");
                $("#load1").hide();
            });

            TableScreen();
        }

        function clearViewChange() {
            $.ajax({
                type: "POST",
                url: "Query_Builder.aspx/btnClearFields_Click",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {

                    $.each($("input[type='checkbox']"), function () {
                        $(this).parent('p').css({
                            color: '#dddddd'
                        });

                    });

                    $('.selectedField li').remove();
                    $('#HddnselectedField').val("");
                    //$("#Hlblquery").val("");
                    $('#lblquery').text("");
                    $('#mjquery').val("");
                    $("#svreport").hide();
                    $("#btnGenerate").hide();
                    $("#btngeneratereport").hide();
                    $("#table-report #form_group_widget").hide();
                    $("#table_feilds tbody tr").remove();
                    //$("#btnreorderSave").hide();
                    $("#btnClearFields").hide();
                    $("#btnvalidate").hide();
                    $('#form_group_widget2').hide();
                    //  $("#add_mjoin").hide();
                    $("#mjValidation").show();
                    $("#master_tables").val("");
                    master = [];
                    $("#clearJoining").hide();
                    $("#saveJoining").hide();
                    primary = "1";
                    modelClose();
                }
            });
        }

        $("#svreport").click(function () {
            modelClose();
        });

        $("#btnreset").click(function () {
            $('#tisDisplay').prop("checked", true);
            $('#tisFilter').prop("checked", false);
            $("[id*=tdisplayName]").val("");
            $('#<%= ddlagregation.ClientID %>').val("None");
            $('#<%= ddlsortOrder.ClientID %>').val("None");
            $('#<%= ddlDataType.ClientID %>').val("None");
            $('#form_group_widget2').hide();

            $("#btnreorderSave").show();
            return false;
        });


        $("#tisFilter").click(function () {
            if ($(this).is(":checked")) {
                $('#<%= ddlDataType.ClientID %>').prop("disabled", false);
            } else {
                $('#<%= ddlDataType.ClientID %>').prop("disabled", true);
            }
        });

        function changemapfield() {
            $("#btnreorderSave").hide();
        }

        $("#<%= txtrName.ClientID %>").keypress(function (e) {
            var regex = new RegExp("^[a-zA-Z0-9._ \b]+$");
            var str = String.fromCharCode(!e.charCode ? e.which : e.charCode);
            if (regex.test(str)) {
                return true;
            }

            e.preventDefault();
            return false;
        });

        function applyClickTxt(event) {
            var regex = new RegExp("^[a-zA-Z0-9._ \b]+$");
            var str = String.fromCharCode(!event.charCode ? event.which : event.charCode);
            if (regex.test(str)) {
                return true;
            }
            event.preventDefault();
            return false;
        }




        $(function () {
            $("#tdisplayName").keypress(function (e) {
                var regex = new RegExp("^[a-zA-Z0-9._ \b]+$");
                var str = String.fromCharCode(!e.charCode ? e.which : e.charCode);
                if (regex.test(str)) {
                    return true;
                }

                e.preventDefault();
                return false;
            });
        });

        $('#<%= txtTime.ClientID %>').click(function () {
            $(".timepicker_position a").css("position:", "absolute");
            $(".timepicker_position a").css("right:", "5px");
            $(".timepicker_position a").css("top:", "5px");
            $(".timepicker_position a").css("index:", "6000");
            $("#ptTimeSelectCntr").css("z-index", "6000");
        });



        function validatereportName() {

            var textval = $("#<%= txtrName.ClientID %>").val();
            if (textval != "" && textval != null) {
                $("#load").show();
                $.ajax({
                    type: "POST",
                    url: "Query_Builder.aspx/validateReportname",
                    data: "{ repName: '" + textval + "' }",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        if (response.d == "true") {
                            //alert("Name Already Exists"); 
                            $("#load").hide();
                            $("#<%= txtrName.ClientID %>").css("border-color", "red");
                            $("#<%= txtrName.ClientID %>").focus();
                            var poprep = document.getElementById('popuprep');
                            poprep.classList.toggle('show');
                            setTimeout(function () {
                                poprep.classList.toggle('show');
                            }, 3000);
                            $("#<%= txtrName.ClientID %>").val("");

                            return false;
                        }
                        else {
                            //alert("Name Available");    
                            $("#load").hide();
                            $("#<%= txtrName.ClientID %>").css("border-color", "#e0ebeb");
                        }
                    },
                    failure: function (response) {
                        $("#load").hide();
                    },
                    error: function (e) {
                        $("#load").hide();
                    }
                });
            }
        }
    </script>



</asp:Content>

