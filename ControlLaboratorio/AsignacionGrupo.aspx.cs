using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ControlLaboratorio {
    public partial class AsignacionGrupo : System.Web.UI.Page {

        ClaseLogicaNegocio reglasNegocio = new ClaseLogicaNegocio();
        protected void Page_Load(object sender, EventArgs e) {
            if(Session["rol"] != null) {
                if (Session["rol"].Equals("profesor")) {
                    Response.Redirect("HorarioProfesor.aspx");
                }
            }

            if (!this.IsPostBack) {
                CargarCuatrimestres();
                CargarGrupos();
                CargarMaterias();
                CargarProfesores();
            }
        }

        public void CargarCuatrimestres() {
            string mensaje = "";
            List<string> ListTmp = null;
            List<int> idsTipos = new List<int>();

            ListTmp = reglasNegocio.CargarCuatrimestres(ref mensaje, ref idsTipos);

            dropListCuatrimestre.Items.Clear();
            for (int i = 0; i < ListTmp.Count; i++) {
                dropListCuatrimestre.Items.Add(new ListItem(ListTmp[i].ToString(), idsTipos[i].ToString()));
            }
        }

        public void CargarGrupos() {
            string mensaje = "";
            List<string> ListTmp = null;
            List<int> idsTipos = new List<int>();

            ListTmp = reglasNegocio.CargarGrupos(ref mensaje, ref idsTipos);

            dropListGrupo.Items.Clear();
            for (int i = 0; i < ListTmp.Count; i++) {
                dropListGrupo.Items.Add(new ListItem(ListTmp[i].ToString(), idsTipos[i].ToString()));
            }
        }

        public void CargarMaterias() {
            string mensaje = "";
            List<string> ListTmp = null;
            List<int> idsTipos = new List<int>();

            ListTmp = reglasNegocio.CargarMaterias(ref mensaje, ref idsTipos);

            dropListMateria.Items.Clear();
            for (int i = 0; i < ListTmp.Count; i++) {
                dropListMateria.Items.Add(new ListItem(ListTmp[i].ToString(), idsTipos[i].ToString()));
            }
        }

        public void CargarProfesores() {
            string mensaje = "";
            List<string> ListTmp = null;
            List<int> idsTipos = new List<int>();

            ListTmp = reglasNegocio.CargarProfesores(ref mensaje, ref idsTipos);

            dropListProfesor.Items.Clear();
            for (int i = 0; i < ListTmp.Count; i++) {
                dropListProfesor.Items.Add(new ListItem(ListTmp[i].ToString(), idsTipos[i].ToString()));
            }
        }
        protected void botonAgregarAsignacion_Click(object sender, EventArgs e) {
            string mensaje = "";
            reglasNegocio.InsertarAsignacionGrupo(Convert.ToInt32(dropListCuatrimestre.SelectedValue), Convert.ToInt32(dropListGrupo.SelectedValue), Convert.ToInt32(dropListMateria.SelectedValue), Convert.ToInt32(dropListProfesor.SelectedValue), txtEstado.Text, dropListTurno.SelectedValue, txtNota.Text, ref mensaje);
            this.Master.tituloModalMensajesMaster.Attributes.Add("class", "modal-header bg-success text-white");

            txtEstado.Text = "";
            txtNota.Text = "";

            this.Master.mensajeModalMaster.InnerHtml = mensaje;
            ClientScript.RegisterStartupScript(this.GetType(), "Popup", "$('#modalMensajesMaster').modal('show')", true);
        }

        protected void botonMostrarAsignaciones_Click(object sender, EventArgs e) {
            LlenarGrid();
        }
        public void LlenarGrid() {
            string mensaje = "";

            gridAsignaciones.DataSource = reglasNegocio.ListaAsignacionGrupo(ref mensaje);
            gridAsignaciones.DataBind();
            this.Master.mensajeModalMaster.InnerHtml = mensaje;
            ClientScript.RegisterStartupScript(this.GetType(), "Popup", "$('#modalAsignaciones').modal('show')", true);
        }


    }
}