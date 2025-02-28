<?php
class Documento extends Conectar
{
    public function registrar_documento($area_id, $tra_id, $doc_externo, $tip_id, $doc_dni, $doc_nom, $doc_descrip, $user_id)
    {
        $conectar = parent::conexion();
        parent::set_names();
        $sql = "INSERT INTO tm_documento (area_id,tra_id,doc_externo,tip_id,doc_dni,doc_nom,doc_descrip,user_id) VALUES (?,?,?,?,?,?,?,?);";
        $sql = $conectar->prepare($sql);
        $sql->bindValue(1, $area_id);
        $sql->bindValue(2, $tra_id);
        $sql->bindValue(3, $doc_externo);
        $sql->bindValue(4, $tip_id);
        $sql->bindValue(5, $doc_dni);
        $sql->bindValue(6, $doc_nom);
        $sql->bindValue(7, $doc_descrip);
        $sql->bindValue(8, $user_id);
        $sql->execute();

        $sql1 = "select last_insert_id() as 'doc_id'";/* CAMBIO */
        $sql1 = $conectar->prepare($sql1);
        $sql1->execute();
        return $sql1->fetchAll(PDO::FETCH_ASSOC);
    }
    public function insert_documento_detalle($doc_id,$det_nom,$user_id)
    {
        $conectar = parent::conexion();
        parent::set_names();
        $sql = "INSERT INTO td_documento_detalle(doc_id,det_nom,user_id) VALUES (?,?,?);";
        $sql = $conectar->prepare($sql);
        $sql->bindValue(1, $doc_id);
        $sql->bindValue(2, $det_nom);
        $sql->bindValue(3, $user_id);
        $sql->execute();
    }
    public function get_documento_x_id($doc_id){
        $conectar = parent::conexion();
        parent::set_names();
        $sql = "CALL sp_l_documento_01(?);";
        $sql = $conectar->prepare($sql);
        $sql->bindValue(1, $doc_id);
        $sql->execute(); 
        return $sql->fetchAll(PDO::FETCH_ASSOC); 
    }
    public function get_documento_x_user($user_id){
        $conectar = parent::conexion();
        parent::set_names();
        $sql = "CALL sp_l_documento_02(?);";
        $sql = $conectar->prepare($sql);
        $sql->bindValue(1, $user_id);
        $sql->execute(); 
        return $sql->fetchAll(PDO::FETCH_ASSOC); 
    }
    public function get_documento_x_area($area_id){
        /* TODO: Obtener la conexión a la base de datos utilizando el método de la clase padre */
        $conectar = parent::conexion();
        /* TODO: Establecer el juego de caracteres a UTF-8 utilizando el método de la clase padre */
        parent::set_names();
        /* TODO: Consulta SQL para insertar un nuevo usuario en la tabla tm_usuario */
        $sql="SELECT 
            tm_documento.doc_id,
            tm_documento.area_id,
            tm_area.area_nom,
            tm_area.area_correo,
            tm_documento.doc_externo,
            tm_documento.doc_dni,
            tm_documento.doc_nom,
            tm_documento.doc_descrip,
            tm_documento.tra_id,
            tm_tramite.tra_nom,
            tm_documento.tip_id,
            tm_tipo.tip_nom,
            tm_documento.user_id,
            tm_usuario.usu_nomape,
            tm_usuario.usu_correo,
            CONCAT(DATE_FORMAT(tm_documento.fech_crea,'%m'),'-',DATE_FORMAT(tm_documento.fech_crea,'%Y'),'-',tm_documento.doc_id) 
        AS nrotramite
            FROM tm_documento
            INNER JOIN tm_area ON tm_documento.area_id = tm_area.area_id
            INNER JOIN tm_tramite ON tm_documento.tra_id = tm_tramite.tra_id
            INNER JOIN tm_tipo ON tm_documento.tip_id = tm_tipo.tip_id
            INNER JOIN tm_usuario ON tm_documento.user_id = tm_usuario.user_id
            WHERE tm_documento.area_id = ?";
        /* TODO:Preparar la consulta SQL */
        $sql=$conectar->prepare($sql);
        /* TODO: Vincular los valores a los parámetros de la consulta */
        $sql->bindValue(1,$area_id);
        /* TODO: Ejecutar la consulta SQL */
        $sql->execute();
        return $sql->fetchAll(pdo::FETCH_ASSOC);
    }
}
