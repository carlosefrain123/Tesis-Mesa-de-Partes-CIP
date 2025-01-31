<?php
class Documento extends Conectar
{
    public function registrar_documento($area_id,$tra_id,$doc_externo,$tip_id,$doc_dni,$doc_nom,$doc_descrip,$user_id)
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
        return $sql1->fetchAll();
    }
}
