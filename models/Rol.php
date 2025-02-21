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
}
