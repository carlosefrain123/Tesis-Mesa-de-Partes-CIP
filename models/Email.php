<?php
require '../include/vendor/autoload.php';
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require_once("../config/conexion.php");
require_once("../models/Usuario.php");
/**Mesa de Partes */
class Email extends PHPMailer{
    protected $gCorreo='carlosefrain777@limpiobe.net';
    protected $gContrasena='Mesadepartes@7';

    public function registrar($usu_id){
        $this->IsSMTP();
        $this->Host='smtp.hostinger.com';
        $this->Port=465;
        $this->SMTPAuth=true;
        $this->SMTPSecure='ssl';
        
        $this->Username=$this->gCorreo;
        $this->Password=$this->gContrasena;
        $this->setFrom($this->gCorreo,"Registro en mesa de partes Efrain");

        $this->CharSet='UTF8';
        $this->addAddress("Carloschallo1@hotmail.com");
        $this->IsHTML(true);
        $this->Subject="Registro en mesa de partes Efrain";

        $cuerpo=file_get_contents("../assets/email/registrar.html");
        $cuerpo=str_replace('xusuariocorreo',$usu_id,$cuerpo);

        $this->Body=$cuerpo;
        $this->AltBody=strip_tags("Confirmar Registro");

        try {
            $this->send();
            return true;
        } catch (Exception $e) {
            return false;
        }
    }
}
?>