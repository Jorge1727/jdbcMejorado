<%@ page import="java.util.ArrayList" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" type="text/css" href="estilos.css" />
  </head>
  <body>
    <h2>Introduzca los datos del nuevo socio:</h2>
    <form method="get" action="grabaSocio.jsp">
      Nº socio <input type="text" name="numero"/></br>
      Nombre <input type="text" name="nombre"/></br>
      Estatura <input type="text" name="estatura"/></br>
      Edad <input type="text" name="edad"/></br>
      Localidad <input type="text" name="localidad"/></br>
      <input type="submit" value="Aceptar">
    </form>

    <%
      //recupera los errores de la sesión
      ArrayList<String> errores = (ArrayList<String>) session.getAttribute("erroresValidacion");

      if (errores != null && !errores.isEmpty()) {
        int numErrores = errores.size();

        out.println("<table>");
        out.println("<tr>");
        for (int i = 0; i < numErrores; i++) {
          out.println("<td class=\"error\">" + errores.get(i) + "</td>");
        }
        out.println("</tr>");
        out.println("</table>");
        out.println("<br>");
      }

    //limpia los errores almacenados en la sesión
      session.removeAttribute("erroresValidacion");
    %>

  </body>
</html>