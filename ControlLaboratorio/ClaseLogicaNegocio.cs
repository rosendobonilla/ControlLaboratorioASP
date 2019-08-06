using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using ClassADO_001;

namespace ControlLaboratorio {
    public class ClaseLogicaNegocio {

        private UsaSql manejaInterno = new UsaSql();
        public ClaseLogicaNegocio() {
            manejaInterno.CadenaConexion = ConfigurationManager.ConnectionStrings["conexion1"].ToString();
        }

        public List<string> CargarCuatrimestres(ref string mensaje, ref List<int> idsTipos) {
            SqlConnection abierta = manejaInterno.Conectar(ref mensaje);
            SqlDataReader atrapa = null;
            List<string> tipos = new List<string>();
            idsTipos.Clear();

            atrapa = manejaInterno.ConsultaReader(abierta, "select id_cuatri, periodo + ' ' + CONVERT(varchar,año) as 'cuatrimestre' from Cuatrimestre; ", ref mensaje);

            if (atrapa != null) {
                while (atrapa.Read()) {
                    tipos.Add(atrapa[1].ToString());
                    idsTipos.Add((int)atrapa[0]);
                }
            }

            return tipos;
        }

        public List<string> CargarGrupos(ref string mensaje, ref List<int> idsTipos) {
            SqlConnection abierta = manejaInterno.Conectar(ref mensaje);
            SqlDataReader atrapa = null;
            List<string> tipos = new List<string>();
            idsTipos.Clear();

            atrapa = manejaInterno.ConsultaReader(abierta, "select id_grupo, CONVERT(varchar, grado) + ' ' + letra as Grupo from Grupo", ref mensaje);

            if (atrapa != null) {
                while (atrapa.Read()) {
                    tipos.Add(atrapa[1].ToString());
                    idsTipos.Add((int)atrapa[0]);
                }
            }

            return tipos;
        }

        public List<string> CargarMaterias(ref string mensaje, ref List<int> idsTipos) {
            SqlConnection abierta = manejaInterno.Conectar(ref mensaje);
            SqlDataReader atrapa = null;
            List<string> tipos = new List<string>();
            idsTipos.Clear();

            atrapa = manejaInterno.ConsultaReader(abierta, "select id_materia, nombre from Materia", ref mensaje);

            if (atrapa != null) {
                while (atrapa.Read()) {
                    tipos.Add(atrapa[1].ToString());
                    idsTipos.Add((int)atrapa[0]);
                }
            }

            return tipos;
        }

        public List<string> CargarProfesores(ref string mensaje, ref List<int> idsTipos) {
            SqlConnection abierta = manejaInterno.Conectar(ref mensaje);
            SqlDataReader atrapa = null;
            List<string> tipos = new List<string>();
            idsTipos.Clear();

            atrapa = manejaInterno.ConsultaReader(abierta, "select id_profe,nombre + ' ' + app + ' ' + apm as 'Nombre' from Profesor", ref mensaje);

            if (atrapa != null) {
                while (atrapa.Read()) {
                    tipos.Add(atrapa[1].ToString());
                    idsTipos.Add((int)atrapa[0]);
                }
            }

            return tipos;
        }
        public void InsertarGrupo(int grado, string letra, string nivel, string nota, ref string mensaje) {
            SqlConnection abierta = manejaInterno.Conectar(ref mensaje);

            string cadenaInsert = "INSERT INTO Grupo(grado, letra, nivel, Notas) VALUES(" + grado + ",'" + letra + "','" + nivel + "','" + nota + "')";
            manejaInterno.modificarBD(abierta, cadenaInsert, ref mensaje);

            abierta.Close();
        }

        public void InsertarMateria(string nombre, int horas, int grado, string especialidad, string notas, ref string mensaje) {
            SqlConnection abierta = manejaInterno.Conectar(ref mensaje);

            string cadenaInsert = "INSERT INTO Materia(nombre, horas, grado, especialidad, notas) VALUES('" + nombre + "'," + horas + "," + grado + ",'" + especialidad + "','" + notas + "')";
            manejaInterno.modificarBD(abierta, cadenaInsert, ref mensaje);

            abierta.Close();
        }

