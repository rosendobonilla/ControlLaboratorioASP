using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ControlLaboratorio {
    public partial class Materia : System.Web.UI.Page {

        ClaseLogicaNegocio reglasNegocio = new ClaseLogicaNegocio();
        protected void Page_Load(object sender, EventArgs e) {
            if (Session["rol"] != null) {
                if (Session["rol"].Equals("profesor")) {
                    Response.Redirect("HorarioProfesor.aspx");
                }
            }
        }

        protected void botonAgregarMateria_Click(object sender, EventArgs e) {
            string mensaje = "";

            if (txtNomMateria.Text != "" && txtHorasSemana.Text != "" && txtEspecialidad.Text != "") {
                reglasNegocio.InsertarMateria(txtNomMateria.Text, Convert.ToInt32(txtHorasSemana.Text), Convert.ToInt32(dropListGrado.SelectedValue), txtEspecialidad.Text, txtNota.Text, ref mensaje);
                this.Master.tituloModalMensajesMaster.Attributes.Add("class", "modal-header bg-success text-white");
            } else {
                mensaje = "Por favor ingrese todos los datos";
                this.Master.tituloModalMensajesMaster.Attributes.Add("class", "modal-header bg-danger text-white");
            }

            txtNomMateria.Text = "";
            txtHorasSemana.Text = "";
            txtNota.Text = "";
            txtEspecialidad.Text = "";

            this.Master.mensajeModalMaster.InnerHtml = mensaje;
            ClientScript.RegisterStartupScript(this.GetType(), "Popup", "$('#modalMensajesMaster').modal('show')", true);
        }

        protected void botonMostrarMaterias_Click(object sender, EventArgs e) {
            LlenarGrid();
        }

        public void LlenarGrid() {
            string mensaje = "";

            gridMaterias.DataSource = reglasNegocio.ListaMaterias(ref mensaje);
            gridMaterias.DataBind();
            this.Master.mensajeModalMaster.InnerHtml = mensaje;
            ClientScript.RegisterStartupScript(this.GetType(), "Popup", "$('#modalMaterias').modal('show')", true);
        }
    }
}