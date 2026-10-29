# Laboratorio 09 - Registro de contactos con PHP y JSP

Aplicación web sencilla para registrar contactos y conservarlos durante la sesión del navegador. Se implementa en dos versiones: PHP para Apache y JSP para Apache Tomcat.

## Estructura

```text
php-app/
├── index.html
└── procesar.php
jsp-app/
├── WEB-INF/
│   └── web.xml
├── index.jsp
└── procesar.jsp
```

## Requisitos

- PHP 8 o compatible y Apache (por ejemplo, XAMPP).
- Java y Apache Tomcat para ejecutar la versión JSP.
- Para esta práctica no se usa base de datos: los contactos viven en la sesión y desaparecen al expirar o cerrarse dicha sesión.

## Ejecutar la versión PHP

1. Copiar el contenido de la carpeta `php-app` dentro de `C:\xampp\htdocs\lab09.2\`.
2. Inicia Apache desde el panel de XAMPP.
3. Abre `http://localhost/lab09.2/` en el navegador.
4. Registra dos o más contactos en la misma sesión para comprobar que se acumulan.

## Ejecutar la versión JSP

1. Copiar el contenido de la carpeta `jsp-app` dentro de `C:\xampp\tomcat\webapps\lab09.2\`
2. Inicia Tomcat. El puerto usual es `8080`; puede variar según la configuración instalada.
3. Abre `http://localhost:8080/lab09.2/`.
4. Registra dos o más contactos en la misma sesión para comprobar que se acumulan.


## Comportamiento implementado

- Los formularios envían los datos usando `POST`.
- `procesar.php` y `procesar.jsp` rechazan otros métodos con HTTP `405` y anuncian que solo permiten `POST`.
- Los campos nombre y correo son obligatorios; se comprueba el formato del correo. Los datos inválidos reciben HTTP `400`.
- Los contactos se acumulan en `$_SESSION` (PHP) o `HttpSession` (JSP).
- Los valores originales se guardan en la sesión y se escapan al renderizarlos en HTML: `htmlspecialchars()` en PHP y `escapar()` en JSP. Esto evita que texto ingresado se interprete como marcado o código.
- La respuesta exitosa contiene una tabla con todos los registros de la sesión.

## Pruebas manuales

| Caso | Acción | Resultado esperado |
|---|---|---|
| Registro válido | Enviar nombre y correo válido | `200 OK`; aparece el contacto en la tabla |
| Varios registros | Enviar más de un contacto en la misma sesión | Todos aparecen en la tabla |
| Nombre vacío | Enviar el campo vacío o enviar la petición sin `nombre` | `400 Bad Request` |
| Correo inválido | Enviar un correo con formato inválido | `400 Bad Request` |
| Método no permitido | Abrir `procesar.php` o `procesar.jsp` directamente | `405 Method Not Allowed` |
| Texto tipo HTML | Usar `<script>alert(1)</script>` como nombre | Se muestra como texto escapado, no se ejecuta |

## Ciclo de una solicitud HTTP

1. El navegador resuelve `localhost` y se conecta al puerto del servidor web.
2. Apache sirve la página estática y entrega el formulario al navegador; Tomcat procesa la página JSP.
3. Al enviar el formulario, el navegador envía los campos en el cuerpo de una solicitud HTTP `POST`. La cookie de sesión identifica la sesión correspondiente.
4. PHP o JSP verifica el método y los datos. Si son válidos, agrega el contacto a la sesión.
5. El servidor genera HTML con la tabla y responde al navegador. El navegador interpreta la respuesta y muestra la lista.
