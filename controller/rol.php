<?php

//TODO: Incluye el archivo
require_once("../config/conexion.php");
require_once("../models/Rol.php");

$rol = new Rol();
switch ($_GET["op"]) {
    case 'combo':
        $datos = $rol->get_rol();
        $html = "";
        $html .= "<option value=''>Seleccionar</option>";
        if (is_array($datos) == true and count($datos) > 0) {
            foreach ($datos as $row) {
                $html .= "<option value='" . $row['rol_id'] . "'>" . $row['rol_nom'] . "</option>";
            }
            echo $html;
        }
        break;
}