        public void InsertarProfesor(string nombre, string app, string apm, string area, string categoria, string notas, string rol, ref string mensaje) {
            SqlConnection abierta = manejaInterno.Conectar(ref mensaje);
            SqlTransaction transaction;
            string usuario = nombre.ToLower().Trim() + app.ToLower().Trim();

            transaction = abierta.BeginTransaction();

            try {
                new SqlCommand("INSERT INTO Profesor(nombre, app, apm, area, categoria, notas) VALUES('" + nombre + "', '" + app + "', '" + apm + "', '" + area + "', '" + categoria + "', '" + notas + "')", abierta, transaction)
                   .ExecuteNonQuery();
                int id_ultimo = manejaInterno.ConsultaEscalar(abierta, "SELECT TOP 1 id_profe FROM Profesor ORDER BY id_profe DESC", transaction, ref mensaje);

                new SqlCommand("INSERT INTO Sesion(usuario, password, id_usuario, rol) VALUES('" + usuario + "','" + usuario + "'," + id_ultimo + ",'" + rol + "')", abierta, transaction)
                   .ExecuteNonQuery();
                transaction.Commit();
            } catch (SqlException sqlError) {
                transaction.Rollback();
            }

            abierta.Close();
        }

        public void InsertarCuatrimestre(string periodo, int año, DateTime fechaInicio, DateTime fechaFin, string anotacion, ref string mensaje) {
            SqlConnection abierta = manejaInterno.Conectar(ref mensaje);

            string cadenaInsert = "INSERT INTO Cuatrimestre(periodo, año, fecha_inicio, fecha_fin, Anotacion) VALUES('" + periodo + "','" + año + "','" + fechaInicio.ToString("yyyy-MM-dd") + "','" + fechaFin.ToString("yyyy-MM-dd") + "','" + anotacion + "')";
            manejaInterno.modificarBD(abierta, cadenaInsert, ref mensaje);

            abierta.Close();
        }

        public void InsertarAsignacionGrupo(int cuatri, int grupo, int materia, int profe, string estado, string turno, string nota, ref string mensaje) {
            SqlConnection abierta = manejaInterno.Conectar(ref mensaje);

            string cadenaInsert = "INSERT INTO AsignacionGrupo(cuatri, grup, materia, profe, estado, turno, nota) VALUES(" + cuatri + "," + grupo + "," + materia + "," + profe + ",'" + estado + "','" + turno + "','" + nota + "')";
            manejaInterno.modificarBD(abierta, cadenaInsert, ref mensaje);

            abierta.Close();
        }

        public void InsertarHorarioGrupo(int grupoAsignado, string dia, int lugar, string hinicio, string hfin, ref string mensaje) {
            SqlConnection abierta = manejaInterno.Conectar(ref mensaje);

            string cadenaInsert = "INSERT INTO HorarioGrupo(grupoAsignado, dia, lugar, hinicio, hfin) VALUES(" + grupoAsignado + ",'" + dia + "'," + lugar + ",'" + hinicio + "','"  + hfin +  "')";
            manejaInterno.modificarBD(abierta, cadenaInsert, ref mensaje);

            abierta.Close();
        }

        public void InsertarLugar(string edificio, string salon, ref string mensaje) {
            SqlConnection abierta = manejaInterno.Conectar(ref mensaje);

            string cadenaInsert = "INSERT INTO Lugar(Edificio, Salon) VALUES('" + edificio + "','" + salon + "')";
            manejaInterno.modificarBD(abierta, cadenaInsert, ref mensaje);

            abierta.Close();
        }

        public void InsertarReporte(int categoria, string descripcion, string nota, ref string mensaje) {
            SqlConnection abierta = manejaInterno.Conectar(ref mensaje);

            int id_ultimo = manejaInterno.ConsultaEscalar(abierta, "SELECT TOP 1 id_asistencia FROM Asistencia ORDER BY id_asistencia DESC", null, ref mensaje);

            string cadenaInsert = "INSERT INTO Reporte(categoria, descripcion, nota, id_asistencia) VALUES(" + categoria + ",'" + descripcion + "','" + nota + "'," + id_ultimo + ")";
            manejaInterno.modificarBD(abierta, cadenaInsert, ref mensaje);

            abierta.Close();
        }

        public void InsertarTipoReporte(string categoria, ref string mensaje) {
            SqlConnection abierta = manejaInterno.Conectar(ref mensaje);

            string cadenaInsert = "INSERT INTO Tipo_Reporte(nombre) VALUES('" + categoria + "')";
            manejaInterno.modificarBD(abierta, cadenaInsert, ref mensaje);

            abierta.Close();
        }

