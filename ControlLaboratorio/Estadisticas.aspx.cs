using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ControlLaboratorio {
    public partial class Estadisticas : System.Web.UI.Page {

        ClaseLogicaNegocio reglasNegocio = new ClaseLogicaNegocio();
        protected void Page_Load(object sender, EventArgs e) {
            if (Session["rol"] != null) {
                if (Session["rol"].Equals("profesor")) {
                    Response.Redirect("HorarioProfesor.aspx");
                }
            }
            if (!this.IsPostBack) {
                LlenarGrids(0);
                CargarCuatrimestres();
            }
        }

        public void LlenarGrids(int idCuatrimestre) {
            string mensaje = "";

            gridGruposAsistencia.DataSource = reglasNegocio.ObtenerGruposMasAsistencias(idCuatrimestre, ref mensaje);
            gridGruposAsistencia.DataBind();
            if(gridGruposAsistencia.Rows.Count > 0) gridGruposAsistencia.Rows[0].CssClass = "table-danger";
            gridProfesoresAsistencia.DataSource = reglasNegocio.ObtenerProfesoresMasAsistencias(idCuatrimestre, ref mensaje);
            gridProfesoresAsistencia.DataBind();
            if (gridProfesoresAsistencia.Rows.Count > 0)  gridProfesoresAsistencia.Rows[0].CssClass = "table-success";
            gridFallasMasReportadas.DataSource = reglasNegocio.ObtenerFallasMasReportadas(idCuatrimestre, ref mensaje);
            gridFallasMasReportadas.DataBind();
            if (gridFallasMasReportadas.Rows.Count > 0) gridFallasMasReportadas.Rows[0].CssClass = "table-danger";
            gridLugarMasReportado.DataSource = reglasNegocio.ObtenerEdificiosMasReportados(idCuatrimestre, ref mensaje);
            gridLugarMasReportado.DataBind();
            if (gridLugarMasReportado.Rows.Count > 0) gridLugarMasReportado.Rows[0].CssClass = "table-success";
        }

        public void CargarCuatrimestres() {
            string mensaje = "";
            List<string> ListTmp = null;
            List<int> idsTipos = new List<int>();

            ListTmp = reglasNegocio.CargarCuatrimestres(ref mensaje, ref idsTipos);

            listCuatrimestres.Items.Clear();
            for (int i = 0; i < ListTmp.Count; i++) {
                listCuatrimestres.Items.Add(new ListItem(ListTmp[i].ToString(), idsTipos[i].ToString()));
            }
            listCuatrimestres.Items.Add(new ListItem("Todos los cuatrimestres","0"));
        }

        protected void listCuatrimestres_SelectedIndexChanged(object sender, EventArgs e) {
            LlenarGrids(Convert.ToInt32(listCuatrimestres.SelectedValue));
        }

    }

}