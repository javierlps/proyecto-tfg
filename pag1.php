<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Creación Base datos y tabla</title>
</head>
<body>
<?php
// Ignorar mensajes de advertencia
error_reporting(0);

// Variables de datos para la conexión
$servername="170.0.0.2";
$database="tienda";
$unsername="root";
$pass="root";

// Conexión con la base de datos $CONEXION
$conexion=mysqli_connect($servername, $unsername, $pass);

// Comprobamos que hemos estabecido conexión en el servidor
if (! $conexion){
echo "<h2 align='center'>ERROR: Imposible establecer conección con el servidor</h2>";
exit;
}

// Comprobar si la base de datos existe y si no, la creará
$Db = mysqli_select_db ( $conexion, $database);
if(! $Db){
    echo "La base de datos NO existe, se procede a crearla\n";
    
    // Crear base de datos
    $sql="CREATE DATABASE tienda";
    if($conexion->query($sql) === true){
        echo "La base de datos ha sido creada correctamente\n";
        }else{
            die ("Ha ocurrido un error en la creacion de la base de datos: ");
            }
}else{
    echo "La base de datos SI existe\n";
    
    // Creamos la tabla  "productos" en la base de datos de "tienda"
    $sql="CREATE TABLE productos(
        codproducto SMALLINT(6) PRIMARY KEY NOT NULL,
        nombre VARCHAR(20),
        tipo VARCHAR(20),
        precio SMALLINT(2),
        timestamp TIMESTAMP
    )";

    // Comprobar que se creo la tabla
    if($conexion->query($sql) === true){
        echo "La tabla se creo correctamente";
        }else{
            die("Error al crear la tabla: " . $conexion->error);
            }
}


?>
</body>
</html>
