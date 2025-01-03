<?php

//TODO: Incluye el archivo
 require_once("../config/conexion.php");
 require_once("../models/Usuario.php");
 require_once("../models/Email.php");
 $usuario=new Usuario();
 $email=new Email();
 switch ($_GET["op"]) {
    case 'recuperar':
        $email->recuperar($_POST["usu_correo"]);
        $datos=$usuario->get_usuario_correo($_POST["usu_correo"]);
        if (is_array($datos)==true and count($datos)==0) { 
            echo "0";
        }else{
            echo "1"; 
        }
        break;
 }
?>