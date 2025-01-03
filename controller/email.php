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
        break;
 }
?>