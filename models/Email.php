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
    //Muy importante
    protected $key="MesaDePartesCIP";
    protected $cipher="aes-256-cbc";
    public function registrar($user_id){
        $conexion=new Conectar();
        $usuario=new Usuario();
        $datos=$usuario->get_usuario_id($user_id);

        $iv=openssl_random_pseudo_bytes(openssl_cipher_iv_length($this->cipher));
        $cifrado=openssl_encrypt($user_id,$this->cipher,$this->key,OPENSSL_RAW_DATA,$iv);
        $textoCifrado=base64_encode($iv.$cifrado);

        $this->IsSMTP();
        $this->Host='smtp.hostinger.com';
        $this->Port=465;
        $this->SMTPAuth=true;
        $this->SMTPSecure='ssl';
        
        $this->Username=$this->gCorreo;
        $this->Password=$this->gContrasena;
        $this->setFrom($this->gCorreo,"Registro en mesa de partes Efrain");

        $this->CharSet='UTF8';
        /* $this->addAddress($usu_correo); */
        $this->addAddress($datos[0]["usu_correo"]);
        $this->IsHTML(true);
        $this->Subject="Registro en mesa de partes Efrain";

        $cuerpo=file_get_contents("../assets/email/registrar.html");
        $url=$conexion->ruta().'view/confirmar/?id='.$textoCifrado;
        $cuerpo=str_replace('xlinkcorreourl',$url,$cuerpo);

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