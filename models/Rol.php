<?php
class Rol extends Conectar
{
    public function get_rol()
    {
        $conectar = parent::conexion();
        parent::set_names();
        $sql = "SELECT * FROM tm_rol
        WHERE est=1 AND rol_id NOT IN (1)";
        $sql = $conectar->prepare($sql);
        $sql->execute();
        return $sql->fetchAll();
    }
    public function insert_rol($rol_nom)
    {
        $conectar = parent::conexion();
        parent::set_names();
        $sql = "INSERT INTO tm_rol (rol_nom) VALUES (?)";
        $sql = $conectar->prepare($sql);
        $sql->bindValue(1, $rol_nom);
        $sql->execute();
    }
    public function update_rol($rol_id,$rol_nom)
    {
        $conectar = parent::conexion();
        parent::set_names();
        $sql = "UPDATE tm_rol SET rol_nom=?, fech_modi=NOW() WHERE rol_id=?;";
        $sql = $conectar->prepare($sql);
        $sql->bindValue(1, $rol_nom);
        $sql->bindValue(2, $rol_id);
        $sql->execute();
    }
    public function get_rol_nombre($rol_nom)
    {
        $conectar = parent::conexion();
        parent::set_names();
        $sql = "SELECT * FROM tm_rol WHERE rol_nom=?";
        $sql = $conectar->prepare($sql);
        $sql->bindValue(1, $rol_nom);
        $sql->execute();
        return $sql->fetchAll();
    }
    public function get_rol_x_id($rol_id)
    {
        $conectar = parent::conexion();
        parent::set_names();
        $sql = "SELECT * FROM tm_rol WHERE rol_id=?";
        $sql = $conectar->prepare($sql);
        $sql->bindValue(1, $rol_id);
        $sql->execute();
        return $sql->fetchAll();
    }
    public function eliminar_rol($rol_id)
    {
        $conectar = parent::conexion();
        parent::set_names();
        $sql = "UPDATE tm_rol SET est=0,fech_elim=Now() WHERE rol_id=?";
        $sql = $conectar->prepare($sql);
        $sql->bindValue(1, $rol_id);
        $sql->execute();
    }
    public function get_rol_menu_permisos($rol_id)
    {
        $conectar = parent::conexion();
        parent::set_names();
        $sql = "CALL sp_i_rol_01(?);";
        $sql = $conectar->prepare($sql);
        $sql->bindValue(1, $rol_id);
        $sql->execute();
        return $sql->fetchAll(PDO::FETCH_ASSOC);
    }
}
