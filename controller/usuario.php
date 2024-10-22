<?php
//TODO: Incluye el archivo
 require_once("../config/conexion.php");
 require_once("../models/Usuario.php");
 $usuario=new Usuario();
 switch ($_GET["op"]) {
    case 'registrar':
        $usuario->registrar_usuario($_POST["usu_nomape"],$_POST["usu_correo"],$_POST["usu_pass"]);
        break;
 }
?>