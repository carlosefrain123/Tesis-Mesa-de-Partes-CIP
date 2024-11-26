<?php
class Usuario extends Conectar
{
    public function registrar_usuario($usu_nomape, $usu_correo, $usu_pass)
    {
        $conectar = parent::conexion();
        parent::set_names();
        $sql = "INSERT INTO tm_usuario (usu_nomape,usu_correo,usu_pass) VALUES (?,?,?)";
        $sql=$conectar->prepare($sql);
        $sql->bindValue(1,$usu_nomape);
        $sql->bindValue(2,$usu_correo);
        $sql->bindValue(3,$usu_pass);
        $sql->execute();

        $sql1="select last_insert_id() as 'usu_id'";
        $sql1=$conectar->prepare($sql1);
        $sql1->execute();
        return $sql1->fetchAll();

    }
    //TODO: Detecta si no se repite el correo
    public function get_usuario_correo($usu_correo){
        $conectar = parent::conexion();
        parent::set_names();
        $sql = "SELECT * FROM tm_usuario
        WHERE usu_correo=?";
        $sql=$conectar->prepare($sql);
        $sql->bindValue(1,$usu_correo);
        $sql->execute(); 
        return $sql->fetchAll();
    }
}
