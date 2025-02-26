<?php
require_once("../../config/conexion.php");
require_once("../../models/Rol.php");
$rol=new Rol();
$datos = $rol->validar_menu_x_rol($_SESSION["rol_id"],"nuevotramite");
if (isset($_SESSION["user_id"]) and count($datos)>0) {
    # code...
?>
    <!doctype html>
    <html lang="es">

    <head>
        <title>CIP | Nuevo Trámite</title>
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
                                    <h4 class="mb-sm-0 font-size-18">Nuevo Tramite</h4>

                                    <div class="page-title-right">
                                        <ol class="breadcrumb m-0">
                                            <li class="breadcrumb-item"><a href="javascript: void(0);">Pages</a></li>
                                            <li class="breadcrumb-item active">Starter Page</li>
                                        </ol>
                                    </div>

                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="card">
                                        <div class="card-header">
                                            <h4 class="card-title">Ingrese toda la información requeridad.</h4>
                                            <p class="card-title-desc">(*)Datos obligatorios</p>
                                        </div>
                                        <div class="card-body">
                                            <form action="" method="post" id="documento_form">

                                                <div class="row">
                                                    <div class="col-lg-3">
                                                        <div class="mb-3">
                                                            <label for="form-label" class="form-label">Area (*)</label>
                                                            <select class="form-select" name="area_id" id="area_id" placeholder="Seleccionar" requeridad>
                                                                <option value="">Seleccionar</option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-6">
                                                        <div class="mb-3">
                                                            <label for="example-text-input" class="form-label">Tramite (*)</label>
                                                            <select class="form-select" name="tra_id" id="tra_id" placeholder="Seleccionar" requeridad>
                                                                <option value="">Seleccionar</option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-3">
                                                        <div class="mb-3">
                                                            <label for="form-label" class="form-label">Nro Externo (*)</label>
                                                            <input class="form-control" type="text" name="doc_externo" id="doc_externo">
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-3">
                                                        <div class="mb-3">
                                                            <label for="form-label" class="form-label">Tipo (*)</label>
                                                            <select class="form-select" name="tip_id" id="tip_id" placeholder="Seleccionar" requeridad>
                                                                <option value="">Seleccionar</option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-3">
                                                        <div class="mb-3">
                                                            <label for="form-label" class="form-label">DNI / RUC (*)</label>
                                                            <input class="form-control" type="text" name="doc_dni" id="doc_dni" requeridad>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-6">
                                                        <div class="mb-3">
                                                            <label for="form-label" class="form-label">Nombre / Razón Social (*)</label>
                                                            <input class="form-control" type="text" value="" name="doc_nom" id="doc_nom" requeridad>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-12">
                                                        <div class="mb-3">
                                                            <label for="form-label" class="form-label">Descripción (*)</label>
                                                            <textarea class="form-control" type="text" rows="2" value="" name="doc_descrip" id="doc_descrip" requeridad></textarea>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-12">
                                                        <div class="dropzone">
                                                            <div class="dz-default dz-message">
                                                                <button class="dz-button" type="button">
                                                                    <img src="../../assets/image/upload.png" alt="">
                                                                </button>
                                                                <div class="dz-message" data-dz-dz-message><span> Arrastra y suelta archivos aqui o haz click para seleccionar archivos.,
                                                                    </span></div>
                                                            </div>
                                                        </div>
                                                        <!-- <form action="#" class="dropzone"> -->
                                                        <!-- <div class="fallback">
                                                            <input name="file" type="file" multiple="multiple">
                                                        </div>
                                                        <div class="dz-message needsclick">
                                                            <div class="mb-3">
                                                                <i class="display-4 text-muted bx bx-cloud-upload"></i>
                                                            </div>

                                                            <h5>Drop files here or click to upload.</h5>
                                                        </div> -->
                                                        <!-- </form> -->
                                                    </div>
                                                    <div class="card-body">
                                                        <div class="d-flex flex-wrap gap-2 mt-4">
                                                            <button type="button" id="btnlimpiar" class="btn btn-secondary waves-effect waves-light">Limpiar</button>
                                                            <button type="submit" id="btnguardar" class="btn btn-primary waves-effect waves-light">Guardar</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>


                    <?php require_once("../html/footer.php") ?>

                </div>


            </div>

            <?php require_once("../html/sidebar.php") ?>


            <!-- Right bar overlay-->
            <div class="rightbar-overlay"></div>
            <?php require_once("../html/js.php") ?>
            <script type="text/javascript" src="nuevotramite.js"></script>


    </body>

    </html>
<?php
} else {
    header("Location:" . Conectar::ruta() . "index.php");
}
?>