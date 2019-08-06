<%@ Page Title="" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="Profesor.aspx.cs" Inherits="ControlLaboratorio.Profesor" %>

<%@ MasterType VirtualPath="~/Principal.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div id="content">
        <div class="contact1">
            <div class="container-contact1">
                <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

                <div class="contact1-form validate-form">
                    <span class="contact1-form-title">Agregar nuevo profesor
                    </span>

                    <div class="wrap-input1 validate-input">
                        <asp:TextBox ID="txtNom" placeholder="Nombre" runat="server" CssClass="input1"></asp:TextBox>
                    </div>

                    <div class="wrap-input1 validate-input">
                        <asp:TextBox ID="txtPaterno" placeholder="Apellido paterno" runat="server" CssClass="input1"></asp:TextBox>
                    </div>

                    <div class="wrap-input1 validate-input">
                        <asp:TextBox ID="txtMaterno" placeholder="Apellido materno" runat="server" CssClass="input1"></asp:TextBox>
                    </div>

                    <div class="wrap-input1 validate-input">
                        <asp:TextBox ID="txtArea" placeholder="Area" runat="server" CssClass="input1"></asp:TextBox>
                    </div>

                    <div class="wrap-input1 validate-input">
                        <asp:TextBox ID="txtCategoria" placeholder="Categoria" runat="server" CssClass="input1"></asp:TextBox>
                    </div>

                    <div class="wrap-input1 validate-input">
                        <asp:TextBox ID="txtNota" placeholder="Nota" runat="server" CssClass="input1"></asp:TextBox>
                    </div>

                    <asp:CheckBox Text="Administrador" runat="server" ID="checkAdministrador" />

                    <div class="container-contact1-form-btn mb-2">
                        <asp:Button ID="botonAgregarProfesor" runat="server" Text="Agregar profesor" CssClass="contact1-form-btn" OnClick="botonAgregarProfesor_Click" />

                    </div>

                    <div class="container-contact1-form-btn mb-2">
                        <asp:Button ID="botonMostrarProfesores" data-toggle="modal" data-target="#modalProfesores" runat="server" Text="Mostrar profesores" CssClass="contact1-form-btn" OnClick="botonMostrarProfesores_Click" />

                    </div>

                </div>
            </div>
        </div>
    </div>


    <div class="modal fade high" id="modalProfesores" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog modal-lg modal-top" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title w-100">Lista de profesores</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <asp:UpdatePanel runat="server" ChildrenAsTriggers="true" UpdateMode="Conditional">
                        <ContentTemplate>
                            <asp:GridView ID="gridProfesores" runat="server" CellPadding="4" GridLines="Horizontal" Width="100%" BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px">
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
