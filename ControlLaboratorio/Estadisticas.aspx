<%@ Page Title="" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="Estadisticas.aspx.cs" Inherits="ControlLaboratorio.Estadisticas" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container text-center ">
        <h2 class="mx-auto mt-5 mb-3">Estadísticas</h2>

        <asp:DropDownList runat="server" ID="listCuatrimestres" CssClass="form-control" OnSelectedIndexChanged="listCuatrimestres_SelectedIndexChanged" AutoPostBack="true">
        </asp:DropDownList>

        <div class="row">
            <div class="col-6">
                <h5 class="mx-auto mt-3 mb-3">Grupos que más han asistido al laboratorio</h5>

                <div class="">
                    <asp:GridView runat="server" ID="gridGruposAsistencia"  CssClass="table table-striped table-dark table-hover">
                    </asp:GridView>
                </div>

            </div>
            <div class="col-6">
                <h5 class="mx-auto mt-3 mb-3">Profesores que más horas han asistido al laboratorio</h5>

                <div class="">
                    <asp:GridView runat="server" ID="gridProfesoresAsistencia" CssClass="table table-striped table-dark table-hover">
                    </asp:GridView>
                </div>

            </div>

        </div>

        <div class="row">
            <div class="col-6">
                <h5 class="mx-auto mt-3 mb-3">Fallas más reportadas</h5>

                <div class="">
                    <asp:GridView runat="server" ID="gridFallasMasReportadas" CssClass="table table-striped table-dark table-hover" data-toggle="popover">
                    </asp:GridView>
                </div>
            </div>
            <div class="col-6">
                <h5 class="mx-auto mt-3 mb-3">Lugares más reportados</h5>

                <div class="">
                    <asp:GridView runat="server" ID="gridLugarMasReportado" CssClass="table table-striped table-dark table-hover">
                    </asp:GridView>
                </div>
            </div>

        </div>



    </div>

    <div id="PopoverContent" style="display: none;">
        <div class="input-group">
            <input type="text" name="name" placeholder="Categoría" class="form-control" id="inputCategoria" />
            <div class="input-group-append" id="button-addon1">
                <input id="botonGuardarCategoria" class="btn btn-outline-primary" type="button" value="Guardar" />
            </div>
        </div>
    </div>
</asp:Content>
