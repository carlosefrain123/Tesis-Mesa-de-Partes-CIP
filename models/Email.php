<?php
require '../include/vendor/autoload.php';
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require_once("../config/conexion.php");
require_once("../models/Usuario.php");
require_once("../models/Documento.php");

/**Mesa de Partes */
class Email extends PHPMailer{
    protected $gCorreo='carlosefrain777@limpiobe.net';
    protected $gContrasena='Mesadepartes@7';
    //Muy importante
    private $key="MesaDePartesCIP";
    private $cipher="aes-256-cbc";
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
    public function recuperar($usu_correo){
        $conexion=new Conectar();
        $usuario=new Usuario();
        $datos=$usuario->get_usuario_correo($usu_correo);

        /* $iv=openssl_random_pseudo_bytes(openssl_cipher_iv_length($this->cipher));
        $cifrado=openssl_encrypt($user_id,$this->cipher,$this->key,OPENSSL_RAW_DATA,$iv);
        $textoCifrado=base64_encode($iv.$cifrado); */

        $this->IsSMTP();
        $this->Host='smtp.hostinger.com';
        $this->Port=465;
        $this->SMTPAuth=true;
        $this->SMTPSecure='ssl';
        
        $this->Username=$this->gCorreo;
        $this->Password=$this->gContrasena;
        $this->setFrom($this->gCorreo,"Recuperar Contraseña mesa de partes Efrain");

        $this->CharSet='UTF8';
        /* $this->addAddress($usu_correo); */
        $this->addAddress($datos[0]["usu_correo"]);
        $this->IsHTML(true);
        $this->Subject="Mesa de Partes";

        $url=$conexion->ruta();

        $xpassusu=$this->generarXPassUsu();

        $usuario->recuperar_usuario($usu_correo,$xpassusu);

        $cuerpo=file_get_contents("../assets/email/recuperar.html");
        $cuerpo=str_replace('xpassusu',$xpassusu,$cuerpo);
        $cuerpo=str_replace('xlinksistema',$url,$cuerpo);

        $this->Body=$cuerpo;
        $this->AltBody=strip_tags("Recuperar Contraseña");

        try {
            $this->send();
            return true;
        } catch (Exception $e) {
            return false;
        }
    }
    private function generarXPassUsu(){
        $parteAlfanumerica=substr(md5(rand()),0,3);
        $parteNumerica=str_pad(rand(0,999),3,'0',STR_PAD_LEFT);
        $resultado=$parteAlfanumerica.$parteNumerica;
        return substr($resultado,0,6);
    }
    public function enviar_registro($doc_id){
        $conexion=new Conectar();
        $documento=new Documento();
        $datos=$documento->get_documento_x_id($doc_id);

        /* $iv=openssl_random_pseudo_bytes(openssl_cipher_iv_length($this->cipher));
        $cifrado=openssl_encrypt($user_id,$this->cipher,$this->key,OPENSSL_RAW_DATA,$iv);
        $textoCifrado=base64_encode($iv.$cifrado); */

        $this->IsSMTP();
        $this->Host='smtp.hostinger.com';
        $this->Port=465;
        $this->SMTPAuth=true;
        $this->SMTPSecure='ssl';
        
        $this->Username=$this->gCorreo;
        $this->Password=$this->gContrasena;
        $this->setFrom($this->gCorreo,"Nuevo Tramite Mesa de partes Efrain");

        $this->CharSet='UTF8';
        /* $this->addAddress($usu_correo); */
        $this->addAddress($datos[0]["usu_correo"]);
        $this->addAddress($datos[0]["area_correo"]);

        $this->IsHTML(true);
        $this->Subject="Mesa de Partes";

        $url=$conexion->ruta();

        $cuerpo=file_get_contents("../assets/email/enviar.html");
        $cuerpo=str_replace('xlinksistema',$url,$cuerpo);

        $cuerpo=str_replace('xnrotramite',$datos[0]["nrotramite"],$cuerpo);
        $cuerpo=str_replace('xarea',$datos[0]["area_nom"],$cuerpo);
        $cuerpo=str_replace('xtramite',$datos[0]["tra_nom"],$cuerpo);
        $cuerpo=str_replace('xnroexterno',$datos[0]["doc_externo"],$cuerpo);
        $cuerpo=str_replace('xtipo',$datos[0]["tip_id"],$cuerpo);
        $cuerpo=str_replace('xcant',$datos[0]["cant"],$cuerpo);



        $this->Body=$cuerpo;
        $this->AltBody=strip_tags("Enviar Registro ");

        try {
            $this->send();
            return true;
        } catch (Exception $e) {
            return false;
        }
    }
}
?>