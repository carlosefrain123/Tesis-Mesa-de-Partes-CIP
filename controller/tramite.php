<?php

//TODO: Incluye el archivo
require_once("../config/conexion.php");
require_once("../models/Tramite.php");

$tramite = new Tramite();
switch ($_GET["op"]) {
    case 'combo':
        $datos=$tramite->get_tramite();
        $html="";
        $html.="<option value=''>Seleccionar</option>";
        if (is_array($datos)==true and count($datos)>0) {
            foreach ($datos as $row) {
                $html.="<option value='".$row['tra_id']."'>".$row['tra_nom']."</option>";
            }
            echo $html;
        }
        break;
    }
?>