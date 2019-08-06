using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ControlLaboratorio {
    public partial class Cuatrimestre : System.Web.UI.Page {

        ClaseLogicaNegocio reglasNegocio = new ClaseLogicaNegocio();

        protected void Page_Load(object sender, EventArgs e) {
            if (Session["rol"] != null) {
                if (Session["rol"].Equals("profesor")) {
                    Response.Redirect("HorarioProfesor.aspx");
                }
            }
        }

        protected void botonFechaInicio_Click(object sender, EventArgs e) {
            ClientScript.RegisterStartupScript(this.GetType(), "Popup", "$('#modalCalendarInicio').modal('show')", true);
        }

        protected void botonFechafin_Click(object sender, EventArgs e) {
            ClientScript.RegisterStartupScript(this.GetType(), "Popup", "$('#modalCalendarFin').modal('show')", true);
        }

        protected void botonAgregarCuatrimestre_Click(object sender, EventArgs e) {
            string mensaje = "";

            if (txtAno.Text != "" && txtFechaFin.Text != "" && txtFechaInicio.Text != "") {
                reglasNegocio.InsertarCuatrimestre(dropListPeriodo.SelectedValue, Convert.ToInt32(txtAno.Text), Convert.ToDateTime(txtFechaInicio.Text), Convert.ToDateTime(txtFechaFin.Text), txtNota.Text, ref mensaje);
                this.Master.tituloModalMensajesMaster.Attributes.Add("class", "modal-header bg-success text-white");
            } else {
                mensaje = "Por favor ingrese todos los datos";
                this.Master.tituloModalMensajesMaster.Attributes.Add("class", "modal-header bg-danger text-white");
            }

            txtAno.Text = "";
            txtFechaInicio.Text = "";
            txtFechaFin.Text = "";
            txtNota.Text = "";

            this.Master.mensajeModalMaster.InnerHtml = mensaje;
            ClientScript.RegisterStartupScript(this.GetType(), "Popup", "$('#modalMensajesMaster').modal('show')", true);
        }

        protected void botonMostrarCuatrimestres_Click(object sender, EventArgs e) {
            LlenarGrid();
        }

        public void LlenarGrid() {
            string mensaje = "";

            gridCuatrimestres.DataSource = reglasNegocio.ListaCuatrimestres(ref mensaje);
            gridCuatrimestres.DataBind();
            this.Master.mensajeModalMaster.InnerHtml = mensaje;
            ClientScript.RegisterStartupScript(this.GetType(), "Popup", "$('#modalCuatrimestres').modal('show')", true);
        }

        protected void Calendar1_SelectionChanged(object sender, EventArgs e) {
            txtFechaInicio.Text = Calendar1.SelectedDate.ToString("dd-MM-yyyy");
            panelFechaInicio.Update();
        }

        protected void Calendar2_SelectionChanged(object sender, EventArgs e) {
            txtFechaFin.Text = Calendar2.SelectedDate.ToString("dd-MM-yyyy");
            panelFechaFin.Update();
        }
    }
}