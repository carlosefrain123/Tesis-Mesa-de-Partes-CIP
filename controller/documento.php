<?php

//TODO: Incluye el archivo
require_once("../config/conexion.php");
require_once("../models/Documento.php");
require_once("../models/Email.php");
$documento = new Documento();
$email = new Email();
switch ($_GET["op"]) {
    case 'registrar':
        $datos = $documento->registrar_documento($_POST["area_id"], $_POST["tra_id"], $_POST["doc_externo"], $_POST["tip_id"], $_POST["doc_dni"], $_POST["doc_nom"], $_POST["doc_descrip"], $_SESSION["user_id"]);
        if (is_array($datos) == true and count($datos) == 0) {
            /* echo $datos[0]["doc_id"]; */
            echo "0";

            /* if (empty($_FILES['file']['name'])) {
                
            }else{
                $countfiles=count($_FILES['file']['name']);
                $ruta="../assets/document/"-$datos[0]["doc_id"]."/";
            } */
        } else {
            //Identificado
            /* echo json_encode($datos); */
            $mes = date("m");
            $anio = date("Y");
            echo $mes . "." . $anio . "-" . $datos[0]["doc_id"];
            if (empty($_FILES['file']['name'])) {
            } else {
                $countfiles = count($_FILES['file']['name']);
                $ruta = "../assets/document/" . $datos[0]["doc_id"] . "/";
                $file_arr = array();
                if (!file_exists($ruta)) {
                    mkdir($ruta, 0777, true);
                    for ($index = 0; $index < $countfiles; $index++) {
                        $nombre = $_FILES['file']['tmp_name'][$index];
                        $destino = $ruta . $_FILES['file']['name'][$index];
                        $documento->insert_documento_detalle($datos[0]["doc_id"], $_FILES['file']['name'][$index], $_SESSION["user_id"],'Pendiente');

                        move_uploaded_file($nombre, $destino);
                    }
                }
                //TODO: Enviar alerta por Email
                $email->enviar_registro($datos[0]["doc_id"]);
            }
        }
        /* echo json_encode($datos); */
        break;
    case 'listarusuario':
        $datos = $documento->get_documento_x_user($_SESSION["user_id"]);
        $data = array();
        foreach ($datos as $row) {
            $sub_array = array();
            $sub_array[] = $row["nrotramite"];
            $sub_array[] = $row["area_nom"];
            $sub_array[] = $row["tra_nom"];
            $sub_array[] = $row["doc_externo"];
            $sub_array[] = $row["tip_nom"];
            $sub_array[] = $row["doc_dni"];
            $sub_array[] = $row["doc_nom"];
            $sub_array[] = '<button type="button" class="btn btn-soft-primary waves-effect waves-light btn-sm" onclick="ver(' . $row["doc_id"] . ')"><i class="bx bx-message-alt-dots font-size-16 align-middle"></i></button>';
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
    case "listarxarea":
        $datos = $documento->get_documento_x_area($_POST["area_id"]);
        $data = array();
        foreach ($datos as $row) {
            $sub_array = array();
            $sub_array[] = $row["nrotramite"];
            $sub_array[] = $row["area_nom"];
            $sub_array[] = $row["tra_nom"];
            $sub_array[] = $row["doc_externo"];
            $sub_array[] = $row["tip_nom"];
            $sub_array[] = $row["doc_dni"];
            $sub_array[] = $row["doc_nom"];
            if ($row["doc_estado"] == 'Pendiente') {
                $sub_array[] = "<span class='badge bg-warning'>Pendiente</span>";
            } else if ($row["doc_estado"] == 'Terminado') {
                $sub_array[] = "<span class='badge bg-primary'>Terminado</span>";
            }
            $sub_array[] = '<button type="button" class="btn btn-soft-primary waves-effect waves-light btn-sm" onclick="ver(' . $row["doc_id"] . ')"><i class="bx bx-message-alt-dots font-size-16 align-middle"></i></button>';
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

    case "mostrar":
        $datos = $documento->get_documento_x_id($_POST["doc_id"]);
        if (is_array($datos) == true and count($datos) > 0) {
            foreach ($datos as $row) {
                $output["doc_id"] = $row["doc_id"];
                $output["area_id"] = $row["area_id"];
                $output["area_nom"] = $row["area_nom"];
                $output["area_correo"] = $row["area_correo"];
                $output["doc_externo"] = $row["doc_externo"];
                $output["doc_dni"] = $row["doc_dni"];
                $output["doc_nom"] = $row["doc_nom"];
                $output["doc_descrip"] = $row["doc_descrip"];
                $output["tra_id"] = $row["tra_id"];
                $output["tra_nom"] = $row["tra_nom"];
                $output["tip_id"] = $row["tip_id"];
                $output["tip_nom"] = $row["tip_nom"];
                $output["user_id"] = $row["user_id"];
                $output["usu_nomape"] = $row["usu_nomape"];
                $output["usu_correo"] = $row["usu_correo"];
                $output["cant"] = $row["cant"];
                $output["nrotramite"] = $row["nrotramite"];
                $output["doc_estado"] = $row["doc_estado"];
                /*$output["doc_respuesta"] = $row["doc_respuesta"]; */
            }
            echo json_encode($output);
        }
        break;
    case "listardetalle":
        $datos = $documento->get_documento_detalle_x_doc_id($_POST["doc_id"] , $_POST["det_tipo"] );
        $data = array();
        foreach ($datos as $row) {
            $sub_array = array();
            $sub_array[] = $row["det_nom"];
            $sub_array[] = $row["fech_crea"];
            $sub_array[] = $row["usu_nomape"];
            $sub_array[] = "<div class='avatar-sm flex-shrink-0 me-3'><img src='" . $row["usu_img"] . "' alt='' class='img-thumbnail rounded-circle'></div>";
            $sub_array[] = '<a class="btn btn-soft-primary waves-effect waves-light btn-sm" href="../../assets/document/' . $row["doc_id"] . '/' . $row["det_nom"] . '" target="_blank" download><i class="bx bx-search-alt font-size-16 align-middle"></i></a>';
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
}
