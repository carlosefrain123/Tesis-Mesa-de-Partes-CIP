<?php
class Area extends Conectar
{
    public function get_area()
    {
        $conectar = parent::conexion();
        parent::set_names();
        $sql = "SELECT * FROM tm_area 
        WHERE est=1";
        $sql = $conectar->prepare($sql);
        $sql->execute();
        return $sql->fetchAll();
    }
    public function insert_area($area_nom, $area_correo)
    {
        $conectar = parent::conexion();
        parent::set_names();
        $sql = "INSERT INTO tm_area (area_nom,area_correo) VALUES (?,?)";
        $sql = $conectar->prepare($sql);
        $sql->bindValue(1, $area_nom);
        $sql->bindValue(2, $area_correo);
        $sql->execute();
    }
    public function update_area($area_id, $area_nom, $area_correo)
    {
        $conectar = parent::conexion();
        parent::set_names();
        $sql = "UPDATE tm_area SET area_nom=?,area_correo=?, fech_modi=NOW() WHERE area_id=?;";
        $sql = $conectar->prepare($sql);
        $sql->bindValue(1, $area_nom);
        $sql->bindValue(2, $area_correo);
        $sql->bindValue(3, $area_id);
        $sql->execute();
    }
    public function get_area_nombre($area_nom)
    {
        $conectar = parent::conexion();
        parent::set_names();
        $sql = "SELECT * FROM tm_area WHERE area_nom=?";
        $sql = $conectar->prepare($sql);
        $sql->bindValue(1, $area_nom);
        $sql->execute();
        return $sql->fetchAll();
    }
    public function get_area_x_id($area_id)
    {
        $conectar = parent::conexion();
        parent::set_names();
        $sql = "SELECT * FROM tm_area WHERE area_id=?";
        $sql = $conectar->prepare($sql);
        $sql->bindValue(1, $area_id);
        $sql->execute();
        return $sql->fetchAll();
    }
    public function eliminar_area($area_id)
    {
        $conectar = parent::conexion();
        parent::set_names();
        $sql = "UPDATE tm_area SET est=0,fech_elim=Now() WHERE area_id=?";
        $sql = $conectar->prepare($sql);
        $sql->bindValue(1, $area_id);
        $sql->execute();
    }
    public function get_area_usuario_permisos($user_id)
    {
        $conectar = parent::conexion();
        parent::set_names();
        $sql = "CALL sp_i_area_01(?);";
        $sql = $conectar->prepare($sql);
        $sql->bindValue(1, $user_id);
        $sql->execute();
        return $sql->fetchAll(PDO::FETCH_ASSOC);
    }
    public function habilitar_area_usuario($aread_id)
    {
        $conectar = parent::conexion();
        parent::set_names();
        $sql = "UPDATE td_area_detalle
                SET
                    aread_permi='Si',
                    fech_modi=NOw()
                WHERE
                    aread_id=?";
        $sql = $conectar->prepare($sql);
        $sql->bindValue(1, $aread_id);
        $sql->execute();
    }
    public function deshabilitar_area_usuario($aread_id)
    {
        $conectar = parent::conexion();
        parent::set_names();
        $sql = "UPDATE td_area_detalle
                SET
                    aread_permi='No',
                    fech_modi=NOw()
                WHERE
                    aread_id=?";
        $sql = $conectar->prepare($sql);
        $sql->bindValue(1, $aread_id);
        $sql->execute();
    }
}
