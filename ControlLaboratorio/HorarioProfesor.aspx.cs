using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ControlLaboratorio {
    public partial class HorarioProfesor : System.Web.UI.Page {
        public static int IdProfesor { get; set; }
        public static ClaseLogicaNegocio reglasNegocio = new ClaseLogicaNegocio();

        protected void Page_Load(object sender, EventArgs e) {
            if (Session["id_usuario"] != null && Session["rol"] != null) {
                if (Session["rol"].Equals("profesor")) {
                    this.Master.BotonMenu.Visible = false;
                }
                IdProfesor = Convert.ToInt32(Session["id_usuario"]);
            }
            if (!this.IsPostBack) {
                LlenarGrid(IdProfesor);
            }

        }

        public void LlenarGrid(int idProfesor) {
            string mensaje = "";
            gridFaltas.DataSource = reglasNegocio.ObtenerNoFaltas(idProfesor, ref mensaje);
            gridFaltas.DataBind();
            botonFaltas.Text = gridFaltas.Rows.Count + " faltas";
        }

        [WebMethod]
        public static List<EventosCalendario> ObtenerHorarioProfesor() {
            string mensaje = "";

            DataTable dt = reglasNegocio.ObtenerHorarioProfesor(IdProfesor,ref mensaje);

            return dt.AsEnumerable().Select(datarow =>
            new EventosCalendario() {
                title = Convert.ToString(datarow["title"]),
                dow = Convert.ToString(datarow["dow"]),
                start = Convert.ToString(datarow["start"]),
                end = Convert.ToString(datarow["end"]),
                profe = Convert.ToString(datarow["profe"]),
                grupo = Convert.ToString(datarow["grupo"]),
                lugar = Convert.ToString(datarow["lugar"]),
                idHorario = Convert.ToInt32(datarow["id_horario"]),
            }
            ).ToList();
        }

        [WebMethod]
        public static int VerificarAsistenciaRepetida(int horario, string fecha) {
            string mensaje = "";

            return reglasNegocio.VerificarAsistenciaRepetida(horario, Convert.ToDateTime(fecha), ref mensaje);
        }

        [WebMethod]
        public static void GuardarAsistencia(Asistencia asistencia) {

            string mensaje = "";

            reglasNegocio.InsertarAsistencia(asistencia.horarioGrupo, asistencia.fecha, asistencia.noAlumnos, asistencia.falta, asistencia.nota, ref mensaje);
        }

        [WebMethod]
        public static void GuardarReporte(Reporte reporte) {

            string mensaje = "";

            reglasNegocio.InsertarReporte(reporte.Categoria, reporte.Descripcion, reporte.Nota, ref mensaje);
        }

        [WebMethod]
        public static List<TipoReporte> ObtenerTiposReporte() {
            string mensaje = "";
            DataTable dt = reglasNegocio.ListaTiposReporte(ref mensaje);

            return dt.AsEnumerable().Select(datarow =>
            new TipoReporte() {
                IdReporte = Convert.ToInt32(datarow["id_categoria"]),
                Nombre = Convert.ToString(datarow["nombre"]),
            }
            ).ToList();
        }

        [WebMethod]
        public static void GuardarCategoriaReporte(string categoria) {
            string mensaje = "";
            reglasNegocio.InsertarTipoReporte(categoria, ref mensaje);
        }

        public class EventosCalendario {
            public string title { get; set; }
            public string dow { get; set; }
            public string start { get; set; }
            public string end { get; set; }
            public string grupo { get; set; }
            public string profe { get; set; }
            public string lugar { get; set; }
            public int idHorario { get; set; }

        }

        public class Asistencia {

            public int horarioGrupo { get; set; }
            public DateTime fecha { get; set; }
            public int noAlumnos { get; set; }
            public int falta { get; set; }
            public string nota { get; set; }

        }

        public class TipoReporte {
            public int IdReporte { get; set; }
            public string Nombre { get; set; }
        }

        public class Reporte {
            public int Categoria { get; set; }
            public string Descripcion { get; set; }
            public string Nota { get; set; }

        }

        protected void botonFaltas_Click(object sender, EventArgs e) {
            ClientScript.RegisterStartupScript(this.GetType(), "Popup", "$('#modalFaltas').modal('show')", true);
        }
    }
}