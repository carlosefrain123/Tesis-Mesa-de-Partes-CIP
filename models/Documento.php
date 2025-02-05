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
}
