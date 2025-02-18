<?php

//TODO: Incluye el archivo
require_once("../config/conexion.php");
require_once("../models/Tramite.php");

$tramite = new Tramite();
switch ($_GET["op"]) {
    case 'combo':
        $datos = $tramite->get_tramite();
        $html = "";
        $html .= "<option value=''>Seleccionar</option>";
        if (is_array($datos) == true and count($datos) > 0) {
            foreach ($datos as $row) {
                $html .= "<option value='" . $row['tra_id'] . "'>" . $row['tra_nom'] . "</option>";
            }
            echo $html;
        }
        break;
    case 'listar':
        $datos = $tramite->get_tramite();
        $data = array();
        foreach ($datos as $row) {
            $sub_array = array();
            $sub_array[] = $row["tra_nom"];
            $sub_array[] = substr($row["tra_descrip"],0,15)."...";
            $sub_array[] = $row["fech_crea"];
            $sub_array[] = '<button type="button" class="btn btn-soft-warning waves-effect waves-light btn-sm" onclick="editar(' . $row["tra_id"] . ')"><i class="bx bx-edit-alt font-size-16 align-middle"></i></button>';
            $sub_array[] = '<button type="button" class="btn btn-soft-danger waves-effect waves-light btn-sm" onclick="eliminar(' . $row["tra_id"] . ')"><i class="bx bx-trash-alt font-size-16 align-middle"></i></button>';
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
        /* case "guardaryeditar":
            $datos = $tramite->get_tra_nombre($_POST["tra_nom"]);
            if (is_array($datos) == true and count($datos) == 0) {
                if (empty($_POST["tra_id"])) {
                    $tramite->insert_tramite($_POST["tra_nom"], $_POST["tra_descrip"]);
                    echo "1";
                } else {
                    $tramite->update_tramite($_POST["tra_id"], $_POST["tra_nom"], $_POST["tra_descrip"]);
                    echo "2";
                }
            } else {
                echo "0";
            }
    
            break; */
    case "guardaryeditar":
        if (empty($_POST["tra_id"])) {
            // Registro nuevo: validamos si el nombre ya existe
            $datos_nombre = $tramite->get_tra_nombre($_POST["tra_nom"]);
            if (count($datos_nombre) > 0) {
                echo "0"; // Ya existe el nombre
            } else {
                $tramite->insert_tramite($_POST["tra_nom"], $_POST["tra_descrip"]);
                echo "1"; // Insertado con éxito
            }
        } else {
            // Edición: verificamos si el nombre está en otra área
            $datos_nombre = $tramite->get_tra_nombre($_POST["tra_nom"]);
            if (count($datos_nombre) > 0 && $datos_nombre[0]["tra_id"] != $_POST["tra_id"]) {
                echo "0"; // Nombre ya existe en otra área
            } else {
                $tramite->update_tramite($_POST["tra_id"], $_POST["tra_nom"], $_POST["tra_descrip"]);
                echo "2"; // Actualizado con éxito
            }
        }
        break;

    case "mostrar":
        $datos = $tramite->get_tra_x_id($_POST["tra_id"]);
        if (is_array($datos) == true and count($datos) > 0) {
            foreach ($datos as $row) {
                $output["tra_id"] = $row["tra_id"];
                $output["tra_nom"] = $row["tra_nom"];
                $output["tra_descrip"] = $row["tra_descrip"];
            }
            echo json_encode($output);
        }
        break;
    case "eliminar":
        $tramite->eliminar_tramite($_POST["tra_id"]);
        echo "1";
        break;
}
