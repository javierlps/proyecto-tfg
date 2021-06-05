<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Base de Datos</title>
    <link href="estilo.css" type="text/css" rel="stylesheet">
    <link rel="icon" href="imagenes/bd.ico" type="image/ico"/>
</head>
<body>
<?php
// Ignorar mensajes de advertencia
error_reporting(0);

// Variables de datos para la conexión
$servername="10.0.0.20";
$database="tienda";
$unsername="root";
$pass="root";

// Conexión con la base de datos $CONEXION
$conexion=mysqli_connect($servername, $unsername, $pass, $database);

// Validar los datos insertados en la tabla
if(isset($_POST['codproducto'])){
    $codproducto=$_POST['codproducto'];
    if(isset($_POST['nombre'])){
        $nombre=$_POST['nombre'];
        if(isset($_POST['tipo'])){
            $tipo=$_POST['tipo'];
            if(isset($_POST['precio'])){
                $precio=$_POST['precio'];

                // Sentencia sql para insertar en la tabla productos
                $sql="INSERT INTO productos(codproducto, nombre, tipo, precio)
                      VALUES('$codproducto', '$nombre', '$tipo', '$precio')";
                // Verificación de los datos
                if($conexion->query($sql) === true){
                    echo "Datos introducidos correctamente";
                }
            }
        }
    }
}
echo "<hr>";
// Mostrar los datos introducidos en la tabla productos de la base de datos Tienda
// Enviar consulta a la base de datos $INSTRUCCION
$instruccion="SELECT * FROM productos";

// Almacena la consulta $CONSULTA
$consulta=mysqli_query($conexion, $instruccion)
or die ("Fallo a la hora de ejecutar la consulta");

// Variable que guarda el numero de filas que da como resultado la variable $CONSULTA
// Mostrar los resultados en variable $NFILAS
$nfilas=mysqli_num_rows($consulta);

/* Mostrar contenmido en una tabla. Se almacenara la fila o registro en la variable nfilas, se añade 
a un bucle que va recogiendo la información y la va imprimiendo en una tabla, fila a fila*/
print "<h1><center>Base de datos</h1>";
if ($nfilas > 0)
{
    print ("<table class=borde border='5' align=center>");
    print ("<tr>");
    print ("<th >CodProducto</th>");
    print ("<th >Nombre</th>");
    print ("<th >Tipo</th>");
    print ("<th >Precio</th>");
    print ("</tr>");
    print ("</table>");
  
    for ($i=0; $i<$nfilas; $i++)
    {
        $resultado=mysqli_fetch_array ($consulta);
        print ("<table class=borde border='5' align=center>");
        print ("<TR>");
        print ("<TD >" . $resultado['codproducto'] . "</TD>");
        print ("<TD >" . $resultado['nombre'] . "</TD>");
        print ("<TD >" . $resultado['tipo'] . "</TD>");
        print ("<TD >" . $resultado['precio'] . "</TD>");
        print ("</TR>");
        print ("</table>");
    }
}
?>
</body>
</html>
