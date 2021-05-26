<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Inserción Datos</title>
</head>
<body>
<form action="pag2.php" method="post">
    <p>Codigo Producto:<input type="number" name="codproducto"></p>
    <p>Nombre:<input type="text" name="nombre"></p>
    <p>Tipo:<input type="text" name="tipo"></p>
    <p>Precio:<input type="number" name="precio"></p>
    <input type="submit" value="Pedido">
</form>
<br>
<?php
// Ignorar mensajes de advertencia
error_reporting(0);

// Variables de datos para la conexión
$servername="170.0.0.2";
$database="tienda";
$unsername="root";
$pass="root";

// Conexión con la base de datos $CONEXION
$conexion=mysqli_connect($servername, $unsername, $pass, $database);

// Validar datos insertados en la tabla
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

// Mostrar contenmido en una tabla
if ($nfilas > 0)
{
    print ("<table border='5' width='650' >\n");
    print ("<tr>\n");
    print ("<th width='100'>CodProducto</th>\n");
    print ("<th width='100'>Nombre</th>\n");
    print ("<th width='100'>Tipo</th>\n");
    print ("<th width='100'>Precio</th>\n");
    print ("</tr>\n");
    print ("</table>\n");
  
    for ($i=0; $i<$nfilas; $i++)
    {
        $resultado=mysqli_fetch_array ($consulta);
        print ("<table border='5' width='650' >\n");
        print ("<TR>\n");
        print ("<TD width='100'>" . $resultado['codproducto'] . "</TD>\n");
        print ("<TD width='100'>" . $resultado['nombre'] . "</TD>\n");
        print ("<TD width='100'>" . $resultado['tipo'] . "</TD>\n");
        print ("<TD width='100'>" . $resultado['precio'] . "</TD>\n");
        print ("</TR>\n");
        print ("</table>\n");
    }
}
?>
</body>
</html>
