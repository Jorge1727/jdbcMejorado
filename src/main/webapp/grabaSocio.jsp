<%@page import="java.sql.*" %>
<%@page import="java.util.Objects" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.util.ArrayList" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" type="text/css" href="estilos.css" />
</head>
<body>
<%
    //CÓDIGO DE VALIDACIÓN
    ArrayList<String> errores = new ArrayList<String>();

    boolean valida = true;
    Integer numero = -1;
    String nombre = null;
    Integer estatura = -1;
    Integer edad = -1;
    String localidad = null;

    //error id
    try {
        numero = Integer.parseInt(request.getParameter("numero"));
    } catch (NumberFormatException e) {
        errores.add("El nuevo ID debe ser un numero.");
        valida = false;
    }


    //UTILIZO LOS CONTRACTS DE LA CLASE Objects PARA LA VALIDACIÓN
    //             v---- LANZA NullPointerException SI EL PARÁMETRO ES NULL
    //Objects.requireNonNull(request.getParameter("nombre"));
    //CONTRACT nonBlank..
    //UTILIZO isBlank SOBRE EL PARÁMETRO DE TIPO String PARA CHEQUEAR QUE NO ES UN PARÁMETRO VACÍO "" NI CADENA TODO BLANCOS "    "
    //          |                                EN EL CASO DE QUE SEA BLANCO LO RECIBIDO, LANZO UNA EXCEPCIÓN PARA INVALIDAR EL PROCESO DE VALIDACIÓN
    //          -------------------------v                      v---------------------------------------|

    //error nombre
    nombre = request.getParameter("nombre");
    if(nombre.isBlank())
    {
        errores.add("Nombre vacío o todo espacios blancos.");
        valida = false;
    }

    if(nombre == null)
    {
        errores.add("El nombre no puede ser nulo.");
        valida = false;
    }

    if(nombre.matches("\\d+"))//Para que el nombre no sea numero
    {
        errores.add("El nombre no puede ser un numero");
        valida = false;
    }


    //error estatura
    try{
        estatura = Integer.parseInt(request.getParameter("estatura"));

    }catch (NumberFormatException e){

        errores.add("La estatura debe ser un numero y entero, ya que son en cm.");
        valida = false;
    }

    //error edad
    try{
        edad = Integer.parseInt(request.getParameter("edad"));

    }catch (NumberFormatException e){
        errores.add("La edad debe ser un numero y entero.");
        valida = false;
    }


    //UTILIZO LOS CONTRACTS DE LA CLASE Objects PARA LA VALIDACIÓN
    //             v---- LANZA NullPointerException SI EL PARÁMETRO ES NULL
    //Objects.requireNonNull(request.getParameter("localidad"));
    //CONTRACT nonBlank
    //UTILIZO isBlank SOBRE EL PARÁMETRO DE TIPO String PARA CHEQUEAR QUE NO ES UN PARÁMETRO VACÍO "" NI CADENA TODO BLANCOS "    "
    //          |                                EN EL CASO DE QUE SEA BLANCO LO RECIBIDO, LANZO UNA EXCEPCIÓN PARA INVALIDAR EL PROCESO DE VALIDACIÓN
    //          -------------------------v                      v---------------------------------------|
    //if (request.getParameter("localidad").isBlank()) throw new RuntimeException("Parámetro vacío o todo espacios blancos.");
    //localidad = request.getParameter("localidad");

    localidad = request.getParameter("localidad");
    if(nombre.isBlank())
    {
        errores.add("Localidad vacío o todo espacios blancos.");
        valida = false;
    }

    if(localidad == null)
    {
        errores.add("La localidad no puede ser nula.");
        valida = false;
    }

    if(localidad.matches("\\d+"))//Para que el nombre no sea numero
    {
        errores.add("la localidad no puede ser un numero");
        valida = false;
    }

    //FIN CÓDIGO DE VALIDACIÓN

    if (valida) {

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

            String sql = "INSERT INTO socio VALUES ( " +
                    "?, " + //socioID
                    "?, " + //nombre
                    "?, " + //estatura
                    "?, " + //edad
                    "?)"; //localidad

            ps = conn.prepareStatement(sql);
            int idx = 1;
            ps.setInt(idx++, numero);
            ps.setString(idx++, nombre);
            ps.setInt(idx++, estatura);
            ps.setInt(idx++, edad);
            ps.setString(idx++, localidad);

            int filasAfectadas = ps.executeUpdate();
            System.out.println("SOCIOS GRABADOS:  " + filasAfectadas);


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

        out.println("Socio dado de alta.");
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
        out.println("<a href=\"formularioSocio.jsp\">Volver al formulario</a>\n<a href=\"index.jsp\">Volver al menu</a>");
    }
%>
</body>
</html>
