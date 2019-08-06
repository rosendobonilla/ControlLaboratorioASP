using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace ControlLaboratorio {
    public partial class Principal : System.Web.UI.MasterPage {
        public HtmlGenericControl tituloModalMensajesMaster {
            get { return (HtmlGenericControl)FindControl("modalHeaderMensajes"); }
            set { modalHeaderMensajes = value; }
        }

        public HtmlGenericControl mensajeModalMaster {
            get { return (HtmlGenericControl)FindControl("mensajeModal"); }
            set { modalHeaderMensajes = value; }
        }

        public HtmlImage BotonMenu {
            get { return botonMenu; }
            set { botonMenu = value; }
        }
        protected void Page_Load(object sender, EventArgs e) {

        }

        protected void botonLogout_Click(object sender, ImageClickEventArgs e) {
            FormsAuthentication.SignOut();
            Response.Redirect("LoginForm.aspx", true);
        }
    }
}