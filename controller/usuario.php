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
            $datos1 = $usuario->registrar_usuario($_POST["usu_nomape"], $_POST["usu_correo"], $_POST["usu_pass"],"",2);
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
                
                $datos = $usuario->get_usuario_correo($email);
                if (is_array($datos) == true and count($datos) == 0) {
                    $datos1=$usuario->registrar_usuario($nombre, $email,"",$imagen,1);
                    $_SESSION["user_id"] = $datos1[0]["user_id"];
                    $_SESSION["usu_nomape"] = $nombre;
                    $_SESSION["usu_correo"] = $email;
                    $_SESSION["usu_img"] = $imagen;
                    echo "1";
                } else {
                    $user_id = $datos[0]["user_id"];
                    $_SESSION["user_id"] = $user_id;
                    $_SESSION["usu_nomape"] = $nombre;
                    $_SESSION["usu_correo"] = $email;
                    $_SESSION["usu_img"] = $imagen;
                    echo "0";                  
                }
            } else {
                echo json_encode(['error' => '¡Los datos de la cuenta no están disponibles!']);
            }
        }
        break;
}
