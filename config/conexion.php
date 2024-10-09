<?php
//TODO: Inicia la sesion (si no esta iniciada)
session_start();
//TODO: Definición de la clase conectar
    class Conectar{
        //TODO: Propiedad para almacenar la conexión a la base de datos
        protected $dbh;
        //TODO: Método para establecer la conexión a la base de datos
        protected function Conexion(){
            try {
                //TODO: Intenta establecer la conexión utilizando PDO
                $conectar=$this->dbh=new PDO("mysql:local=localhost;dbname=mesadepartes","root","");
            } catch (Exception $e) {
                //TODO: En caso de error, muestra el mensaje de error y termina la ejecución del script
                print "Error BD:".$e->getMessage()."<br>";
                die();
            }
        }
        //TODO: Método para establecer el juego de caracteres a UTF-8
        public function set_names(){
            return $this->dbh->query("SET NAME'utf8'");
        }
        //TODO: Ruta del proyecto
        public static function ruta(){
            return "http://localhost/tesis/";
        }
    }