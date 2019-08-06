<%@ Page Title="" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="Materia.aspx.cs" Inherits="ControlLaboratorio.Materia" %>
<%@ MasterType VirtualPath="~/Principal.Master" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div id="content">
        <div class="contact1">
            <div class="container-contact1">
                <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

                <div class="contact1-form validate-form">
                    <span class="contact1-form-title">Agregar nueva materia
                    </span>

                    <div class="wrap-input1 validate-input">
                        <asp:TextBox ID="txtNomMateria" placeholder="Nombre de la materia" runat="server" CssClass="input1"></asp:TextBox>
                    </div>

                    <div class="wrap-input1 validate-input">
                        <asp:TextBox ID="txtHorasSemana" placeholder="Horas a la semana" runat="server" CssClass="input1"></asp:TextBox>
                    </div>

                    <div class="wrap-input1 validate-input">
                        <asp:TextBox ID="txtEspecialidad" placeholder="Especialidad" runat="server" CssClass="input1"></asp:TextBox>
                    </div>

                    <label for="dropListGrado" class="left my-1">Grado</label>
                    <asp:DropDownList ID="dropListGrado" CssClass="input1" runat="server" AutoPostBack="True" Height="45px" Width="100%">
                        <asp:ListItem>1</asp:ListItem>
                        <asp:ListItem>2</asp:ListItem>
                        <asp:ListItem>3</asp:ListItem>
                        <asp:ListItem>4</asp:ListItem>
                        <asp:ListItem>5</asp:ListItem>
                        <asp:ListItem>6</asp:ListItem>
                        <asp:ListItem>7</asp:ListItem>
                        <asp:ListItem>8</asp:ListItem>
                        <asp:ListItem>9</asp:ListItem>
                        <asp:ListItem>10</asp:ListItem>
                    </asp:DropDownList>

                    <div class="wrap-input1 validate-input mt-3">
                        <asp:TextBox ID="txtNota" placeholder="Nota" runat="server" CssClass="input1"></asp:TextBox>
                    </div>


                    <div class="container-contact1-form-btn mb-2">
                        <asp:Button ID="botonAgregarMateria" runat="server" Text="Agregar materia" CssClass="contact1-form-btn" OnClick="botonAgregarMateria_Click"/>

                    </div>

                    <div class="container-contact1-form-btn mb-2">
                        <asp:Button ID="botonMostrarMaterias" data-toggle="modal" data-target="#modalMaterias" runat="server" Text="Mostrar materias" CssClass="contact1-form-btn" OnClick="botonMostrarMaterias_Click"/>

                    </div>

                </div>
            </div>
        </div>
    </div>


<div class="modal fade high" id="modalMaterias" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog modal-lg modal-top" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title w-100">Lista de materias</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <asp:UpdatePanel runat="server" ChildrenAsTriggers="true" UpdateMode="Conditional">
                        <ContentTemplate>
                            <asp:GridView ID="gridMaterias" runat="server" CellPadding="4" GridLines="Horizontal" Width="100%" BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px">
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
