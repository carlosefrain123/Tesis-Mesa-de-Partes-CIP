<?php

//TODO: Incluye el archivo
 require_once("../config/conexion.php");
 require_once("../models/Usuario.php");
 require_once("../models/Email.php");
 $usuario=new Usuario();
 $email=new Email();
 switch ($_GET["op"]) {
    case 'registrar':
        $datos=$usuario->get_usuario_correo($_POST["usu_correo"]);
        if (is_array($datos)==true and count($datos)==0) {
            $usuario->registrar_usuario($_POST["usu_nomape"],$_POST["usu_correo"],$_POST["usu_pass"]);
            //Email
            $email->registrar($_POST["usu_correo"]); //Reemplazar con el ID del usuario registrado
            //Identificado
            echo "1";
        }else{
            //No identificado
            echo "0";
        } 
        break;
 }
?>