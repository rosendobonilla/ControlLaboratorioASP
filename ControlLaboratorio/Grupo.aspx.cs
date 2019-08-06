using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ControlLaboratorio {
    public partial class Grupo : System.Web.UI.Page {
        protected void Page_Load(object sender, EventArgs e) {
            if (Session["rol"] != null) {
                if (Session["rol"].Equals("profesor")) {
                    Response.Redirect("HorarioProfesor.aspx");
                }
            }
        }

        ClaseLogicaNegocio reglasNegocio = new ClaseLogicaNegocio();
        protected void botonAgregarGrupo_Click(object sender, EventArgs e) {
            string mensaje = "";

            if (txtNivel.Text != "") {
                reglasNegocio.InsertarGrupo(Convert.ToInt32(dropListGrado.SelectedValue), dropListLetra.SelectedValue, txtNivel.Text, txtNota.Text, ref mensaje);
                this.Master.tituloModalMensajesMaster.Attributes.Add("class", "modal-header bg-success text-white");
            } else {
                mensaje = "Por favor ingrese todos los datos";
                this.Master.tituloModalMensajesMaster.Attributes.Add("class", "modal-header bg-danger text-white");
            }

            txtNivel.Text = "";
            txtNota.Text = "";

            this.Master.mensajeModalMaster.InnerHtml = mensaje;
            ClientScript.RegisterStartupScript(this.GetType(), "Popup", "$('#modalMensajesMaster').modal('show')", true);
        }

        protected void botonMostrarGrupos_Click(object sender, EventArgs e) {
            LlenarGrid();
        }

        public void LlenarGrid() {
            string mensaje = "";

            gridGrupos.DataSource = reglasNegocio.ListaGrupos(ref mensaje);
            gridGrupos.DataBind();
            this.Master.mensajeModalMaster.InnerHtml = mensaje;
            ClientScript.RegisterStartupScript(this.GetType(), "Popup", "$('#modalObras').modal('show')", true);
        }
    }
}