<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Laboratorio 09 - Registro JSP</title>
</head>
<body>
    <h1>Sistema de registro de contactos (JSP)</h1>
    <form action="procesar.jsp" method="POST">
        <p>
            <label for="nombre">Nombre:</label>
            <input type="text" id="nombre" name="nombre" required>
        </p>
        <p>
            <label for="correo">Correo:</label>
            <input type="email" id="correo" name="correo" required>
        </p>
        <button type="submit">Registrar contacto</button>
    </form>
</body>
</html>
