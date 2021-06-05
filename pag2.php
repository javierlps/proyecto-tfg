<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Inserción Datos</title>
    <link href="estilo.css" type="text/css" rel="stylesheet">
    <link rel="icon" href="imagenes/bd.ico" type="image/ico"/>
</head>
<body>
    <h1>Formulario</h1>
<form CLASS="borde" action="pag3.php" method="post">
     <table  border="0"> 
       <tr> 
         <th><h2>Código Producto</h2></th> 
         <td>
           <input type="number" name="codproducto" size="20">
        </td> 
       </tr> 
       
       <tr> 
         <th><h2>Nombre</h2></th> 
         <td>
            <input type="text" name="nombre" size="20">
        </td> 
       </tr> 
       
       <tr> 
         <th><h2>Tipo</h2></th> 
         <td>
            <input type="text" name="tipo" size="20">
        </td> 
       </tr> 

       <tr> 
         <th><h2>Precio</h2></th> 
         <td>
            <input type="number" name="precio" size="20">
        </td> 
       </tr> 

       <tr> 
         <th><input type="submit" value="Pedido" ></th> 
       </tr> 

     </table> 
</body>
</html>

