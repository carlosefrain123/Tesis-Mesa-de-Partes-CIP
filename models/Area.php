<?php
class Area extends Conectar
{
    public function get_area()
    {
        $conectar = parent::conexion();
        parent::set_names();
        $sql = "SELECT * FROM tm_area 
        WHERE est=1
        ORDER BY area_nom";
        $sql = $conectar->prepare($sql);
        $sql->execute();
        return $sql->fetchAll();
    }
}