        public void InsertarAsistencia(int horario, DateTime fecha, int alumnos, int falta, string nota, ref string mensaje) {
            SqlConnection abierta = manejaInterno.Conectar(ref mensaje);

            string cadenaInsert = "INSERT INTO Asistencia(id_horarioGrupo, fecha, no_alumnos, falta, nota) VALUES(" + horario + ",'" + fecha.ToString("yyyy-MM-dd") + "'," + alumnos + "," + falta + ",'" + nota + "')";
            manejaInterno.modificarBD(abierta, cadenaInsert, ref mensaje);

            abierta.Close();
        }
        public DataTable ListaGrupos(ref string mensaje) {
            DataSet atrapaMat = null;
            SqlConnection con = manejaInterno.Conectar(ref mensaje);
            string consulta = "select id_grupo, CONVERT(varchar, grado)  + ' ' + letra  as Grado, nivel as Nivel, Notas from Grupo";
            atrapaMat = manejaInterno.ConsultaDataset(con, consulta, ref mensaje);

            con.Close();

            return atrapaMat.Tables[0];
        }

        public DataTable ListaMaterias(ref string mensaje) {
            DataSet atrapaMat = null;
            SqlConnection con = manejaInterno.Conectar(ref mensaje);
            string consulta = "select nombre as Nombre, horas as 'Horas a la semana', grado as Grado, notas as 'Nota' from Materia";
            atrapaMat = manejaInterno.ConsultaDataset(con, consulta, ref mensaje);

            con.Close();

            return atrapaMat.Tables[0];
        }

        public DataTable ListaProfesores(ref string mensaje) {
            DataSet atrapaMat = null;
            SqlConnection con = manejaInterno.Conectar(ref mensaje);
            string consulta = "select nombre + ' ' + app + ' ' + apm as 'Nombre', area as Area, categoria as Categoría, notas as Nota from Profesor";
            atrapaMat = manejaInterno.ConsultaDataset(con, consulta, ref mensaje);

            con.Close();

            return atrapaMat.Tables[0];
        }

        public DataTable ListaCuatrimestres(ref string mensaje) {
            DataSet atrapaMat = null;
            SqlConnection con = manejaInterno.Conectar(ref mensaje);
            string consulta = "select periodo as Periodo, año as Año, FORMAT(fecha_inicio,'dd/MM/yyyy') as 'Fecha de inicio', FORMAT(fecha_fin,'dd/MM/yyyy') as 'Fecha de fin' from Cuatrimestre";
            atrapaMat = manejaInterno.ConsultaDataset(con, consulta, ref mensaje);

            con.Close();

            return atrapaMat.Tables[0];
        }

        public DataTable ListaAsignacionGrupo(ref string mensaje) {
            DataSet atrapaMat = null;
            SqlConnection con = manejaInterno.Conectar(ref mensaje);
            string consulta = "select ag.id_asignacion, CONVERT(varchar, g.grado) + g.letra as Grupo, m.nombre as Materia,  p.nombre + ' ' + p.app + ' ' + p.apm as 'Profesor' ,c.periodo + ' ' + CONVERT(varchar,c.año) as 'Cuatrimestre' from (((AsignacionGrupo ag join Cuatrimestre c on ag.cuatri=c.id_cuatri) join Grupo g on ag.grup=g.id_grupo) join Materia m on ag.materia=m.id_materia) join Profesor p on ag.profe=p.id_profe";
            atrapaMat = manejaInterno.ConsultaDataset(con, consulta, ref mensaje);

            con.Close();

            return atrapaMat.Tables[0];
        }

        public DataTable ListaLugar(ref string mensaje) {
            DataSet atrapaMat = null;
            SqlConnection con = manejaInterno.Conectar(ref mensaje);
            string consulta = "select id_lug, Edificio + ' ' + Salon as 'lugar' from Lugar";
            atrapaMat = manejaInterno.ConsultaDataset(con, consulta, ref mensaje);

            con.Close();

            return atrapaMat.Tables[0];
        }

        public DataTable ListaTiposReporte(ref string mensaje) {
            DataSet atrapaMat = null;
            SqlConnection con = manejaInterno.Conectar(ref mensaje);
            string consulta = "select id_categoria, nombre from Tipo_Reporte";
            atrapaMat = manejaInterno.ConsultaDataset(con, consulta, ref mensaje);

            con.Close();

            return atrapaMat.Tables[0];
        }

