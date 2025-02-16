<?php
class Tipo extends Conectar
{
    public function get_tipo()
    {
        $conectar = parent::conexion();
        parent::set_names();
        $sql = "SELECT * FROM tm_tipo 
        WHERE est=1";
        $sql = $conectar->prepare($sql);
        $sql->execute();
        return $sql->fetchAll();
    }
    public function insert_tipo($tip_nom)
    {
        $conectar = parent::conexion();
        parent::set_names();
        $sql = "INSERT INTO tm_tipo (tip_nom) VALUES (?)";
        $sql = $conectar->prepare($sql);
        $sql->bindValue(1, $tip_nom);
        $sql->execute();
    }
    public function update_tipo($tip_id,$tip_nom)
    {
        $conectar = parent::conexion();
        parent::set_names();
        $sql = "UPDATE tm_tipo SET tip_nom=?, fech_modi=NOW() WHERE tip_id=?;";
        $sql = $conectar->prepare($sql);
        $sql->bindValue(1, $tip_nom);
        $sql->bindValue(2, $tip_id);
        $sql->execute();
    }
    public function get_tipo_nombre($tip_nom)
    {
        $conectar = parent::conexion();
        parent::set_names();
        $sql = "SELECT * FROM tm_tipo WHERE tip_nom=?";
        $sql = $conectar->prepare($sql);
        $sql->bindValue(1, $tip_nom);
        $sql->execute();
        return $sql->fetchAll();
    }
    public function get_tipo_x_id($tip_id)
    {
        $conectar = parent::conexion();
        parent::set_names();
        $sql = "SELECT * FROM tm_tipo WHERE tip_id=?";
        $sql = $conectar->prepare($sql);
        $sql->bindValue(1, $tip_id);
        $sql->execute();
        return $sql->fetchAll();
    }
    public function eliminar_tipo($tip_id)
    {
        $conectar = parent::conexion();
        parent::set_names();
        $sql = "UPDATE tm_tipo SET est=0,fech_elim=Now() WHERE tip_id=?";
        $sql = $conectar->prepare($sql);
        $sql->bindValue(1, $tip_id);
        $sql->execute();
    }
}