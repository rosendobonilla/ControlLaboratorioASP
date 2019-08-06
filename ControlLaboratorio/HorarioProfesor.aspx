<%@ Page Title="" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="HorarioProfesor.aspx.cs" Inherits="ControlLaboratorio.HorarioProfesor" %>

<%@ MasterType VirtualPath="~/Principal.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">


    <link href="design/fullcalendar/fullcalendar.min.css" rel='stylesheet' />
    <link href="design/estilos.css" rel="stylesheet" />
    <link href="design/fullcalendar/fullcalendar.print.min.css" rel='stylesheet' media='print' />
    <script src="design/fullcalendar/lib/moment.min.js"></script>
    <script src="design/fullcalendar/fullcalendar.min.js"></script>
    <script src="design/fullcalendar/locale-all.js"></script>
    <script>
        var dia = new Date().getDay();

        function cargarTiposReporte() {
            $.ajax({
                type: "POST",
                contentType: "application/json",
                url: "HorarioProfesor.aspx/ObtenerTiposReporte",
                dataType: "json",
                success: function (data) {
                    var $select = $('#listaTiposReporte');
                    $select.find('option').remove();

                    $.map(data.d, function (item, i) {
                        $select.append('<option value=' + item.IdReporte + '>' + item.Nombre + '</option>');
                    });
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    console.log("Error: " + textStatus);
                }
            });
        }

        $(document).ready(function () {


            $.ajax({
                type: "POST",
                contentType: "application/json",
                url: "HorarioProfesor.aspx/ObtenerHorarioProfesor",
                dataType: "json",
                success: function (data) {
                    $('#calendar').empty();
                    $('#calendar').fullCalendar({
                        header: {
                            left: 'prev,next',
                            center: 'title',
                            right: 'month,agendaWeek,agendaDay'
                        },
                        allDaySlot: false,
                        weekNumbers: false,
                        locale: 'es',
                        defaultView: 'agendaWeek',
                        defaultDate: new Date(),
                        height: 700,
                        allDayText: 'Events',
                        selectable: true,
                        overflow: 'auto',
                        firstDay: 1,
                        views: {
                            week: {
                                hiddenDays: [6, 0],
                                minTime: '07:00:00',
                                maxTime: '21:00:00',
                            },
                        },
                        eventClick: function (evento, jsEvent, view) {
                            //var dia = new Date().getDay();
                            $("#labelFecha").html(moment(new Date()).format('YYYY-MM-DD'));

                            $.ajax({
                                type: "POST",
                                contentType: "application/json",
                                url: "HorarioProfesor.aspx/VerificarAsistenciaRepetida",
                                dataType: "json",
                                data: "{'horario': '" + evento.idHorario + "', 'fecha':'" + $("#labelFecha").text() + "'}",
                                success: function (data) {

                                    if (data.d == 0) {
                                        console.log("asistencia disponible");

                                        var hora, horaEntre, horaAntes, horaDespues;
                                        hora = moment();

                                        horaEntre = hora.isBetween(moment(evento.start.format("HH:mm"), "hh:mm"), moment(evento.end.format("HH:mm"), "hh:mm").add(1, 'hours'));
                                        horaAntes = hora.isBefore(moment(evento.start.format("HH:mm"), "hh:mm"));
                                        horaDespues = hora.isAfter(moment(evento.end.format("HH:mm"), "hh:mm").add(1, 'hours'));

                                        console.log(moment().format("hh:mm"));
                                        console.log(horaEntre);

                                        //horaEntre = hora.isBetween(moment("18:10", "HH:mm"), moment("19:00", "HH:mm").add(1, 'hours'));

                                        //evento.diaSemana == dia && horaEntre
                                        if (evento.diaSemana == dia && horaEntre) {
                                            //alert("Puede registrar asistencia. inicio: " + evento.start.format("HH:mm") + " Fin: " + evento.end.format("HH:mm"));
                                            $("#labelFecha").data("idHorario", evento.idHorario);

                                            $(function () {
                                                $('[data-toggle="popover"]').popover({
                                                    container: 'body',
                                                    title: 'Agregar categoría',
                                                    html: true,
                                                    placement: 'right',
                                                    sanitize: false,
                                                    content: function () {
                                                        return $("#PopoverContent").html();
                                                    }
                                                });
                                            });

                                            cargarTiposReporte();


                                            $(document).off().on("click", "#botonGuardarCategoria", function () {

                                                var categoria = $(".popover #inputCategoria").val();

                                                if (categoria != "") {
                                                    $.ajax({
                                                        type: "POST",
                                                        url: "HorarioProfesor.aspx/GuardarCategoriaReporte",
                                                        data: "{'categoria': '" + categoria + "'}",
                                                        contentType: "application/json; charset=utf-8",
                                                        dataType: "json",
                                                        success: OnSuccess,
                                                        error: OnErrorCall
                                                    });

                                                    function OnSuccess(response) {
                                                        console.log("Registro correcto");
                                                        cargarTiposReporte();
                                                        $('#botonAbrirPopoverCategoria').popover('hide');
                                                    }

                                                    function OnErrorCall(xhr, textStatus, errorThrown) {
                                                        var err = eval("(" + xhr.responseText + ")");
                                                        alert(err.Message);
                                                    }
                                                }
                                            });





                                            $("#botonGuardarAsistencia").off().click(function () {

                                                if ($('#botonGuardarAsistencia').val() == "Guardar asistencia") {
                                                    if ($("#inputAlumnos").val() != "") {

                                                        var nuevaAsistencia = {
                                                            horarioGrupo: evento.idHorario,
                                                            fecha: $("#labelFecha").text(),
                                                            noAlumnos: $("#inputAlumnos").val(),
                                                            falta: 0,
                                                            nota: $("#inputNota").val()
                                                        };



                                                        var asistenciaJson = JSON.stringify({ asistencia: nuevaAsistencia });

                                                        $.ajax({
                                                            type: "POST",
                                                            url: "HorarioProfesor.aspx/GuardarAsistencia",
                                                            data: asistenciaJson,
                                                            contentType: "application/json; charset=utf-8",
                                                            dataType: "json",
                                                            success: OnSuccess,
                                                            error: OnErrorCall
                                                        });

                                                        function OnSuccess(response) {
                                                            $('#reporte-tab').removeClass('disabled'); //removeClass
                                                            $('#myTab a[href="#reporte"]').tab('show');
                                                            $('#asistencia-tab').addClass('disabled'); //removeClass
                                                            $("#botonGuardarAsistencia").prop('value', 'Guardar reporte');
                                                            $('#mensajeAccion').html("Asistencia registrada.");
                                                        }

                                                        function OnErrorCall(xhr, textStatus, errorThrown) {
                                                            var err = eval("(" + xhr.responseText + ")");
                                                            //alert(err.Message);
                                                            //console.log("Error: " + textStatus)
                                                            mensaje = err.Message;
                                                        }
                                                    }
                                                    else {
                                                        alert("Ingrese el número de alumnos.");
                                                    }

                                                }
                                                else if ($('#botonGuardarAsistencia').val() == "Guardar reporte") {
                                                    console.log("Ejecutar registro de reporte");

                                                    var nuevoReporte = {
                                                        categoria: $("#listaTiposReporte option:selected").val(),
                                                        descripcion: $("#inputDescripcionReporte").val(),
                                                        nota: $("#inputNotaReporte").val()
                                                    };

                                                    var reporteJson = JSON.stringify({ reporte: nuevoReporte });

                                                    $.ajax({
                                                        type: "POST",
                                                        url: "HorarioProfesor.aspx/GuardarReporte",
                                                        data: reporteJson,
                                                        contentType: "application/json; charset=utf-8",
                                                        dataType: "json",
                                                        success: OnSuccess,
                                                        error: OnErrorCall
                                                    });

                                                    function OnSuccess(response) {
                                                        $('#myTab a[href="#asistencia"]').tab('show');
                                                        $('#asistencia-tab').removeClass('disabled'); //removeClass
                                                        $('#reporte-tab').addClass('disabled'); //removeClass
                                                        $("#botonGuardarAsistencia").prop('value', 'Guardar asistencia');
                                                        $('#mensajeAccion').html("Reporte registrado.");
                                                        $('#modalAsistencia').modal('hide');

                                                    }

                                                    function OnErrorCall(xhr, textStatus, errorThrown) {
                                                        var err = eval("(" + xhr.responseText + ")");
                                                        //alert(err.Message);
                                                        //console.log("Error: " + textStatus)
                                                        mensaje = err.Message;
                                                    }



                                                }


                                            });

                                            $('#modalAsistencia').modal('show');


                                        }
                                        else if (dia == evento.diaSemana && horaAntes) {
                                            $("#mensajeModal").html("Aún no puede registrar la asistencia para esta clase.");
                                            $('#modalNoAsistencia').modal('show');
                                        }
                                        else if (dia == evento.diaSemana && horaDespues) {
                                            $("#mensajeModal").html("Ya no puede registrar asistencia para esta clase. Se registrará como falta.");

                                            var nuevaAsistencia = {
                                                horarioGrupo: evento.idHorario,
                                                fecha: $("#labelFecha").text(),
                                                noAlumnos: 0,
                                                falta: 1,
                                                nota: ''
                                            };



                                            var asistenciaJson = JSON.stringify({ asistencia: nuevaAsistencia });

                                            $.ajax({
                                                type: "POST",
                                                url: "HorarioProfesor.aspx/GuardarAsistencia",
                                                data: asistenciaJson,
                                                contentType: "application/json; charset=utf-8",
                                                dataType: "json",
                                                success: OnSuccess,
                                                error: OnErrorCall
                                            });

                                            function OnSuccess(response) {
                                                $('#modalNoAsistencia').modal('show');
                                            }

                                            function OnErrorCall(xhr, textStatus, errorThrown) {
                                                var err = eval("(" + xhr.responseText + ")");
                                                //alert(err.Message);
                                                //console.log("Error: " + textStatus)
                                                mensaje = err.Message;
                                            }

                                        }
                                        //if (evento.lugar == 'Lugar no definido') {
                                        //    $("#botonGuardarHorario").click(function () {
                                        //        var nuevoEvento = {
                                        //            idAsignacion: $("#labelMateria").data("idAsignacion"),
                                        //            dia: $("#labelMateria").data("diaSemana"),
                                        //            lugar: $("#listaLugares option:selected").val(),
                                        //            hinicio: $("#labelHoraInicio").text(),
                                        //            hfin: $("#labelHoraFin").text()
                                        //        };

                                        //        console.log("Horario a guardar:  " + JSON.stringify(nuevoEvento));

                                        //        var horarioJson = JSON.stringify({ evento: nuevoEvento });

                                        //        $.ajax({
                                        //            type: "POST",
                                        //            url: "Horario.aspx/GuardarHorario",
                                        //            data: horarioJson,
                                        //            contentType: "application/json; charset=utf-8",
                                        //            dataType: "json",
                                        //            success: OnSuccess,
                                        //            error: OnErrorCall
                                        //        });

                                        //        function OnSuccess(response) {
                                        //            console.log("Registro correcto");
                                        //            $('#modalEventoClic').modal('hide');
                                        //            location.reload();
                                        //        }

                                        //        function OnErrorCall(xhr, textStatus, errorThrown) {
                                        //            var err = eval("(" + xhr.responseText + ")");
                                        //            alert(err.Message);
                                        //            //console.log("Error: " + textStatus)

                                        //        }

                                        //    });

                                        //    $('#modalEventoClic').modal('show');
                                        //}

                                    }
                                    else {
                                        $('#mensajeModal').html("Esta asistencia ya ha sido registrada.");
                                        $('#modalNoAsistencia').modal('show');
                                    }


                                },
                                error: function (XMLHttpRequest, textStatus, errorThrown) {
                                    console.log("Error: " + textStatus);
                                }
                            });
                        },
                        eventLimit: 5, //Establecemos el limite de 5 eventos por día, funciona solo en la vista month
                        eventTextColor: 'black',
                        events: $.map(data.d, function (item, i) {
                            //Mapeamos los datos obtenidos de la base de datos al objeto evento
                            var event = new Object();
                            event.title = item.title;
                            event.start = item.start;
                            event.end = item.end;
                            event.grupo = item.grupo;
                            event.profe = item.profe;
                            event.dow = "[" + item.dow + "]" //Construimos el día de la semana donde se colocara el evento, en bd se almacena el dia como numero no como string
                            event.lugar = item.lugar;
                            if (dia == item.dow) {
                                event.className = "bg-danger";
                            }
                            else { event.className = "bg-info"; }
                            event.diaSemana = item.dow;
                            event.idHorario = item.idHorario;
                            return event;
                        }),
                        eventRender: function (event, element) {
                            element.append(
                                '<div class="event-details">' +
                                '<div class="text-dark">' + event.profe + ' </div>' +
                                '<div class="text-dark">' + event.grupo + ' - ' + event.lugar + '</div>' +
                                '</div >'
                            )
                        },
                    });
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    console.log("error: " + textStatus);
                }
            });





        });

    </script>

    <style>
        #calendar {
            max-width: 1200px;
            margin: 100px auto;
            height: 100%;
            padding: 20px;
            border-radius: 20px;
            background-color: white;
        }
    </style>