        public DataTable ObtenerEventos(ref string mensaje) {
            DataSet atrapaMat = null;
            SqlConnection con = manejaInterno.Conectar(ref mensaje);
            string consulta = "select m.nombre as 'title', hg.dia as 'dow',hg.hinicio as 'start', hg.hfin as 'end', CONVERT(varchar,g.grado) + ' ' + g.letra as 'grupo', p.nombre + ' ' + p.app + ' ' + p.apm as 'profe', l.Edificio + ' ' + l.Salon as 'lugar' from HorarioGrupo hg  join AsignacionGrupo ag on hg.grupoAsignado = ag.id_asignacion join Profesor p on ag.profe=p.id_profe join Grupo g on ag.grup=g.id_grupo join Materia m on ag.materia=m.id_materia join Lugar l on hg.lugar = l.id_lug";
            atrapaMat = manejaInterno.ConsultaDataset(con, consulta, ref mensaje);

            con.Close();

            return atrapaMat.Tables[0];
        }

        public DataTable ObtenerHorarioProfesor(int profesor, ref string mensaje) {
            DataSet atrapaMat = null;
            SqlConnection con = manejaInterno.Conectar(ref mensaje);
            string consulta = "select hg.id_horario, m.nombre as 'title', hg.dia as 'dow',hg.hinicio as 'start', hg.hfin as 'end', CONVERT(varchar,g.grado) + ' ' + g.letra as 'grupo', p.nombre + ' ' + p.app + ' ' + p.apm as 'profe', l.Edificio + ' ' + l.Salon as 'lugar' from HorarioGrupo hg  join AsignacionGrupo ag on hg.grupoAsignado = ag.id_asignacion join Profesor p on ag.profe=p.id_profe join Grupo g on ag.grup=g.id_grupo join Materia m on ag.materia=m.id_materia join Lugar l on hg.lugar = l.id_lug where ag.profe=" + profesor;
            atrapaMat = manejaInterno.ConsultaDataset(con, consulta, ref mensaje);

            con.Close();

            return atrapaMat.Tables[0];
        }

        public DataTable ObtenerGruposMasAsistencias(int idCuatrimestre, ref string mensaje) {
            DataSet atrapaMat = null;
            SqlConnection con = manejaInterno.Conectar(ref mensaje);
            string temp = idCuatrimestre == 0 ? " " : ", ag.cuatri having ag.cuatri = " + idCuatrimestre;

            string consulta = "select top(3) CONVERT(varchar,g.grado) + ' ' + g.letra as Grupo, count(CONVERT(varchar,g.grado) + ' ' + g.letra) as 'Asistencias' from Asistencia a join HorarioGrupo hg on a.id_horarioGrupo=hg.id_horario join AsignacionGrupo ag on hg.grupoAsignado = ag.id_asignacion join Grupo g on ag.grup=g.id_grupo group by CONVERT(varchar,g.grado) + ' ' + g.letra " + temp +" order by Asistencias desc";
            atrapaMat = manejaInterno.ConsultaDataset(con, consulta, ref mensaje);

            con.Close();

            return atrapaMat.Tables[0];
        }

        public DataTable ObtenerProfesoresMasAsistencias(int idCuatrimestre, ref string mensaje) {
            DataSet atrapaMat = null;
            SqlConnection con = manejaInterno.Conectar(ref mensaje);
            string temp = idCuatrimestre == 0 ? " " : ", ag.cuatri having ag.cuatri = " + idCuatrimestre;


            string consulta = "select top(3)  p.nombre + ' ' + p.app + ' ' + p.apm as Nombre, SUM(CONVERT(float,DATEDIFF(MINUTE, hg.hinicio, hg.hfin)/60.0)) as Horas from Asistencia a join HorarioGrupo hg on a.id_horarioGrupo=hg.id_horario join AsignacionGrupo ag on hg.grupoAsignado = ag.id_asignacion join Grupo g on ag.grup=g.id_grupo join Profesor p on ag.profe=p.id_profe join Cuatrimestre c on ag.cuatri = c.id_cuatri group by p.id_profe, p.nombre + ' ' + p.app + ' ' + p.apm " + temp + " order by Horas desc";
            atrapaMat = manejaInterno.ConsultaDataset(con, consulta, ref mensaje);

            con.Close();

            return atrapaMat.Tables[0];
        }

