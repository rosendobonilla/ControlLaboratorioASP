<%@ Page Title="" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="Horario.aspx.cs" Inherits="ControlLaboratorio.Horario" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link href="design/fullcalendar/fullcalendar.min.css" rel='stylesheet' />
    <link href="design/fullcalendar/fullcalendar.print.min.css" rel='stylesheet' media='print' />
    <script src="design/fullcalendar/lib/moment.min.js"></script>
    <script src="design/fullcalendar/fullcalendar.min.js"></script>
    <script src="design/fullcalendar/locale-all.js"></script>
    <script>

        function cargarLugares() {
            $.ajax({
                type: "POST",
                contentType: "application/json",
                url: "Horario.aspx/ObtenerLugares",
                dataType: "json",
                success: function (data) {
                    var $select = $('#listaLugares');
                    $select.find('option').remove();

                    $.map(data.d, function (item, i) {
                        $select.append('<option value=' + item.idLugar + '>' + item.lugar + '</option>');
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
                url: "Horario.aspx/ObtenerAsignaciones",
                dataType: "json",
                success: function (data) {

                    //Mapear cada registro de la base de datos
                    $.map(data.d, function (item, i) {
                        const divEventos = document.getElementById("eventosArrastrar");
                        divEventos.innerHTML += "<div class='evento my-2 w-50 text-center' id='" + item.idAsignacion + "' data-materia='" + item.materia + "' data-profe='" + item.profesor + "' data-grupo='" + item.grupo + "'>" + item.materia + " - " + item.grupo + "</br>" + item.profesor + "</div>"
                    });

                    //Hacer los elementos arrastrables una vez que se cargaron de la base de datos
                    $('#eventosArrastrar .evento').each(function () {

                        $(this).data('event', {
                            id: $(this).attr('id'),
                            title: $.trim($(this).data('materia')),
                            profe: $.trim($(this).data('profe')),
                            grupo: $.trim($(this).data('grupo')),
                            lugar: 'Lugar no definido',
                            stick: true,
                            className: 'bg-warning'
                        });

                        $(this).draggable({
                            zIndex: 999,
                            revert: true,
                            revertDuration: 0
                        }).data('duration', '02:00'); //data duration sirve para especificar la duracion por defecto, necesario para click puesto que sino se define, la fecha aparece como null o undefined

                    });
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    console.log("Error: " + textStatus);
                }
            });

            var isEventOverDiv = function (x, y) {

                var external_events = $('#eliminar');
                var offset = external_events.offset();
                offset.right = external_events.width() + offset.left;
                offset.bottom = external_events.height() + offset.top;

                // Compare
                if (x >= offset.left
                    && y >= offset.top
                    && x <= offset.right
                    && y <= offset.bottom) { return true; }
                return false;

            }


            $.ajax({
                type: "POST",
                contentType: "application/json",
                url: "Horario.aspx/ObtenerEventosCalendario",
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
                        editable: true,
                        firstDay: 1,
                        droppable: true,
                        dragRevertDuration: 0,
                        views: {
                            week: {
                                hiddenDays: [6, 0],
                                minTime: '07:00:00',
                                maxTime: '21:00:00',
                            },
                        },
                        eventClick: function (evento, jsEvent, view) {

                            if (evento.lugar == 'Lugar no definido') {
                                //alert('Materia: ' + evento.title + ' Grupo: ' + evento.grupo + ' Profe: ' + evento.profe + ' Lugar: ' + evento.lugar + " Inicio hora:" + evento.start.format("HH:mm") + " Fin hora:" + evento.end.format("HH:mm"));
                                var dia;
                                switch (evento.start.format("dddd")) {
                                    case "lunes": dia = '1';
                                        break;
                                    case "martes": dia = '2';
                                        break;
                                    case "miércoles": dia = '3';
                                        break;
                                    case "jueves": dia = '4';
                                        break;
                                    case "viernes": dia = '5';
                                        break;
                                    default: dia = '0';
                                }
                                // change the border color just for fun
                                //$(this).css('border-color', 'red');
                                $("#labelMateria").html("Materia: " + evento.title);
                                $("#labelMateria").data("idAsignacion", evento.id);
                                $("#labelMateria").data("diaSemana", dia);
                                $("#labelProfe").html("Profesor: " + evento.profe);
                                $("#labelGrupo").html("Grupo: " + evento.grupo);
                                $("#labelHoraInicio").html(evento.start.format("HH:mm"));
                                $("#labelHoraFin").html(evento.end.format("HH:mm"));

                                $(function () {
                                    $('[data-toggle="popover"]').popover({
                                        container: 'body',
                                        title: 'Agregar lugar',
                                        html: true,
                                        placement: 'top',
                                        sanitize: false,
                                        content: function () {
                                            return $("#PopoverContent").html();
                                        }
                                    });
                                });

                                cargarLugares();

                                $(document).off().on("click", "#botonGuardarLugar", function () {

                                    var edificio = $(".popover #inputEdificio").val();
                                    var salon = $(".popover #inputSalon").val();

                                    if (edificio != "" && salon != "") {
                                        $.ajax({
                                            type: "POST",
                                            url: "Horario.aspx/GuardarLugar",
                                            data: "{'edificio': '" + edificio + "', 'salon':'" + salon + "'}",
                                            contentType: "application/json; charset=utf-8",
                                            dataType: "json",
                                            success: OnSuccess,
                                            error: OnErrorCall
                                        });

                                        function OnSuccess(response) {
                                            console.log("Registro correcto");
                                            cargarLugares();
                                            $('#botonAbrirPopoverLugar').popover('hide');
                                        }

                                        function OnErrorCall(xhr, textStatus, errorThrown) {
                                            var err = eval("(" + xhr.responseText + ")");
                                            alert(err.Message);
                                        }
                                    }

                                });

                                $("#botonGuardarHorario").off().click(function () {
                                    var nuevoEvento = {
                                        idAsignacion: $("#labelMateria").data("idAsignacion"),
                                        dia: $("#labelMateria").data("diaSemana"),
                                        lugar: $("#listaLugares option:selected").val(),
                                        hinicio: $("#labelHoraInicio").text(),
                                        hfin: $("#labelHoraFin").text()
                                    };

                                    console.log("Horario a guardar:  " + JSON.stringify(nuevoEvento));

                                    var horarioJson = JSON.stringify({ evento: nuevoEvento });

                                    $.ajax({
                                        type: "POST",
                                        url: "Horario.aspx/GuardarHorario",
                                        data: horarioJson,
                                        contentType: "application/json; charset=utf-8",
                                        dataType: "json",
                                        success: OnSuccess,
                                        error: OnErrorCall
                                    });

                                    function OnSuccess(response) {
                                        console.log("Registro correcto");
                                        $('#modalEventoClic').modal('hide');
                                        location.reload();
                                    }

                                    function OnErrorCall(xhr, textStatus, errorThrown) {
                                        var err = eval("(" + xhr.responseText + ")");
                                        alert(err.Message);
                                    }

                                });

                                $('#modalEventoClic').modal('show');
                            }
                        },
                        eventDrop: function (event) {
                            //inner column movement drop so get start and call the ajax function......
                            console.log("Inicio hora:" + event.start.format("HH:mm"));
                            console.log("dia: " + event.start.format("dddd"));
                            console.log("Id evento" + event.id);
                            var defaultDuration = moment.duration($('#calendar').fullCalendar('option', 'defaultTimedEventDuration'));
                            var end = event.end || event.start.clone().add(defaultDuration);
                            console.log('end is ' + end.format());

                            //alert(event.title + " was dropped on " + event.start.format());

                        },
                        eventResize: function (event) {
                            console.log("Id evento" + event.id);
                            console.log("dia: " + event.start.format("dddd"));
                            console.log("Hora inicio: " + event.start.format("HH:mm") + "Hora fin: " + event.end.format("HH:mm"));
                        },
                        drop: function (date) {

                            //Call when you drop any red/green/blue class to the week table.....first time runs only.....
                            console.log("Soltado");
                            console.log("dia: " + date.format("dddd"));
                            console.log("Hora inicio: " + date.format("HH:mm"));
                            console.log(this.id);
                            //var defaultDuration = moment.duration($('#calendar').fullCalendar('option', 'defaultTimedEventDuration'));
                            //var end = date.clone().add(defaultDuration); // on drop we only have date given to us
                            //console.log('end is ' + end.format("HH:mm"));

                            // is the "remove after drop" checkbox checked?
                            //if ($('#drop-remove').is(':checked')) {
                            //    $(this).remove();
                            //}
                        },
                        //eventReceive: function (evento) {
                        //    alert('Materia: ' + event.title + ' Profe: ' + event.profe + ' Lugar: ' + event.lugar + " Inicio hora:" + event.start.format() + " Fin hora:" + event.end.format());
                        //},
                        //eventColor: '#ffda75',
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
                            event.className = "bg-info";
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
                        eventDragStop: function (event, jsEvent, ui, view) {

                            if (isEventOverDiv(jsEvent.clientX, jsEvent.clientY) && event.lugar == 'Lugar no definido') {
                                $('#calendar').fullCalendar('removeEvents', event._id);
                                //if ($('#drop-remove').is(':checked')) {
                                //    var el = $("<div class='evento my-2 w-50 text-center'>").appendTo('#eventosArrastrar').text(event.title);
                                //    el.draggable({
                                //        zIndex: 999,
                                //        revert: true,
                                //        revertDuration: 0
                                //    });
                                //    el.attr('id', event.id)
                                //    el.data('materia', event.materia);
                                //    el.data('profe', event.profe);
                                //    el.data('grupo', event.grupo);
                                //    el.data('lugar', null);

                                //}

                            }
                        }
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
    <div id='wrap' class="mx-auto mt-5 w-75">
        <div class="row">
            <div id="eventosDisponibles" class="col-8 center-block">
                <div id="listaEventos" class="">
                    <div id="eventosArrastrar" class="">
                        <h4 class="mb-3">Asignaciones de grupo disponibles</h4>

                    </div>
                    <%--                    <div class="mt-2">
                        <input type='checkbox' id='drop-remove' />
                        <label for='drop-remove'>Quitar de la lista al agregar al calendario</label>
                    </div>--%>
                </div>
            </div>

            <div class="col-3 eliminar text-center" id="eliminar">
                <span class="align-middle h6">Eliminar de calendario</span>
            </div>
        </div>
    </div>

    <div id="calendar"></div>

    <%--    quite tabindex="-1" para que el popover funcione --%>

    <div class="modal fade" id="modalEventoClic" role="dialog" aria-labelledby="exampleModalCenterTitle"
        aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header bg-success" id="modalHeaderMensajes">
                    <h5 class="modal-title text-white" id="exampleModalLongTitle">Guardar horario</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div id="mensajeModal" class="text-dark">
                        <div id="labelMateria" class="info-horario  text-center font-weight-bolder"></div>
                        <div id="labelProfesor" class="info-horario text-center font-weight-bolder"></div>
                        <div id="labelGrupo" class="info-horario  text-center font-weight-bolder"></div>
                        <div id="labelHoraInicio" class="info-horario  text-center font-weight-bolder"></div>
                        <div id="labelHoraFin" class="info-horario text-center font-weight-bolder"></div>
                        <span>Seleccione el lugar</span>


                        <div class="input-group">
                            <select id="listaLugares" class="form-control">
                                <option value="value">text</option>
                            </select>
                            <div class="input-group-append" id="btn">
                                <button id="botonAbrirPopoverLugar" class="btn btn-outline-secondary btn-sm" type="button" data-toggle="popover">
                                    Nuevo lugar
                                </button>
                            </div>
                        </div>



                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" id="botonGuardarHorario" class="btn btn-primary">Guardar</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                </div>
            </div>
        </div>
    </div>

    <div id="PopoverContent" style="display:none;">
        <input type="text" name="name" placeholder="Edificio" id="inputEdificio" class="form-control" />
        <div class="input-group">
            <input type="text" name="name" placeholder="Salón" class="form-control" id="inputSalon" />
            <div class="input-group-append" id="button-addon1">
                <input id="botonGuardarLugar" class="btn btn-outline-primary" type="button" value="Guardar" />
            </div>
        </div>
    </div>


</asp:Content>
