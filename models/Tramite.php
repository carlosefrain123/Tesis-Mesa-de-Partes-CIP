<?php
class Tramite extends Conectar
{
    public function get_tramite()
    {
        $conectar = parent::conexion();
        parent::set_names();
        $sql = "SELECT * FROM tm_tramite 
        WHERE est=1";
        $sql = $conectar->prepare($sql);
        $sql->execute();
        return $sql->fetchAll();
    }
    public function insert_tramite($tra_nom,$tra_descrip)
    {
        $conectar = parent::conexion();
        parent::set_names();
        $sql = "INSERT INTO tm_tramite (tra_nom,tra_descrip) VALUES (?,?)";
        $sql = $conectar->prepare($sql);
        $sql->bindValue(1, $tra_nom);
        $sql->bindValue(2, $tra_descrip);
        $sql->execute();
    }
    public function update_tramite($tra_id,$tra_nom,$tra_descrip)
    {
        $conectar = parent::conexion();
        parent::set_names();
        $sql = "UPDATE tm_tramite SET tra_nom=?,tra_descrip=?, fech_modi=NOW() WHERE tra_id=?;";
        $sql = $conectar->prepare($sql);
        $sql->bindValue(1, $tra_nom);
        $sql->bindValue(2, $tra_descrip);
        $sql->bindValue(3, $tra_id);
        $sql->execute();
    }
    public function get_tra_nombre($tra_nom)
    {
        $conectar = parent::conexion();
        parent::set_names();
        $sql = "SELECT * FROM tm_tramite WHERE tra_nom=?";
        $sql = $conectar->prepare($sql);
        $sql->bindValue(1, $tra_nom);
        $sql->execute();
        return $sql->fetchAll();
    }
    public function get_tra_x_id($tra_id)
    {
        $conectar = parent::conexion();
        parent::set_names();
        $sql = "SELECT * FROM tm_tramite WHERE tra_id=?";
        $sql = $conectar->prepare($sql);
        $sql->bindValue(1, $tra_id);
        $sql->execute();
        return $sql->fetchAll();
    }
    public function eliminar_tramite($tra_id)
    {
        $conectar = parent::conexion();
        parent::set_names();
        $sql = "UPDATE tm_tramite SET est=0,fech_elim=Now() WHERE tra_id=?";
        $sql = $conectar->prepare($sql);
        $sql->bindValue(1, $tra_id);
        $sql->execute();
    }
}
