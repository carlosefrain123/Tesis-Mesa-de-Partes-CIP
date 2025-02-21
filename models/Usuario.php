<?php
class Usuario extends Conectar
{
    private $key = "MesaDePartesCIP";
    private $cipher = "aes-256-cbc";
    public function login()
    {
        $conectar = parent::conexion();
        parent::set_names();
        if (isset($_POST["enviar"])) {
            $correo = $_POST["usu_correo"];
            $pass = $_POST["usu_pass"];
            if (empty($correo) and empty($pass)) {
                header("Location:" . conectar::ruta() . "index.php?m=2");
                exit();
            } else {
                $sql = "SELECT * FROM tm_usuario
                WHERE usu_correo=? AND rol_id=1";
                $sql = $conectar->prepare($sql);
                $sql->bindValue(1, $correo);
                $sql->execute();
                $resultado = $sql->fetch();
                if ($resultado) {
                    $textoCifrado = $resultado["usu_pass"];
                    $iv_dec = substr(base64_decode($textoCifrado), 0, openssl_cipher_iv_length($this->cipher));
                    $cifradoSinIV = substr(base64_decode($textoCifrado), openssl_cipher_iv_length($this->cipher));
                    $textoDecifrado = openssl_decrypt($cifradoSinIV, $this->cipher, $this->key, OPENSSL_RAW_DATA, $iv_dec);

                    if ($textoDecifrado == $pass) {
                        if (is_array($resultado) and count($resultado) > 0) {
                            $_SESSION["user_id"] = $resultado["user_id"];
                            $_SESSION["usu_nomape"] = $resultado["usu_nomape"];
                            $_SESSION["usu_correo"] = $resultado["usu_correo"];
                            $_SESSION["usu_img"] = $resultado["usu_img"];
                            $_SESSION["rol_id"] = $resultado["rol_id"];
                            header("Location:" . Conectar::ruta() . "view/homecolaborador/");
                            exit();
                        }
                    } else {
                        header("Location: " . Conectar::ruta() . "index.php?m=3");
                        exit();
                    }
                } else {
                    header("Location:" . Conectar::ruta() . "index.php?m=1");
                    exit();
                }
            }
        }
    }
    public function login_colaborador()
    {
        $conectar = parent::conexion();
        parent::set_names();
        if (isset($_POST["enviar"])) {
            $correo = $_POST["usu_correo"];
            $pass = $_POST["usu_pass"];
            if (empty($correo) and empty($pass)) {
                header("Location:" . conectar::ruta() . "view/accesopersonal/index.php?m=2");
                exit();
            } else {
                //TODO CAMBIO para el rol 3
                $sql = "SELECT * FROM tm_usuario
                WHERE usu_correo=? AND rol_id IN (2,3)";
                $sql = $conectar->prepare($sql);
                $sql->bindValue(1, $correo);
                $sql->execute();
                $resultado = $sql->fetch();
                if ($resultado) {
                    $textoCifrado = $resultado["usu_pass"];
                    $iv_dec = substr(base64_decode($textoCifrado), 0, openssl_cipher_iv_length($this->cipher));
                    $cifradoSinIV = substr(base64_decode($textoCifrado), openssl_cipher_iv_length($this->cipher));
                    $textoDecifrado = openssl_decrypt($cifradoSinIV, $this->cipher, $this->key, OPENSSL_RAW_DATA, $iv_dec);

                    if ($textoDecifrado == $pass) {
                        if (is_array($resultado) and count($resultado) > 0) {
                            $_SESSION["user_id"] = $resultado["user_id"];
                            $_SESSION["usu_nomape"] = $resultado["usu_nomape"];
                            $_SESSION["usu_correo"] = $resultado["usu_correo"];
                            $_SESSION["usu_img"] = $resultado["usu_img"];
                            $_SESSION["rol_id"] = $resultado["rol_id"];
                            header("Location:" . Conectar::ruta() . "view/Home/");
                            exit();
                        }
                    } else {
                        header("Location: " . Conectar::ruta() . "view/accesopersonal/index.php?m=3");
                        exit();
                    }
                } else {
                    header("Location:" . Conectar::ruta() . "view/accesopersonal/index.php?m=1");
                    exit();
                }
            }
        }
    }
    public function registrar_usuario($usu_nomape, $usu_correo, $usu_pass, $usu_img, $est)
    {
        $iv = openssl_random_pseudo_bytes(openssl_cipher_iv_length($this->cipher));
        $cifrado = openssl_encrypt($usu_pass, $this->cipher, $this->key, OPENSSL_RAW_DATA, $iv);
        $textoCifrado = base64_encode($iv . $cifrado);
        $conectar = parent::conexion();
        parent::set_names();
        $sql = "INSERT INTO tm_usuario (usu_nomape,usu_correo,usu_pass,usu_img,rol_id,est) VALUES (?,?,?,?,1,?)";
        $sql = $conectar->prepare($sql);
        $sql->bindValue(1, $usu_nomape);
        $sql->bindValue(2, $usu_correo);
        $sql->bindValue(3, $textoCifrado);
        $sql->bindValue(4, $usu_img);
        $sql->bindValue(5, $est);
        $sql->execute();

        $sql1 = "select last_insert_id() as 'user_id'";/* CAMBIO */
        $sql1 = $conectar->prepare($sql1);
        $sql1->execute();
        return $sql1->fetchAll();
    }
    //TODO: Detecta si no se repite el correo
    //Cambio
    public function get_usuario_correo($usu_correo)
    {
        $conectar = parent::conexion();
        parent::set_names();
        $sql = "SELECT * FROM tm_usuario WHERE usu_correo=?";
        $sql = $conectar->prepare($sql);
        $sql->bindValue(1, $usu_correo);
        $sql->execute();
        return $sql->fetchAll();
    }

