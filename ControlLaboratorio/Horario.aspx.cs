using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ControlLaboratorio {
    public partial class Horario : System.Web.UI.Page {

        public static ClaseLogicaNegocio reglasNegocio = new ClaseLogicaNegocio();

        protected void Page_Load(object sender, EventArgs e) {
            if (Session["rol"] != null) {
                if (Session["rol"].Equals("profesor")) {
                    Response.Redirect("HorarioProfesor.aspx");
                }
            }
        }


        [WebMethod]
        public static List<EventosCalendario> ObtenerEventosCalendario() {
            //ClaseLogicaNegocio reglasNegocio = new ClaseLogicaNegocio();
            string mensaje = "";
            DataTable dt = reglasNegocio.ObtenerEventos(ref mensaje);

            return dt.AsEnumerable().Select(datarow =>
            new EventosCalendario() {
                title = Convert.ToString(datarow["title"]),
                dow = Convert.ToString(datarow["dow"]),
                start = Convert.ToString(datarow["start"]),
                end = Convert.ToString(datarow["end"]),
                profe = Convert.ToString(datarow["profe"]),
                grupo = Convert.ToString(datarow["grupo"]),
                lugar = Convert.ToString(datarow["lugar"])
            }
            ).ToList();
        }

        [WebMethod]
        public static List<Asignacion> ObtenerAsignaciones() {
            //ClaseLogicaNegocio reglasNegocio = new ClaseLogicaNegocio();
            string mensaje = "";
            DataTable dt = reglasNegocio.ListaAsignacionGrupo(ref mensaje);

            return dt.AsEnumerable().Select(datarow =>
            new Asignacion() {
                idAsignacion = Convert.ToInt32(datarow["id_asignacion"]),
                grupo = Convert.ToString(datarow["grupo"]),
                materia = Convert.ToString(datarow["materia"]),
                profesor = Convert.ToString(datarow["profesor"]),
            }
            ).ToList();
        }

        [WebMethod]
        public static List<Lugar> ObtenerLugares() {
            //ClaseLogicaNegocio reglasNegocio = new ClaseLogicaNegocio();
            string mensaje = "";
            DataTable dt = reglasNegocio.ListaLugar(ref mensaje);

            return dt.AsEnumerable().Select(datarow =>
            new Lugar() {
                idLugar = Convert.ToInt32(datarow["id_lug"]),
                lugar = Convert.ToString(datarow["lugar"]),
            }
            ).ToList();
        }

        [WebMethod]
        public static void GuardarHorario(EventoGuardar evento) {
            //ClaseLogicaNegocio reglasNegocio = new ClaseLogicaNegocio();

            string mensaje = "";

            reglasNegocio.InsertarHorarioGrupo(evento.idAsignacion,evento.dia,evento.lugar, evento.hinicio, evento.hfin,ref mensaje);
        }

        [WebMethod]
        public static void GuardarLugar(string edificio, string salon) {
            //ClaseLogicaNegocio reglasNegocio = new ClaseLogicaNegocio();

            string mensaje = "";

            reglasNegocio.InsertarLugar(edificio, salon, ref mensaje);
        }
        public class EventosCalendario {
            public string title { get; set; }
            public string dow { get; set; }
            public string start { get; set; }
            public string end { get; set; }
            public string grupo { get; set; }
            public string profe { get; set; }
            public string lugar { get; set; }

        }

        public class Asignacion{
            public int idAsignacion { get; set; }
            public string grupo { get; set; }
            public string materia { get; set; }
            public string profesor { get; set; }

        }

        public class Lugar {
            public int idLugar { get; set; }
            public string lugar { get; set; }

        }

        public class EventoGuardar {
            public int idAsignacion { get; set; }
            public string dia { get; set; }
            public int lugar { get; set; }
            public string hinicio { get; set; }
            public string hfin { get; set; }
        }

    }
}