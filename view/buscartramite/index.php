<?php
require_once("../../config/conexion.php");
require_once("../../models/rol.php");
$rol = new Rol();
$datos = $rol->validar_menu_x_rol($_SESSION["rol_id"], "buscartramite");
if (isset($_SESSION["user_id"]) and count($datos) > 0) {
    # code...
?>
    <!doctype html>
    <html lang="es">

    <head>
        <title>CIP | Buscar Tramite</title>
        <?php require_once("../html/head.php") ?>
    </head>

    <body>

        <!-- <body data-layout="horizontal"> -->

        <!-- Begin page -->
        <div id="layout-wrapper">

            <!-- Header del sistema -->
            <?php require_once("../html/header.php") ?>
            <!-- Menú del sistema -->
            <?php require_once("../html/menu.php") ?>

            <!-- ============================================================== -->
            <!-- Start right Content here -->
            <!-- ============================================================== -->
            <div class="main-content">

                <div class="page-content">
                    <div class="container-fluid">

                        <div class="row">
                            <div class="col-12">
                                <div class="page-title-box d-sm-flex align-items-center justify-content-between">
                                    <h4 class="mb-sm-0 font-size-18">Buscar Tramite</h4>

                                    <div class="page-title-right">
                                        <ol class="breadcrumb m-0">
                                            <li class="breadcrumb-item"><a href="javascript: void(0);">Pages</a></li>
                                            <li class="breadcrumb-item active">Starter Page</li>
                                        </ol>
                                    </div>

                                </div>
                            </div>
                            <table id="listado_table" class="table table-bordered dt-responsive  nowrap w-100">
                                <thead>
                                    <tr>
                                        <th>Nro.Tramite</th>
                                        <th>Area</th>
                                        <th>Tramite</th>
                                        <th>Doc.Externo</th>
                                        <th>Tipo</th>
                                        <th>Doc.</th>
                                        <th>Nombre</th>
                                        <th>Estado</th>
                                        <th></th>
                                    </tr>
                                </thead>

                                <tbody>

                                </tbody>
                            </table>
                        </div>

                    </div>
                </div>


                <?php require_once("../html/footer.php") ?>

            </div>


        </div>
        <?php require_once("mnt.php") ?>
        <?php require_once("../html/sidebar.php") ?>
        <div class="rightbar-overlay"></div>
        <?php require_once("../html/js.php") ?>
        <script type="text/javascript" src="buscartramite.js"></script>
    </body>

    </html>
<?php
} else {
    header("Location:" . Conectar::ruta() . "index.php");
}
?>