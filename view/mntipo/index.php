<?php
    require_once("../../config/conexion.php");
    if (isset($_SESSION["user_id"])) {
        # code...
?>
<!doctype html>
<html lang="es">

<head>
    <title>CIP | Mnt Trámite</title>
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
                                <h4 class="mb-sm-0 font-size-18">Mantenimiento de Trámite</h4>

                                <div class="page-title-right">
                                    <ol class="breadcrumb m-0">
                                        <li class="breadcrumb-item"><a href="javascript: void(0);">Pages</a></li>
                                        <li class="breadcrumb-item active">Starter Page</li>
                                    </ol>
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



</body>

</html>
<?php
    }else{
        header("Location:".Conectar::ruta()."index.php");
    }
?>