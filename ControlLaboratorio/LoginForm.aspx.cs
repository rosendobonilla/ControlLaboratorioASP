using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ControlLaboratorio {
    public partial class LoginForm : System.Web.UI.Page {

        ClaseLogicaNegocio reglasNegocio = new ClaseLogicaNegocio();
        protected void Page_Load(object sender, EventArgs e) {
            FormsAuthentication.SignOut();
        }

        protected void botonIniciarSesion_Click(object sender, EventArgs e) {
            string mensaje = "";
            string[] datos = new string[5];
            if (reglasNegocio.ValidarUsuario(txtUsuario.Text, txtPassword.Text, ref datos, ref mensaje)) {
                FormsAuthentication.RedirectFromLoginPage(txtUsuario.Text, false);
                Session["id_usuario"] = datos[2];
                Session["rol"] = datos[3];
            } else {
                Response.Write("<script>alert('Usuario o contraseña incorrectos');</script>");
                txtUsuario.Text = "";
                txtUsuario.Focus();
                //Response.Redirect("LoginForm.aspx", true);
            }

        }
    }
}