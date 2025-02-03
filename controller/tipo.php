<?php

//TODO: Incluye el archivo
require_once("../config/conexion.php");
require_once("../models/Tipo.php");

$tipo = new Tipo();
switch ($_GET["op"]) {
    case 'combo':
        $datos=$tipo->get_tipo();
        $html="";
        $html.="<option value=''>Seleccionar</option>";
        if (is_array($datos)==true and count($datos)>0) {
            foreach ($datos as $row) {
                $html.="<option value='".$row['tip_id']."'>".$row['tip_nom']."</option>";
            }
            echo $html;
        }
        break;
    }
?>