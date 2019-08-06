<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="~/LoginForm.aspx.cs" Inherits="ControlLaboratorio.LoginForm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="design/bootstrap/css/bootstrap-minty.min.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="design/login/css/util.css" />
    <link rel="stylesheet" type="text/css" href="design/login/css/main.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="limiter">
            <div class="container-login100">
                <div class="wrap-login100">
                    <div class="login100-form validate-form">
                        <span class="login100-form-title p-b-26">Ingresar
                        </span>
                        <span class="login100-form-title p-b-48">
                            <i class="zmdi zmdi-font"></i>
                        </span>

                        <div class="wrap-input100" >
                            <asp:TextBox ID="txtUsuario" placeholder="Usuario" CssClass="input100" runat="server" />
                        </div>

                        <div class="wrap-input100">
                            <asp:TextBox ID="txtPassword" placeholder="Contraseña" CssClass="input100" runat="server" TextMode="Password" />
                        </div>

                        <div class="container-login100-form-btn">
                            <asp:Button Text="Ingresar" ID="botonIniciarSesion" CssClass="btn btn-primary" OnClick="botonIniciarSesion_Click" runat="server" />
                        </div>

                    </div>
                </div>
            </div>
        </div>

    </form>
</body>
</html>