        public DataTable ObtenerFallasMasReportadas(int idCuatrimestre, ref string mensaje) {
            DataSet atrapaMat = null;
            SqlConnection con = manejaInterno.Conectar(ref mensaje);
            string temp = idCuatrimestre == 0 ? " " : ", ag.cuatri having ag.cuatri = " + idCuatrimestre;


            string consulta = "select top(3) tr.nombre as Categoría, count(r.id_reporte) as Reportes from Reporte r join Tipo_Reporte tr on r.categoria=tr.id_categoria join Asistencia a on r.id_asistencia=a.id_asistencia join HorarioGrupo hg on a.id_horarioGrupo=hg.id_horario join AsignacionGrupo ag on hg.grupoAsignado=ag.id_asignacion join Profesor p on ag.profe=p.id_profe group by tr.nombre " + temp  + " order by Reportes desc";
            atrapaMat = manejaInterno.ConsultaDataset(con, consulta, ref mensaje);

            con.Close();

            return atrapaMat.Tables[0];
        }

        public DataTable ObtenerEdificiosMasReportados(int idCuatrimestre, ref string mensaje) {
            DataSet atrapaMat = null;
            SqlConnection con = manejaInterno.Conectar(ref mensaje);
            string temp = idCuatrimestre == 0 ? " " : ", ag.cuatri having ag.cuatri = " + idCuatrimestre;

            string consulta = "select top(3) l.Edificio + ' ' + l.Salon  as 'Lugar', count(r.categoria) as Reportes from Reporte r join Tipo_Reporte tr on r.categoria=tr.id_categoria join Asistencia a on r.id_asistencia=a.id_asistencia join HorarioGrupo hg on hg.id_horario=a.id_horarioGrupo join Lugar l on hg.lugar = l.id_lug join AsignacionGrupo ag on hg.grupoAsignado=ag.id_asignacion group by l.Edificio + ' ' + l.Salon , l.Edificio " + temp + " order by Reportes desc";
            atrapaMat = manejaInterno.ConsultaDataset(con, consulta, ref mensaje);

            con.Close();

            return atrapaMat.Tables[0];
        }

        public DataTable ObtenerNoFaltas(int idProfe, ref string mensaje) {
            DataSet atrapaMat = null;
            SqlConnection con = manejaInterno.Conectar(ref mensaje);

            string consulta = "select FORMAT(a.fecha, 'dd/MM/yyyy') as 'Fecha', CONVERT(varchar,g.grado) + ' ' + g.letra as 'Grupo', l.Edificio + ' ' + l.Salon as 'Lugar', hg.hinicio as 'Hora de inicio', hg.hfin as 'Hora fin'  from Asistencia a join HorarioGrupo hg on a.id_horarioGrupo=hg.id_horario join AsignacionGrupo ag on hg.grupoAsignado=ag.id_asignacion join Grupo g on ag.grup=g.id_grupo join Lugar l on hg.lugar=l.id_lug where a.falta=1 and ag.profe=" + idProfe;
            atrapaMat = manejaInterno.ConsultaDataset(con, consulta, ref mensaje);

            con.Close();

            return atrapaMat.Tables[0];
        }

        public int VerificarAsistenciaRepetida(int idHorario,DateTime fecha, ref string mensaje) {
            SqlConnection con = manejaInterno.Conectar(ref mensaje);
            return Convert.ToInt32(manejaInterno.ConsultaEscalar(con,"select count(id_asistencia) as 'existencia' from Asistencia where id_horarioGrupo=" + idHorario  + " and fecha = '" + fecha.ToString("yyyy-MM-dd") + "'", null, ref mensaje));
        }


        public bool ValidarUsuario(string usuario, string pass, ref string[] datos, ref string mensaje) {
            SqlDataReader atrapa = null;
            SqlConnection con = manejaInterno.Conectar(ref mensaje);
            string consulta = "SELECT usuario, password, id_usuario, rol FROM Sesion WHERE usuario = '"+ usuario + "'";

            atrapa = manejaInterno.ConsultaReader(con, consulta, ref mensaje);

            if (atrapa != null) {
                while (atrapa.Read()) {
                    datos[0] = atrapa[0].ToString();
                    datos[1] = atrapa[1].ToString();
                    datos[2] = atrapa[2].ToString();
                    datos[3] = atrapa[3].ToString();
                }
            }

            if (null == datos[1]) {
                // TODO: manejar numero de intentos fallidos
                return false;
            }

            //HttpContext.Current.Session["Application"] = "dos";

            return (0 == string.Compare(datos[1], pass, false));
        }

    }
}