<?php
    require_once("../../config/conexion.php");
    
    session_start(); // Asegurar que la sesión está iniciada

    $rol_id = isset($_SESSION["rol_id"]) ? $_SESSION["rol_id"] : null; // Guardar rol antes de destruir la sesión

    session_destroy(); // Ahora sí, destruir la sesión

    if ($rol_id == 1) {
        header("Location:".Conectar::ruta()."index.php");
    } elseif ($rol_id == 2 || $rol_id == 3) {
        header("Location:".Conectar::ruta()."view/accesopersonal/index.php");
    } else {
        header("Location:".Conectar::ruta()."index.php"); // Redirección por defecto si no hay rol
    }

    exit();
?>
