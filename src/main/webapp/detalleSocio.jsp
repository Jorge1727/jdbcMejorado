<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Detalle Socio</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" type="text/css" href="estilos.css" />
</head>
<body>

<%
    // CÓDIGO DE VALIDACIÓN
    boolean valida = true;
    int codigo = -1;
    try {
        codigo = Integer.parseInt(request.getParameter("codigo"));
    } catch (NumberFormatException nfe) {
        nfe.printStackTrace();
        valida = false;
    }
    // FIN CÓDIGO DE VALIDACIÓN

    if (valida) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/baloncesto","root", "123456");

            String sql = "SELECT * FROM socio WHERE socioID = ?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, codigo);

            // Utiliza executeQuery() para consultas SELECT
            rs = ps.executeQuery();

            // Verifica si hay resultados antes de procesarlos
            while (rs.next()) {
                // Aquí puedes acceder a los detalles del socio
                int socioID = rs.getInt("socioID");
                String nombre = rs.getString("nombre");
                int estatura = rs.getInt("estatura");
                int edad = rs.getInt("edad");
                String localidad = rs.getString("localidad");

                // Ahora puedes mostrar estos detalles en la página HTML
%>
<table>
    <tr><th>Código</th><th>Nombre</th><th>Estatura</th><th>Edad</th><th>Localidad</th></tr>
    <tr>
        <td><%= socioID %></td>
        <td><%= nombre %></td>
        <td><%= estatura %></td>
        <td><%= edad %></td>
        <td><%= localidad %></td>
    </tr>
    <tr>
        <td><a href="index.jsp">Volver al menú</a></td>
    </tr>
</table>
<%
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try { rs.close(); } catch (Exception e) { /* Ignorado */ }
            try { ps.close(); } catch (Exception e) { /* Ignorado */ }
            try { conn.close(); } catch (Exception e) { /* Ignorado */ }
        }
    }
%>


</body>
</html>
