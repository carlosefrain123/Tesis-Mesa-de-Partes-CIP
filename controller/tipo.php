<?php

//TODO: Incluye el archivo
require_once("../config/conexion.php");
require_once("../models/Tipo.php");

$tipo = new Tipo();
switch ($_GET["op"]) {
    case 'combo':
        $datos = $tipo->get_tipo();
        $html = "";
        $html .= "<option value=''>Seleccionar</option>";
        if (is_array($datos) == true and count($datos) > 0) {
            foreach ($datos as $row) {
                $html .= "<option value='" . $row['tip_id'] . "'>" . $row['tip_nom'] . "</option>";
            }
            echo $html;
        }
        break;

    case 'listar':
        $datos = $tipo->get_tipo();
        $data = array();
        foreach ($datos as $row) {
            $sub_array = array();
            $sub_array[] = $row["tip_nom"];
            $sub_array[] = $row["fech_crea"];
            $sub_array[] = '<button type="button" class="btn btn-soft-warning waves-effect waves-light btn-sm" onclick="editar(' . $row["tip_id"] . ')"><i class="bx bx-edit-alt font-size-16 align-middle"></i></button>';
            $sub_array[] = '<button type="button" class="btn btn-soft-danger waves-effect waves-light btn-sm" onclick="eliminar(' . $row["tip_id"] . ')"><i class="bx bx-trash-alt font-size-16 align-middle"></i></button>';
            $data[] = $sub_array;
        }
        $results = array(
            "sEcho" => 1,
            "iTotalRecords" => count($data),
            "iTotalDisplayRecords" => count($data),
            "aaData" => $data
        );
        echo json_encode($results);
        break;
    case "guardaryeditar":
        $datos = $tipo->get_tipo_nombre($_POST["tip_nom"]);
        if (is_array($datos) == true and count($datos) == 0) {
            if (empty($_POST["tip_id"])) {
                $tipo->insert_tipo($_POST["tip_nom"]);
                echo "1";
            } else {
                $tipo->update_tipo($_POST["tip_id"], $_POST["tip_nom"]);
                echo "2";
            }
        } else {
            echo "0";
        }

        break;
    case "mostrar":
        $datos = $tipo->get_tipo_x_id($_POST["tip_id"]);
        if (is_array($datos) == true and count($datos) > 0) {
            foreach ($datos as $row) {
                $output["tip_id"] = $row["tip_id"];
                $output["tip_nom"] = $row["tip_nom"];
            }
            echo json_encode($output);
        }
        break;
    case "eliminar":
        $tipo->eliminar_tipo($_POST["tip_id"]);
        echo "1";
        break;
}