</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:Button CssClass="btn btn-danger btn-sm ml-3 mt-3" Text="faltas" runat="server" ID="botonFaltas" OnClick="botonFaltas_Click" />

    <h2 class="mt-5 mx-auto text-center">Horario de clases </h2>

    <div id="calendar"></div>


    <div class="modal fade" id="modalNoAsistencia" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle"
        aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header bg-danger" id="modalHeaderAsistencia">
                    <h5 class="modal-title text-white" id="exampleModalLongTitle">Registrar asistencia</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div id="mensajeModal" class="text-dark">
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" id="botonCancelar" class="btn btn-secondary" data-dismiss="modal">Aceptar</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="modalAsistencia" role="dialog" aria-labelledby="exampleModalCenterTitle"
        aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header bg-success" id="modalHeaderMensajes">
                    <h5 class="modal-title text-white" id="modalEjemplo">Guardar horario</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div id="mensajeModalAsistencia" class="text-dark">

                        <div id="labelFecha" style="display: none;" class="info-horario text-center font-weight-bolder"></div>


                        <ul class="nav nav-tabs" id="myTab" role="tablist">
                            <li class="nav-item">
                                <a class="nav-link active" id="asistencia-tab" data-toggle="tab" href="#asistencia" role="tab" aria-controls="asistencia" aria-selected="true">Asistencia</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link disabled" id="reporte-tab" data-toggle="tab" href="#reporte" role="tab" aria-controls="reporte" aria-selected="false">Reporte</a>
                            </li>
                        </ul>
                        <div class="tab-content" id="myTabContent">
                            <div class="tab-pane fade show active" id="asistencia" role="tabpanel" aria-labelledby="asistencia-tab">
                                <br />
                                <input id="inputAlumnos" type="text" name="alumnos" class="form-control mb-2" placeholder="Número de alumnos" value="" />
                                <input id="inputNota" type="text" class="form-control" placeholder="Nota" name="nota" value="" />
                            </div>
                            <div class="tab-pane fade" id="reporte" role="tabpanel" aria-labelledby="reporte-tab">
                                <br />
                                <span class="mt-2">Seleccione la categoría del reporte</span>
                                <br />
                                <div class="input-group">
                                    <select id="listaTiposReporte" class="form-control">
                                        <option value="value">text</option>
                                    </select>
                                    <div class="input-group-append" id="btn">
                                        <button id="botonAbrirPopoverCategoria" class="btn btn-outline-secondary btn-sm" type="button" data-toggle="popover">
                                            Nueva categoría
                                        </button>
                                    </div>
                                </div>
                                <input id="inputDescripcionReporte" type="text" name="descripcion" class="form-control my-2" placeholder="Descripción" value="" />
                                <input id="inputNotaReporte" type="text" class="form-control" placeholder="Nota" name="nota" value="" />
                            </div>
                        </div>

                    </div>
                </div>
                <div class="modal-footer">
                    <div id="mensajeAccion"></div>
                    <input type="button" id="botonGuardarAsistencia" class="btn btn-primary" value="Guardar asistencia" />
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
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

    <div class="modal fade high" id="modalFaltas" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog modal-lg modal-top" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title w-100">Faltas</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                            <asp:GridView ID="gridFaltas" runat="server" CellPadding="4" GridLines="Horizontal" Width="100%" BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px">
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
                    <asp:Label ID="labelMensajesGrid" runat="server" />


                </div>
            </div>
        </div>
    </div>


</asp:Content>
