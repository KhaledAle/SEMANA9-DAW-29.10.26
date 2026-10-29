<%@ page import="java.text.SimpleDateFormat,java.util.ArrayList,java.util.Date,java.util.HashMap,java.util.List,java.util.Map" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%!
    private String escapar(String valor) {
        if (valor == null) {
            return "";
        }
        return valor.replace("&", "&amp;")
                    .replace("<", "&lt;")
                    .replace(">", "&gt;")
                    .replace("\"", "&quot;")
                    .replace("'", "&#x27;");
    }
%>
<%
    request.setCharacterEncoding("UTF-8");
    if (!"POST".equalsIgnoreCase(request.getMethod())) {
        response.setHeader("Allow", "POST");
        response.setStatus(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
        out.println("<!DOCTYPE html><html lang=\"es\"><meta charset=\"UTF-8\"><title>Método no permitido</title><h1>Error 405</h1><p>Envía el formulario mediante POST.</p><a href=\"index.jsp\">Volver</a></html>");
        return;
    }

    String nombre = request.getParameter("nombre");
    String correo = request.getParameter("correo");
    if (nombre == null || nombre.trim().isEmpty()
            || correo == null || !correo.trim().matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$")) {
        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        out.println("<!DOCTYPE html><html lang=\"es\"><meta charset=\"UTF-8\"><title>Solicitud inválida</title><h1>Error 400</h1><p>Ingresa un nombre y un correo válido.</p><a href=\"index.jsp\">Volver</a></html>");
        return;
    }

    nombre = nombre.trim();
    correo = correo.trim();
    List<Map<String, String>> registros =
        (List<Map<String, String>>) session.getAttribute("registros");
    if (registros == null) {
        registros = new ArrayList<Map<String, String>>();
    }

    Map<String, String> registro = new HashMap<String, String>();
    registro.put("nombre", nombre);
    registro.put("correo", correo);
    registro.put("fecha", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
    registros.add(registro);
    session.setAttribute("registros", registros);
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contactos registrados - JSP</title>
</head>
<body>
    <h1>Contactos registrados en esta sesión (JSP)</h1>
    <p>El contacto se agregó correctamente.</p>
    <table border="1" cellpadding="8" cellspacing="0">
        <thead>
            <tr>
                <th>#</th>
                <th>Nombre</th>
                <th>Correo</th>
                <th>Fecha y hora</th>
            </tr>
        </thead>
        <tbody>
            <%
                int indice = 1;
                for (Map<String, String> elemento : registros) {
            %>
                <tr>
                    <td><%= indice++ %></td>
                    <td><%= escapar(elemento.get("nombre")) %></td>
                    <td><%= escapar(elemento.get("correo")) %></td>
                    <td><%= escapar(elemento.get("fecha")) %></td>
                </tr>
            <%
                }
            %>
        </tbody>
    </table>
    <p><a href="index.jsp">Registrar otro contacto</a></p>
</body>
</html>
