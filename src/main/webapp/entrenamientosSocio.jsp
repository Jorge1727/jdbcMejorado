<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: georg
  Date: 23/11/2023
  Time: 12:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" type="text/css" href="estilos.css" />
    <title>Entrenamientos</title>
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

            String sql = "SELECT * FROM entrenamientos WHERE id_cliente = ?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, codigo);

            // Utiliza executeQuery() para consultas SELECT
            rs = ps.executeQuery();

            out.println("<table><tr><th>Código</th><th>Socio</th><th>Entrenamiento</th><th>Ubicación</th><th>Fecha</th></tr>\n");

            // Verifica si hay resultados antes de procesarlos
            while (rs.next()) {
                // Aquí puedes acceder a los detalles del socio
                int id = rs.getInt("id");
                int idCliente = rs.getInt("id_cliente");
                String tipoEntrenamiento = rs.getString("tipo_entrenamiento");
                String ubicacion = rs.getString("ubicacion");


                String fecha = rs.getString("fecha");

                // Ahora puedes mostrar estos detalles en la página HTML
%>

    <tr>
        <td><%= id %></td>
        <td><%= idCliente %></td>
        <td><%= tipoEntrenamiento %></td>
        <td><%= ubicacion %></td>
        <td><%= fecha %></td>

    <td>
        <form method="get" action="borraEntrenamiento.jsp">
            <input type="hidden" name="codigo" value="<%=id %>"/>
            <input type="submit" value="eliminar">
        </form>
    </td>

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
    </tr>
</table>
<a href="index.jsp">Volver al menú</a>
</body>
</html>
