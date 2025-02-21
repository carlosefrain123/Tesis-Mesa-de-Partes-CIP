<?php

//TODO: Incluye el archivo
require_once("../config/conexion.php");
require_once("../models/Usuario.php");
require_once("../models/Email.php");
$usuario = new Usuario();
$email = new Email();
switch ($_GET["op"]) {
    case 'registrar':
        $datos = $usuario->get_usuario_correo($_POST["usu_correo"]);
        if (is_array($datos) == true and count($datos) == 0) {
            $datos1 = $usuario->registrar_usuario($_POST["usu_nomape"], $_POST["usu_correo"], $_POST["usu_pass"], "", 2);
            //Email
            $email->registrar($datos1[0]["user_id"]); //Reemplazar con el ID del usuario registrado. Tambien se cambio
            //Identificado
            echo "1";
        } else {
            //No identificado
            echo "0";
        }
        break;

    case "activar":
        $usuario->activar_usuario($_POST["user_id"]);
        break;

    case "registrargoogle":
        if ($_SERVER["REQUEST_METHOD"] == "POST" && $_SERVER["CONTENT_TYPE"] == "application/json") {
            $jsonStr = file_get_contents('php://input');
            $jsonObj = json_decode($jsonStr);

            if (!empty($jsonObj->request_type) && $jsonObj->request_type == 'user_auth') {
                $credential = !empty($jsonObj->credential) ? $jsonObj->credential : '';

                //TODO: Decodificar el payload de la respuesta desde el token JWT
                $parts = explode(".", $credential);
                $header = base64_decode($parts[0]);
                $payload = base64_decode($parts[1]);
                $signature = base64_decode($parts[2]);

                $responsePayload = json_decode($payload);

                if (!empty($responsePayload)) {
                    //TODO: Información del perfil del usuario
                    $nombre = !empty($responsePayload->name) ? $responsePayload->name : '';
                    $email = !empty($responsePayload->email) ? $responsePayload->email : '';
                    $imagen = !empty($responsePayload->picture) ? $responsePayload->picture : '';
                }
                //CAMBIO
                $datos = $usuario->get_usuario_correo($email);

                if (is_array($datos) && count($datos) == 0) {
                    $datos1 = $usuario->registrar_usuario($nombre, $email, "", $imagen, 1);

                    $_SESSION["user_id"] = $datos1[0]["user_id"];
                    $_SESSION["usu_nomape"] = $nombre;
                    $_SESSION["usu_correo"] = $email;
                    $_SESSION["usu_img"] = $imagen;
                    $_SESSION["rol_id"] = $datos[0]["rol_id"];

                    echo "1"; // Acceso permitido
                } else {
                    $user_id = $datos[0]["user_id"];
                    $_SESSION["user_id"] = $user_id;
                    $_SESSION["usu_nomape"] = $nombre;
                    $_SESSION["usu_correo"] = $email;
                    $_SESSION["usu_img"] = $imagen;
                    $_SESSION["rol_id"] = $datos[0]["rol_id"];

                    echo "0"; // Nuevo usuario registrado
                }


                //FIN CAMBIO
            } else {
                echo json_encode(['error' => '¡Los datos de la cuenta no están disponibles!']);
            }
        }
        break;
    case "colaboradorgoogle":
        if ($_SERVER["REQUEST_METHOD"] == "POST" && $_SERVER["CONTENT_TYPE"] == "application/json") {
            $jsonStr = file_get_contents('php://input');
            $jsonObj = json_decode($jsonStr);

            if (!empty($jsonObj->request_type) && $jsonObj->request_type == 'user_auth') {
                $credential = !empty($jsonObj->credential) ? $jsonObj->credential : '';

                //TODO: Decodificar el payload de la respuesta desde el token JWT
                $parts = explode(".", $credential);
                $header = base64_decode($parts[0]);
                $payload = base64_decode($parts[1]);
                $signature = base64_decode($parts[2]);

                $responsePayload = json_decode($payload);

                if (!empty($responsePayload)) {
                    //TODO: Información del perfil del usuario
                    $nombre = !empty($responsePayload->name) ? $responsePayload->name : '';
                    $email = !empty($responsePayload->email) ? $responsePayload->email : '';
                    $imagen = !empty($responsePayload->picture) ? $responsePayload->picture : '';
                }
                //Por el momento todo tranqui
                $datos = $usuario->get_usuario_correo($email);
                if (is_array($datos) && count($datos) == 0) {
                    echo "1"; // Acceso permitido
                } else {
                    $user_id = $datos[0]["user_id"];
                    $_SESSION["user_id"] = $user_id;
                    $_SESSION["usu_nomape"] = $nombre;
                    $_SESSION["usu_correo"] = $email;
                    $_SESSION["usu_img"] = $imagen;
                    $_SESSION["rol_id"] = $datos[0]["rol_id"];

                    echo "0"; // Nuevo usuario registrado
                }
            } else {
                echo json_encode(['error' => '¡Los datos de la cuenta no están disponibles!']);
            }
        }
        break;
        /* case 'guardaryeditar':
        $datos = $usuario->get_usuario_correo($_POST["usu_correo"]);
        if (is_array($datos) == true and count($datos) == 0) {
            if (empty($_POST["user_id"])) {
                $datos1 = $usuario->insert_colaborador($_POST["usu_nomape"], $_POST["usu_correo"],  $_POST["rol_id"]); */
        //Email
        /* $email->registrar($datos1[0]["user_id"]);  */ //Reemplazar con el ID del usuario registrado. Tambien se cambio
        //Identificado
        /* echo "1";
            } else {
                $usuario->update_colaborador($_POST["user_id"], $_POST["usu_nomape"], $_POST["usu_correo"],  $_POST["rol_id"]);
                echo "2"; // Actualizado con éxito
            }
        } else {
            //No identificado
            echo "0";
        }
        break; */
    case 'guardaryeditar':
        $user_id = isset($_POST["user_id"]) ? trim($_POST["user_id"]) : "";
        $usu_nomape = isset($_POST["usu_nomape"]) ? trim($_POST["usu_nomape"]) : "";
        $usu_correo = isset($_POST["usu_correo"]) ? trim($_POST["usu_correo"]) : "";
        $rol_id = isset($_POST["rol_id"]) ? trim($_POST["rol_id"]) : "";

        // Verificamos si el correo ya existe en otro usuario
        $datos = $usuario->get_usuario_correo($usu_correo);

        if (empty($user_id)) {
            // Registro nuevo
            if (is_array($datos) && count($datos) == 0) {
                $datos1 = $usuario->insert_colaborador($usu_nomape, $usu_correo, $rol_id);
                echo "1"; // Insertado con éxito
            } else {
                echo "0"; // Correo ya existe
            }
        } else {
            // Edición: validamos que el correo no esté en otro usuario
            if (is_array($datos) && count($datos) > 0 && $datos[0]["user_id"] != $user_id) {
                echo "0"; // Correo ya existe en otro usuario
            } else {
                $usuario->update_colaborador($user_id, $usu_nomape, $usu_correo, $rol_id);
                echo "2"; // Actualizado con éxito
            }
        }
        break;

    case "mostrar":
        $datos = $usuario->get_usuario_id($_POST["user_id"]);
        if (is_array($datos) == true and count($datos) > 0) {
            foreach ($datos as $row) {
                $output["user_id"] = $row["user_id"];
                $output["usu_nomape"] = $row["usu_nomape"];
                $output["usu_correo"] = $row["usu_correo"];
                $output["rol_id"] = $row["rol_id"];
            }
            echo json_encode($output);
        }
        break;
    case "eliminar":
        $usuario->eliminar_colaborador($_POST["user_id"]);
        echo "1";
        break;
    case 'listar':
        $datos = $usuario->get_colaborador();
        $data = array(); //Por sea caso
        foreach ($datos as $row) {
            $sub_array = array();
            $sub_array[] = $row["usu_nomape"];
            $sub_array[] = $row["usu_correo"];
            $sub_array[] = $row["rol_nom"];
            $sub_array[] = $row["fech_crea"];
            $sub_array[] = '<button type="button" class="btn btn-soft-warning waves-effect waves-light btn-sm" onclick="editar(' . $row["user_id"] . ')"><i class="bx bx-edit-alt font-size-16 align-middle"></i></button>';
            $sub_array[] = '<button type="button" class="btn btn-soft-danger waves-effect waves-light btn-sm" onclick="eliminar(' . $row["user_id"] . ')"><i class="bx bx-trash-alt font-size-16 align-middle"></i></button>';
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
