<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.ParseException" %>
<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: georg
  Date: 23/11/2023
  Time: 10:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="estilos.css" />
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Entrenamiento</title>
</head>
<body>
<%
    //CÓDIGO DE VALIDACIÓN
    ArrayList<String> errores = new ArrayList<String>();

    boolean valida = true;
    Integer id = -1;
    String entrenamiento = null;
    String ubicacion = null;
    String fecha = null;

    //error id
    try {
        id = Integer.parseInt(request.getParameter("id"));

        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/baloncesto","root", "123456");
        Statement s = conexion.createStatement();

        ResultSet listado = s.executeQuery ("SELECT * FROM socio");

        ArrayList<Integer> sociosID = new ArrayList<>();

        while (listado.next())
        {
            sociosID.add(listado.getInt("socioID"));
        }


        if(!sociosID.contains(id))
        {
            errores.add("El socio no existe");
            valida = false;
        }

        conexion.close();
        s.close();

    } catch (NumberFormatException e) {
        errores.add("El ID debe ser un numero.");
        valida = false;
    }


    //error entrenamiento
    entrenamiento = request.getParameter("entrenamiento");
    if(entrenamiento.isBlank())
    {
        errores.add("El entrenamiento debe ser seleccionado.");
        valida = false;
    }

    if(entrenamiento == null)
    {
        errores.add("El entrenamiento no puede ser nulo.");
        valida = false;
    }


    //error ubicacion
    ubicacion = request.getParameter("ubicacion");

    if(ubicacion.isBlank())
    {
        errores.add("La ubicacion no puede estar vacía.");
        valida = false;
    }

    if(ubicacion == null)
    {
        errores.add("La  ubicaion no puede ser nula.");
        valida = false;
    }

    //error fecha
    fecha = request.getParameter("fecha");

    if (fecha == null || fecha.isBlank())
    {
        errores.add("La fecha no puede ser nula o vacía.");
        valida = false;
    }

    //FIN CÓDIGO DE VALIDACIÓN
    if (valida)
    {
        Connection conn = null;
        PreparedStatement ps = null;
        // 	ResultSet rs = null;

        try {

            //CARGA DEL DRIVER Y PREPARACIÓN DE LA CONEXIÓN CON LA BBDD
            //						v---------UTILIZAMOS LA VERSIÓN MODERNA DE LLAMADA AL DRIVER, no deprecado
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/baloncesto", "root", "123456");


//>>>>>>NO UTILIZAR STATEMENT EN QUERIES PARAMETRIZADAS
//       Statement s = conexion.createStatement();
//       String insercion = "INSERT INTO socio VALUES (" + Integer.valueOf(request.getParameter("numero"))
//                          + ", '" + request.getParameter("nombre")
//                          + "', " + Integer.valueOf(request.getParameter("estatura"))
//                          + ", " + Integer.valueOf(request.getParameter("edad"))
//                          + ", '" + request.getParameter("localidad") + "')";
//       s.execute(insercion);
//<<<<<<

            String sql = "INSERT INTO entrenamientos (id_cliente, tipo_entrenamiento, ubicacion, fecha) VALUES (?, ?, ?, ?)";//Por que el id es autoincrement
            ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            ps.setInt(1, id);//id cliente
            ps.setString(2, entrenamiento);
            ps.setString(3, ubicacion);
            ps.setString(4, fecha);

            int filasAfectadas = ps.executeUpdate();
            System.out.println("ENTRENAMIENTO GRABADO:  " + filasAfectadas);

        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            //BLOQUE FINALLY PARA CERRAR LA CONEXIÓN CON PROTECCIÓN DE try-catch
            //SIEMPRE HAY QUE CERRAR LOS ELEMENTOS DE LA  CONEXIÓN DESPUÉS DE UTILIZARLOS
            //try { rs.close(); } catch (Exception e) { /* Ignored */ }
            try {
                ps.close();
            } catch (Exception e) { /* Ignored */ }
            try {
                conn.close();
            } catch (Exception e) { /* Ignored */ }
        }

        out.println("Entrenamiento creado para el socio " + id);
        out.println("<br>");
        out.println("<td><a href=\"index.jsp\">Volver al menu</a></td>\n");
    } else {
        int numErrores = errores.size();

        out.println("<table>");
        out.println("<tr>");
        for (int i = 0; i < numErrores; i++)
        {
            out.println("<td>" + errores.get(i) + "</td>");
        }
        out.println("</tr>");
        out.println("</table>");
        out.println("<br>");
        out.println("<a href=\"formularioEntrenamiento.jsp\">Volver al formulario</a>\n<a href=\"index.jsp\">Volver al menu</a>");
    }
%>
</body>
</html>
