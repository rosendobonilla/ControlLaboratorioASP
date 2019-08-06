using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ControlLaboratorio {
    public partial class Profesor : System.Web.UI.Page {

        ClaseLogicaNegocio reglasNegocio = new ClaseLogicaNegocio();
        protected void Page_Load(object sender, EventArgs e) {
            if (Session["rol"] != null) {
                if (Session["rol"].Equals("profesor")) {
                    Response.Redirect("HorarioProfesor.aspx");
                }
            }
        }

        protected void botonAgregarProfesor_Click(object sender, EventArgs e) {
            string mensaje = "";

            if (txtNom.Text != "" && txtPaterno.Text != "" && txtMaterno.Text != "" && txtArea.Text != "" && txtCategoria.Text != "") {
                reglasNegocio.InsertarProfesor(txtNom.Text, txtPaterno.Text, txtMaterno.Text, txtArea.Text, txtCategoria.Text,txtNota.Text, checkAdministrador.Checked ? "administrador" : "profesor", ref mensaje);
                this.Master.tituloModalMensajesMaster.Attributes.Add("class", "modal-header bg-success text-white");
            } else {
                mensaje = "Por favor ingrese todos los datos";
                this.Master.tituloModalMensajesMaster.Attributes.Add("class", "modal-header bg-danger text-white");
            }

            txtNom.Text = "";
            txtPaterno.Text = "";
            txtMaterno.Text = "";
            txtArea.Text = "";
            txtCategoria.Text = "";
            txtNota.Text = "";

            this.Master.mensajeModalMaster.InnerHtml = mensaje;
            ClientScript.RegisterStartupScript(this.GetType(), "Popup", "$('#modalMensajesMaster').modal('show')", true);
        }

        protected void botonMostrarProfesores_Click(object sender, EventArgs e) {
            LlenarGrid();
        }
        public void LlenarGrid() {
            string mensaje = "";

            gridProfesores.DataSource = reglasNegocio.ListaProfesores(ref mensaje);
            gridProfesores.DataBind();
            this.Master.mensajeModalMaster.InnerHtml = mensaje;
            ClientScript.RegisterStartupScript(this.GetType(), "Popup", "$('#modalProfesores').modal('show')", true);
        }


    }
}