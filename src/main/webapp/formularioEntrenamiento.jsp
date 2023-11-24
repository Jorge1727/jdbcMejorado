<%--
  Created by IntelliJ IDEA.
  User: georg
  Date: 23/11/2023
  Time: 10:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Formulario entrenamiento</title>
</head>
<body>
    <h2>Introduzca los datos:</h2>
    <form method="get" action="creaEntrenamiento.jsp">
        Nº socio <input type="text" name="id"/></br>
        Tipo de entrenamiento
        <select type="text" name="entrenamiento">
            <option value="fisico">Físico</option>
            <option value="tecnico">Técnico</option>
        </select><br>
        Ubicación <input type="text" name="ubicacion"/></br>
        Fecha de realización <input type="Date" name="fecha"><br>
        <input type="submit" value="Aceptar">
    </form>
</body>
</html>
