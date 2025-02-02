<?php

//TODO: Incluye el archivo
require_once("../config/conexion.php");
require_once("../models/Documento.php");
require_once("../models/Email.php");
$documento = new Documento();
$email = new Email();
switch ($_GET["op"]) {
    case 'registrar':
        $datos = $documento->registrar_documento($_POST["area_id"],$_POST["tra_id"],$_POST["doc_externo"],$_POST["tip_id"],$_POST["doc_dni"],$_POST["doc_nom"],$_POST["doc_descrip"],$_SESSION["user_id"]);
        if (is_array($datos) == true and count($datos) == 0) {
            echo $datos[0]["doc_id"];
        } else {
            //No identificado
            echo "0";
        }
       /* echo json_encode($datos); */
        break;
}
