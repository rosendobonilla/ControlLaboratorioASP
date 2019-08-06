<%@ Page Title="" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="AsignacionGrupo.aspx.cs" Inherits="ControlLaboratorio.AsignacionGrupo" %>
<%@ MasterType VirtualPath="~/Principal.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div id="content">
        <div class="contact1">
            <div class="container-contact1">
                <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

                <div class="contact1-form validate-form">
                    <span class="contact1-form-title">Nueva asignacón de grupo
                    </span>

                    <label for="dropListCuatrimestre" class="left my-1">Cuatrimestre</label>
                    <asp:DropDownList ID="dropListCuatrimestre" CssClass="input1" runat="server" AutoPostBack="True" Height="45px" Width="100%">
                    </asp:DropDownList>

                    <label for="dropListGrupo" class="left my-1">Grupo</label>
                    <asp:DropDownList ID="dropListGrupo" CssClass="input1" runat="server" AutoPostBack="True" Height="45px" Width="100%">
                    </asp:DropDownList>

                    <label for="dropListMateria" class="left my-1">Materia</label>
                    <asp:DropDownList ID="dropListMateria" CssClass="input1" runat="server" AutoPostBack="True" Height="45px" Width="100%">
                    </asp:DropDownList>

                    <label for="dropListProfesor" class="left my-1">Profesor</label>
                    <asp:DropDownList ID="dropListProfesor" CssClass="input1" runat="server" AutoPostBack="True" Height="45px" Width="100%">
                    </asp:DropDownList>

                    <div class="wrap-input1 validate-input mt-3">
                        <asp:TextBox ID="txtEstado" placeholder="Estado" runat="server" CssClass="input1"></asp:TextBox>
                    </div>

                    <label for="dropListTurno" class="left my-1">Turno</label>
                    <asp:DropDownList ID="dropListTurno" CssClass="input1" runat="server" AutoPostBack="True" Height="45px" Width="100%">
                        <asp:ListItem Text="Matutino" Value="Matutino" />
                        <asp:ListItem Text="Vespertino" Value="Vespertino" />
                    </asp:DropDownList>

                    <div class="wrap-input1 validate-input mt-3">
                        <asp:TextBox ID="txtNota" placeholder="Nota" runat="server" CssClass="input1"></asp:TextBox>
                    </div>

                    <div class="container-contact1-form-btn mb-2">
                        <asp:Button ID="botonAgregarAsignacion" runat="server" Text="Agregar asignación" CssClass="contact1-form-btn" OnClick="botonAgregarAsignacion_Click" />

                    </div>

                    <div class="container-contact1-form-btn mb-2">
                        <asp:Button ID="botonMostrarAsignaciones" data-toggle="modal" data-target="#modalAsignaciones" runat="server" Text="Mostrar asignaciones" CssClass="contact1-form-btn" OnClick="botonMostrarAsignaciones_Click" />

                    </div>

                </div>
            </div>
        </div>
    </div>

    <div class="modal fade high" id="modalAsignaciones" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog modal-lg modal-top" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title w-100">Lista de de asignaciones de grupo</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <asp:UpdatePanel runat="server" ChildrenAsTriggers="true" UpdateMode="Conditional">
                        <ContentTemplate>
                            <asp:GridView ID="gridAsignaciones" runat="server" CellPadding="4" GridLines="Horizontal" Width="100%" BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px">
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
