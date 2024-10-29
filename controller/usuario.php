<?php
//TODO: Incluye el archivo
 require_once("../config/conexion.php");
 require_once("../models/Usuario.php");
 $usuario=new Usuario();
 switch ($_GET["op"]) {
    case 'registrar':
        $datos=$usuario->get_usuario_correo($_POST["usu_correo"]);
        if (is_array($datos)==true and count($datos)==0) {
            $usuario->registrar_usuario($_POST["usu_nomape"],$_POST["usu_correo"],$_POST["usu_pass"]);
            echo "1";
        }else{
            echo "0";
        } 
        break;
 }
?>