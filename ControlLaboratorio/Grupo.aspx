<%@ Page Title="" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="Grupo.aspx.cs" Inherits="ControlLaboratorio.Grupo" %>

<%@ Register Assembly="System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>

<%@ MasterType VirtualPath="~/Principal.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div id="content">
        <div class="contact1">
            <div class="container-contact1">

                <div class="contact1-form validate-form">
                    <span class="contact1-form-title">Agregar nuevo grupo
                    </span>
                    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
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

                    <label for="dropListLetra" class="left my-1">Letra</label>
                    <asp:DropDownList ID="dropListLetra" CssClass="input1" runat="server" AutoPostBack="True" Height="45px" Width="100%">
                        <asp:ListItem>A</asp:ListItem>
                        <asp:ListItem>B</asp:ListItem>
                        <asp:ListItem>C</asp:ListItem>
                        <asp:ListItem>D</asp:ListItem>
                        <asp:ListItem>E</asp:ListItem>
                        <asp:ListItem>F</asp:ListItem>
                        <asp:ListItem>G</asp:ListItem>
                        <asp:ListItem>H</asp:ListItem>
                        <asp:ListItem>I</asp:ListItem>
                        <asp:ListItem>J</asp:ListItem>
                        <asp:ListItem>K</asp:ListItem>
                        <asp:ListItem>L</asp:ListItem>
                        <asp:ListItem>M</asp:ListItem>
                        <asp:ListItem>N</asp:ListItem>
                        <asp:ListItem>Ñ</asp:ListItem>
                        <asp:ListItem>O</asp:ListItem>
                        <asp:ListItem>P</asp:ListItem>
                        <asp:ListItem>Q</asp:ListItem>
                        <asp:ListItem>R</asp:ListItem>
                        <asp:ListItem>S</asp:ListItem>
                        <asp:ListItem>T</asp:ListItem>
                        <asp:ListItem>U</asp:ListItem>
                        <asp:ListItem>V</asp:ListItem>
                        <asp:ListItem>W</asp:ListItem>
                        <asp:ListItem>X</asp:ListItem>
                        <asp:ListItem>Y</asp:ListItem>
                        <asp:ListItem>Z</asp:ListItem>
                    </asp:DropDownList>

                    <div class="wrap-input1 validate-input mt-3">
                        <asp:TextBox ID="txtNivel" placeholder="Nivel" runat="server" CssClass="input1"></asp:TextBox>
                    </div>



                    <div class="wrap-input1 validate-input mt-3">
                        <asp:TextBox ID="txtNota" placeholder="Nota" runat="server" CssClass="input1"></asp:TextBox>
                    </div>


                    <div class="container-contact1-form-btn mb-2">
                        <asp:Button ID="botonAgregarGrupo" runat="server" Text="Agregar grupo" CssClass="contact1-form-btn" OnClick="botonAgregarGrupo_Click" />

                    </div>

                    <div class="container-contact1-form-btn mb-2">
                        <asp:Button ID="botonMostrarGrupos" data-toggle="modal" data-target="#modalGrupos" runat="server" Text="Mostrar grupos" CssClass="contact1-form-btn" OnClick="botonMostrarGrupos_Click" />

                    </div>

                </div>
            </div>
        </div>
    </div>


    <div class="modal fade high" id="modalObras" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog modal-lg modal-top" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title w-100">Lista de grupos</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <asp:UpdatePanel runat="server" ChildrenAsTriggers="true" UpdateMode="Conditional">
                        <ContentTemplate>
                            <asp:GridView ID="gridGrupos" runat="server" CellPadding="4" GridLines="Horizontal" Width="100%" BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px"
                                DataKeyNames="id_grupo" AutoGenerateColumns="false">
                                <FooterStyle BackColor="White" ForeColor="#333333" />
                                <HeaderStyle BackColor="#336666" Font-Bold="True" ForeColor="White" />
                                <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Center" />
                                <RowStyle BackColor="White" ForeColor="#333333" />
                                <SelectedRowStyle BackColor="#339966" Font-Bold="True" ForeColor="White" />
                                <SortedAscendingCellStyle BackColor="#F7F7F7" />
                                <SortedAscendingHeaderStyle BackColor="#487575" />
                                <SortedDescendingCellStyle BackColor="#E5E5E5" />
                                <SortedDescendingHeaderStyle BackColor="#275353" />

                                <Columns>
                                    <asp:TemplateField HeaderText="Grado">
                                        <ItemTemplate>
                                            <asp:Label Text='<%# Eval("Grado") %>' runat="server" />
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox BackColor="#e1e6ed" BorderColor="Black" ID="txtEditNombre" Text='<%# Eval("Grado") %>' runat="server" />
                                        </EditItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Nivel">
                                        <ItemTemplate>
                                            <asp:Label Text='<%# Eval("Nivel") %>' runat="server" />
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:DropDownList ID="dropListEditEncargado" runat="server">
                                            </asp:DropDownList>
                                        </EditItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Notas">
                                        <ItemTemplate>
                                            <asp:Label Text='<%# Eval("Notas") %>' runat="server" />
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:DropDownList ID="dropListEditDueno" runat="server">
                                            </asp:DropDownList>
                                        </EditItemTemplate>
                                    </asp:TemplateField>

<%--                                    <asp:TemplateField HeaderText="Acciones">
                                        <ItemTemplate>
                                            <asp:ImageButton ImageUrl="~/icons/edit.png" runat="server" CommandName="Edit" ToolTip="Editar registro" />
                                            <asp:ImageButton ImageUrl="~/icons/delete.png" runat="server" CommandName="Delete" ToolTip="Eliminar registro" />
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:ImageButton ImageUrl="~/icons/save.png" runat="server" CommandName="Update" ToolTip="Guardar cambios" />
                                            <asp:ImageButton ImageUrl="~/icons/cancel.png" runat="server" CommandName="Cancel" ToolTip="Cancelar" />
                                        </EditItemTemplate>
                                    </asp:TemplateField>--%>


                                </Columns>

                            </asp:GridView>

                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <asp:Label ID="labelMensajesGrid" runat="server" />


                </div>
            </div>
        </div>
    </div>


</asp:Content>
