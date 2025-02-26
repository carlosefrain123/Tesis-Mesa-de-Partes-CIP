<?php
class Rol extends Conectar
{
    public function get_rol()
    {
        $conectar = parent::conexion();
        parent::set_names();
        $sql = "SELECT * FROM tm_rol
        WHERE est=1";
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
    public function update_rol($rol_id, $rol_nom)
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
    public function habilitar_rol_menu($mend_id)
    {
        $conectar = parent::conexion();
        parent::set_names();
        $sql = "UPDATE td_menu_detalle
                SET
                    mend_permi='Si',
                    fech_modi=NOw()
                WHERE
                    mend_id=?";
        $sql = $conectar->prepare($sql);
        $sql->bindValue(1, $mend_id);
        $sql->execute();
    }
    public function deshabilitar_rol_menu($mend_id)
    {
        $conectar = parent::conexion();
        parent::set_names();
        $sql = "UPDATE td_menu_detalle
                SET
                    mend_permi='No',
                    fech_modi=NOw()
                WHERE
                    mend_id=?";
        $sql = $conectar->prepare($sql);
        $sql->bindValue(1, $mend_id);
        $sql->execute();
    }
    public function get_menu_x_rol($rol_id){
        /* TODO: Obtener la conexión a la base de datos utilizando el método de la clase padre */
        $conectar = parent::conexion();
        /* TODO: Establecer el juego de caracteres a UTF-8 utilizando el método de la clase padre */
        parent::set_names();
        /* TODO: Consulta SQL para insertar un nuevo usuario en la tabla tm_usuario */
        $sql="SELECT
            td_menu_detalle.mend_id, 
            tm_menu.men_id,
            tm_menu.men_nom,
            tm_menu.men_nom_vista,
            tm_menu.men_icon,
            tm_menu.men_ruta
            FROM td_menu_detalle
            INNER JOIN tm_menu ON td_menu_detalle.men_id = tm_menu.men_id
            WHERE
            td_menu_detalle.rol_id = ?
            AND tm_menu.est=1
            AND td_menu_detalle.mend_permi = 'Si'";
        /* TODO:Preparar la consulta SQL */
        $sql=$conectar->prepare($sql);
        /* TODO: Vincular los valores a los parámetros de la consulta */
        $sql->bindValue(1,$rol_id);
        /* TODO: Ejecutar la consulta SQL */
        $sql->execute();
        return $sql->fetchAll(pdo::FETCH_ASSOC);
    }
}
