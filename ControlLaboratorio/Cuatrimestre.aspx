<%@ Page Title="" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="Cuatrimestre.aspx.cs" Inherits="ControlLaboratorio.Cuatrimestre" %>

<%@ MasterType VirtualPath="~/Principal.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div id="content">
        <div class="contact1">
            <div class="container-contact1">
                <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

                <div class="contact1-form validate-form">
                    <span class="contact1-form-title">Agregar nuevo cuatrimestre
                    </span>

                    <div class="wrap-input1 validate-input">
                        <asp:DropDownList ID="dropListPeriodo" CssClass="input1" runat="server" AutoPostBack="True" Height="45px" Width="100%">
                            <asp:ListItem>Enero-Abril</asp:ListItem>
                            <asp:ListItem>Mayo-Agosto</asp:ListItem>
                            <asp:ListItem>Septiembre-Diciembre</asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div class="wrap-input1 validate-input">
                        <asp:TextBox ID="txtAno" placeholder="Año" runat="server" CssClass="input1"></asp:TextBox>
                    </div>
                    <asp:UpdatePanel runat="server" ID="panelFechaInicio" UpdateMode="Conditional">
                        <ContentTemplate>
                            <div class="input-group my-3">
                                <asp:TextBox ID="txtFechaInicio" Enabled="false" runat="server" CssClass="form-control" placeholder="Fecha inicio"></asp:TextBox>
                                <div class="input-group-append">
                                    <asp:Button ID="botonFechaInicio" CssClass="btn btn-md btn-secondary m-0 px-3" runat="server" Text="Elegir fecha" data-toggle="modal" data-target="#modalCalendarInicio" OnClick="botonFechaInicio_Click" />
                                </div>
                            </div>
                            <asp:Label ID="labelFechaInicio" runat="server" Text="Label" Visible="False"></asp:Label>

                        </ContentTemplate>
                    </asp:UpdatePanel>

                    <asp:UpdatePanel runat="server" ID="panelFechaFin" UpdateMode="Conditional">
                        <ContentTemplate>
                            <div class="input-group my-3">
                                <asp:TextBox ID="txtFechaFin" Enabled="false" runat="server" CssClass="form-control" placeholder="Fecha fin"></asp:TextBox>
                                <div class="input-group-append">
                                    <asp:Button ID="botonFechafin" CssClass="btn btn-md btn-secondary m-0 px-3" runat="server" Text="Elegir fecha" data-toggle="modal" data-target="#modalCalendarFin" OnClick="botonFechafin_Click" />
                                </div>
                            </div>
                            <asp:Label ID="labelFechaFin" runat="server" Text="Label" Visible="False"></asp:Label>
                        </ContentTemplate>
                    </asp:UpdatePanel>

                    <div class="wrap-input1 validate-input">
                        <asp:TextBox ID="txtNota" placeholder="Nota" runat="server" CssClass="input1"></asp:TextBox>
                    </div>



                    <div class="container-contact1-form-btn mb-2">
                        <asp:Button ID="botonAgregarCuatrimestre" runat="server" Text="Agregar cuatrimestre" CssClass="contact1-form-btn" OnClick="botonAgregarCuatrimestre_Click" />

                    </div>

                    <div class="container-contact1-form-btn mb-2">
                        <asp:Button ID="botonMostrarCuatrimestres" data-toggle="modal" data-target="#modalCuatrimestres" runat="server" Text="Mostrar cuatrimestres" CssClass="contact1-form-btn" OnClick="botonMostrarCuatrimestres_Click" />

                    </div>

                </div>
            </div>
        </div>
    </div>


    <div class="modal fade" id="modalCalendarInicio" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle"
        aria-hidden="true">
        <div class="modal-dialog modal-lg modal-top" role="document">
            <div class="modal-content">
                <div class="modal-body">
                    <div class="form-group mt-3">
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
                            <ContentTemplate>
                                <asp:Calendar ID="Calendar1" runat="server" BackColor="White" BorderColor="White" BorderWidth="1px" Font-Names="Verdana" Font-Size="9pt" ForeColor="Black" Height="190px" NextPrevFormat="FullMonth" Width="100%" OnSelectionChanged="Calendar1_SelectionChanged">
                                    <DayHeaderStyle Font-Bold="True" Font-Size="8pt" />
                                    <NextPrevStyle Font-Bold="True" Font-Size="8pt" ForeColor="#333333" VerticalAlign="Bottom" />
                                    <OtherMonthDayStyle ForeColor="#999999" />
                                    <SelectedDayStyle BackColor="#333399" ForeColor="White" />
                                    <TitleStyle BackColor="White" BorderColor="Black" BorderWidth="4px" Font-Bold="True" Font-Size="12pt" ForeColor="#333399" />
                                    <TodayDayStyle BackColor="#CCCCCC" />
                                </asp:Calendar>

                            </ContentTemplate>
                        </asp:UpdatePanel>

                        <br />
                    </div>
                </div>
            </div>
        </div>
    </div>


    <div class="modal fade" id="modalCalendarFin" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle"
        aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-body">
                    <div class="form-group mt-3">
                        <asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
                            <ContentTemplate>
                                <asp:Calendar ID="Calendar2" runat="server" BackColor="White" BorderColor="White" BorderWidth="1px" Font-Names="Verdana" Font-Size="9pt" ForeColor="Black" Height="190px" NextPrevFormat="FullMonth" Width="100%" OnSelectionChanged="Calendar2_SelectionChanged">
                                    <DayHeaderStyle Font-Bold="True" Font-Size="8pt" />
                                    <NextPrevStyle Font-Bold="True" Font-Size="8pt" ForeColor="#333333" VerticalAlign="Bottom" />
                                    <OtherMonthDayStyle ForeColor="#999999" />
                                    <SelectedDayStyle BackColor="#333399" ForeColor="White" />
                                    <TitleStyle BackColor="White" BorderColor="Black" BorderWidth="4px" Font-Bold="True" Font-Size="12pt" ForeColor="#333399" />
                                    <TodayDayStyle BackColor="#CCCCCC" />
                                </asp:Calendar>

                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <br />

                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade high" id="modalCuatrimestres" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog modal-lg modal-top" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title w-100">Lista de cuatrimestres</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <asp:UpdatePanel runat="server" ChildrenAsTriggers="true" UpdateMode="Conditional">
                        <ContentTemplate>
                            <asp:GridView ID="gridCuatrimestres" runat="server" CellPadding="4" GridLines="Horizontal" Width="100%" BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px">
                                <FooterStyle BackColor="White" ForeColor="#333333" />
                                <HeaderStyle BackColor="#336666" Font-Bold="True" ForeColor="White" />
                                <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Center" />
                                <RowStyle BackColor="White" ForeColor="#333333" />
                                <SelectedRowStyle BackColor="#339966" Font-Bold="True" ForeColor="White" />
                                <SortedAscendingCellStyle BackColor="#F7F7F7" />
                                <SortedAscendingHeaderStyle BackColor="#487575" />
                                <SortedDescendingCellStyle BackColor="#E5E5E5" />
                                <SortedDescendingHeaderStyle BackColor="#275353" />
                            </asp:GridView>

                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <asp:Label ID="labelMensajesGrid" runat="server" />


                </div>
            </div>
        </div>
    </div>


</asp:Content>