    //Fin cambio
    public function get_usuario_id($user_id)
    {
        $conectar = parent::conexion();
        parent::set_names();
        $sql = "SELECT * FROM tm_usuario 
        WHERE user_id=?";
        $sql = $conectar->prepare($sql);
        $sql->bindValue(1, $user_id);
        $sql->execute();
        return $sql->fetchAll();
    }
    public function activar_usuario($user_id)
    {
        $iv_dec = substr(base64_decode($user_id), 0, openssl_cipher_iv_length($this->cipher));
        $cifradoSinIV = substr(base64_decode($user_id), openssl_cipher_iv_length($this->cipher));
        $textoDecifrado = openssl_decrypt($cifradoSinIV, $this->cipher, $this->key, OPENSSL_RAW_DATA, $iv_dec);

        $conectar = parent::conexion();
        parent::set_names();
        $sql = "UPDATE tm_usuario SET est=1, fech_acti=NOW() WHERE user_id=?";
        $sql = $conectar->prepare($sql);
        $sql->bindValue(1, $textoDecifrado);
        $sql->execute();
    }
    public function recuperar_usuario($usu_correo, $usu_pass)
    {
        $iv = openssl_random_pseudo_bytes(openssl_cipher_iv_length($this->cipher));
        $cifrado = openssl_encrypt($usu_pass, $this->cipher, $this->key, OPENSSL_RAW_DATA, $iv);
        $textoCifrado = base64_encode($iv . $cifrado);

        $conectar = parent::conexion();
        parent::set_names();
        $sql = "UPDATE tm_usuario SET usu_pass=?
        WHERE
            usu_correo=?";
        $sql = $conectar->prepare($sql);
        $sql->bindValue(1, $textoCifrado);
        $sql->bindValue(2, $usu_correo);
        $sql->execute();
    }
    public function insert_colaborador($usu_nomape, $usu_correo,$rol_id)
    {
        $conectar = parent::conexion();
        parent::set_names();
        $sql = "INSERT INTO tm_usuario (usu_nomape,usu_correo,usu_img,rol_id,est) VALUES (?,?,'../../assets/picture/avatar.png',?,1)";
        $sql = $conectar->prepare($sql);
        $sql->bindValue(1, $usu_nomape);
        $sql->bindValue(2, $usu_correo);
        $sql->bindValue(3, $rol_id);
        $sql->execute();
        $sql1 = "select last_insert_id() as 'user_id'";/* CAMBIO */
        $sql1 = $conectar->prepare($sql1);
        $sql1->execute();
        return $sql1->fetchAll();
    }
    public function get_colaborador()
    {
        $conectar = parent::conexion();
        parent::set_names();
        $sql = "SELECT * FROM tm_usuario 
        WHERE est=1 AND rol_id IN (2,3)";
        $sql = $conectar->prepare($sql);
        $sql->execute();
        return $sql->fetchAll();
    }
    public function update_colaborador($user_id,$usu_nomape, $usu_correo,$rol_id)
    {
        $conectar = parent::conexion();
        parent::set_names();
        $sql = "UPDATE tm_usuario SET usu_nomape=?,usu_correo=?,rol_id=? , fech_modi=NOW() WHERE user_id=?;";
        $sql = $conectar->prepare($sql);
        $sql->bindValue(1, $usu_nomape);
        $sql->bindValue(2, $usu_correo);
        $sql->bindValue(3, $rol_id);
        $sql->bindValue(3, $user_id);
        $sql->execute();
    }
    public function eliminar_colaborador($user_id)
    {
        $conectar = parent::conexion();
        parent::set_names();
        $sql = "UPDATE tm_usuario  SET est=0,fech_elim=Now() WHERE user_id=?";
        $sql = $conectar->prepare($sql);
        $sql->bindValue(1, $user_id);
        $sql->execute();
    }
}
