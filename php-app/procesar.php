<?php
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    header('Allow: POST');
    http_response_code(405);
    exit('<!DOCTYPE html><html lang="es"><meta charset="UTF-8"><title>Método no permitido</title><h1>Error 405</h1><p>Envía el formulario mediante POST.</p><a href="index.html">Volver</a></html>');
}

$nombre = trim($_POST['nombre'] ?? '');
$correo = trim($_POST['correo'] ?? '');

if ($nombre === '' || $correo === '' || filter_var($correo, FILTER_VALIDATE_EMAIL) === false) {
    http_response_code(400);
    exit('<!DOCTYPE html><html lang="es"><meta charset="UTF-8"><title>Solicitud inválida</title><h1>Error 400</h1><p>Ingresa un nombre y un correo válido.</p><a href="index.html">Volver</a></html>');
}

session_start();
if (!isset($_SESSION['registros'])) {
    $_SESSION['registros'] = [];
}

$_SESSION['registros'][] = [
    'nombre' => $nombre,
    'correo' => $correo,
    'fecha' => date('Y-m-d H:i:s'),
];

function escapar(string $valor): string
{
    return htmlspecialchars($valor, ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8');
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contactos registrados - PHP</title>
</head>
<body>
    <h1>Contactos registrados en esta sesión (PHP)</h1>
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
            <?php foreach ($_SESSION['registros'] as $indice => $registro): ?>
                <tr>
                    <td><?= $indice + 1 ?></td>
                    <td><?= escapar($registro['nombre']) ?></td>
                    <td><?= escapar($registro['correo']) ?></td>
                    <td><?= escapar($registro['fecha']) ?></td>
                </tr>
            <?php endforeach; ?>
        </tbody>
    </table>
    <p><a href="index.html">Registrar otro contacto</a></p>
</body>
</html>
