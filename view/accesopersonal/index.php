<?php
require_once("../../config/conexion.php");
if (isset($_POST["enviar"]) and $_POST["enviar"] == "si") {
    require_once("../../models/Usuario.php");
    $usuario = new Usuario();
    $usuario->login_colaborador();
}
?>
<!doctype html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <title>Colaborador de la empresa | Colegio de Ingenieros - Mesa de Partes</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta content="Premium Multipurpose Admin & Dashboard Template" name="description">
    <meta content="Themesbrand" name="author">
    <!-- Sweet Alert-->
    <link href="../../assets/css/sweetalert2.min.css" rel="stylesheet" type="text/css">
    <!-- preloader css -->
    <link rel="stylesheet" href="../../assets/css/preloader.min-1.css" type="text/css">

    <!-- Bootstrap Css -->
    <link href="../../assets/css/bootstrap.min-1.css" id="bootstrap-style" rel="stylesheet" type="text/css">
    <!-- Icons Css -->
    <link href="../../assets/css/icons.min-1.css" rel="stylesheet" type="text/css">
    <!-- App Css-->
    <link href="../../assets/css/app.min-1.css" id="app-style" rel="stylesheet" type="text/css">

</head>

<body>

    <!-- <body data-layout="horizontal"> -->
    <div class="auth-page">
        <div class="container-fluid p-0">
            <div class="row g-0">
                <div class="col-xxl-3 col-lg-4 col-md-5">
                    <div class="auth-full-page-content d-flex p-sm-5 p-4">
                        <div class="w-100">
                            <div class="d-flex flex-column h-100">
                                <div class="mb-4 mb-md-5 text-center">
                                    <a href="../../index.php" class="d-block auth-logo">
                                        <img src="../../assets/picture/LogoCIP.png" alt="" height="70">
                                    </a>
                                </div>
                                <div class="auth-content my-auto">
                                    <div class="text-center">
                                        <h5 class="mb-0">¡Bienvenido de nuevo!</h5>
                                        <p class="text-muted mt-2">Ingrese sus credenciales del Colaborador.</p>
                                    </div>

                                    <form class="custom-form mt-4 pt-2" action="" method="post">
                                        <?php
                                        if (isset($_GET["m"])) {
                                            switch ($_GET["m"]) {
                                                case "1":
                                        ?>
                                                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                                        <i class="mdi mdi-block-helper me-2"></i>
                                                        Correo eléctronico no encontrado
                                                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                                    </div>
                                                <?php
                                                    break;
                                                case "2":
                                                ?>
                                                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                                        <i class="mdi mdi-block-helper me-2"></i>
                                                        Campos vacios.
                                                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                                    </div>
                                                <?php
                                                    break;
                                                case "3":
                                                ?>
                                                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                                        <i class="mdi mdi-block-helper me-2"></i>
                                                        Contraseña es incorrecta.
                                                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                                    </div>
                                        <?php
                                                    break;
                                                default:
                                                    # code...
                                                    break;
                                            }
                                        }
                                        ?>

                                        <div class="mb-3">
                                            <label class="form-label">Correo Eléctronico</label>
                                            <input type="email" class="form-control" id="usu_correo" name="usu_correo" placeholder="Ingrese correo Eléctrónico" required>
                                        </div>
                                        <div class="mb-3">
                                            <div class="d-flex align-items-start">
                                                <div class="flex-grow-1">
                                                    <label class="form-label">Contraseña</label>
                                                </div>
                                                <div class="flex-shrink-0">
                                                    <div class="">
                                                        <a href="../../view/recuperarcolaborador/" class="text-muted">Olvidaste tu contraseña</a>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="input-group auth-pass-inputgroup">
                                                <input type="password" class="form-control" id="usu_pass" name="usu_pass" placeholder="Ingrese Contraseña" aria-label="Password" aria-describedby="password-addon" required>
                                                <button class="btn btn-light shadow-none ms-0" type="button" id="password-addon"><i class="mdi mdi-eye-outline"></i></button>
                                            </div>
                                        </div>
                                        <div class="row mb-4">
                                            <div class="col">
                                                <div class="form-check">
                                                    <input class="form-check-input" type="checkbox" id="remember-check">
                                                    <label class="form-check-label" for="remember-check">
                                                        Recuerdame
                                                    </label>
                                                </div>
                                            </div>

                                        </div>
                                        <div class="mb-3">
                                            <input type="hidden" name="enviar" value="si">
                                            <button class="btn btn-primary w-100 waves-effect waves-light" type="submit">Acceder</button>
                                        </div>
                                    </form>

                                    <div class="mt-4 pt-2 text-center">
                                        <div class="signin-other-title">
                                            <h5 class="font-size-14 mb-3 text-muted fw-medium">- Acceder con -</h5>
                                        </div>

                                        <ul class="list-inline mb-0">
                                            <li class="list-inline-item">
                                                <!-- Botón "Iniciar sesión con Google" con atributos de datos -->
                                                <div id="g_id_onload"
                                                    data-client_id="1086297007236-76btgk1hsnv9n7oaodou4oifiior9ms3.apps.googleusercontent.com"
                                                    data-context="signin"
                                                    data-ux_mode="popup"
                                                    data-callback="handleCredentialResponse"
                                                    data-auto_prompt="false">
                                                </div>
                                                TODO<!-- : Configuración del botón de inicio de sesión con Google -->
                                                <div class="g_id_signin"
                                                    data-type="standard"
                                                    data-shape="rectangular"
                                                    data-theme="outline"
                                                    data-text="signin_with"
                                                    data-size="large"
                                                    data-logo_alignment="left">

                                                </div>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="mt-4 mt-md-5 text-center">
                                    <p class="mb-0">© <script>
                                            document.write(new Date().getFullYear())
                                        </script> Todos los derechos reservados: <b>CIP CDL</b></p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- end auth full page content -->
                </div>
                <!-- end col -->
                <div class="col-xxl-9 col-lg-8 col-md-7">
                    <div class="auth-bg pt-md-5 p-4 d-flex">
                        <div class="bg-overlay bg-primary"></div>
                        <ul class="bg-bubbles">
                            <li></li>
                            <li></li>
                            <li></li>
                            <li></li>
                            <li></li>
                            <li></li>
                            <li></li>
                            <li></li>
                            <li></li>
                            <li></li>
                        </ul>
                        <!-- end bubble effect -->
                        <div class="row justify-content-center align-items-center">
                            <div class="col-xl-7">
                                <div class="p-0 p-sm-4 px-xl-0">
                                    <div id="reviewcarouselIndicators" class="carousel slide" data-bs-ride="carousel">
                                        <div class="carousel-indicators carousel-indicators-rounded justify-content-start ms-0 mb-0">
                                            <button type="button" data-bs-target="#reviewcarouselIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                                            <button type="button" data-bs-target="#reviewcarouselIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
                                            <button type="button" data-bs-target="#reviewcarouselIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
                                        </div>
                                        <!-- end carouselIndicators -->
                                        <div class="carousel-inner">
                                            <div class="carousel-item active">
                                                <div class="testi-contain text-white">
                                                    <i class="bx bxs-quote-alt-left text-success display-6"></i>

                                                    <h4 class="mt-4 fw-medium lh-base text-white">“El sistema de Mesa de Partes del Colegio de Ingenieros del Perú - CD Lambayeque es eficiente y fácil de usar. Permite gestionar documentos de manera ágil y garantiza el seguimiento adecuado de los trámites.”</h4>
                                                    <div class="mt-4 pt-3 pb-5">
                                                        <div class="d-flex align-items-start">
                                                            <div class="flex-shrink-0">
                                                                <img src="../../assets/picture/avatar-1-1.jpg" class="avatar-md img-fluid rounded-circle" alt="...">
                                                            </div>
                                                            <div class="flex-grow-1 ms-3 mb-4">
                                                                <h5 class="font-size-18 text-white">Richard Drews</h5>
                                                                <p class="mb-0 text-white-50">Ingeniero Civil</p>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="carousel-item">
                                                <div class="testi-contain text-white">
                                                    <i class="bx bxs-quote-alt-left text-success display-6"></i>

                                                    <h4 class="mt-4 fw-medium lh-base text-white">“El sistema es una herramienta fundamental para los colegiados. Nos ayuda a mantenernos organizados y asegura que nuestras solicitudes sean atendidas de manera oportuna.”</h4>
                                                    <div class="mt-4 pt-3 pb-5">
                                                        <div class="d-flex align-items-start">
                                                            <div class="flex-shrink-0">
                                                                <img src="../../assets/picture/avatar-2-1.jpg" class="avatar-md img-fluid rounded-circle" alt="...">
                                                            </div>
                                                            <div class="flex-grow-1 ms-3 mb-4">
                                                                <h5 class="font-size-18 text-white">Rosanna French</h5>
                                                                <p class="mb-0 text-white-50">Ingeniera Industrial</p>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="carousel-item">
                                                <div class="testi-contain text-white">
                                                    <i class="bx bxs-quote-alt-left text-success display-6"></i>

                                                    <h4 class="mt-4 fw-medium lh-base text-white">“Con el sistema de Mesa de Partes, el proceso de registro y seguimiento de documentos es mucho más sencillo y transparente. Es un gran apoyo para nuestra labor profesional.”</h4>
                                                    <div class="mt-4 pt-3 pb-5">
                                                        <div class="d-flex align-items-start">
                                                            <img src="../../assets/picture/avatar-3-1.jpg" class="avatar-md img-fluid rounded-circle" alt="...">
                                                            <div class="flex-grow-1 ms-3 mb-4">
                                                                <h5 class="font-size-18 text-white">Ilse R. Eaton</h5>
                                                                <p class="mb-0 text-white-50">Gerente de Proyectos</p>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- end carousel-inner -->
                                    </div>
                                    <!-- end review carousel -->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- end col -->
            </div>
            <!-- end row -->
        </div>
        <!-- end container fluid -->
    </div>


    <!-- JAVASCRIPT -->
    <script src="../../assets/js/jquery.min-1.js"></script>
    <script src="../../assets/js/bootstrap.bundle.min-1.js"></script>
    <script src="../../assets/js/metisMenu.min-1.js"></script>
    <script src="../../assets/js/simplebar.min-1.js"></script>
    <script src="../../assets/js/waves.min.js"></script>
    <script src="../../assets/js/feather.min-1.js"></script>
    <!-- pace js -->
    <script src="../../assets/js/pace.min-1.js"></script>
    <!-- password addon init -->
    <script src="../../assets/js/pass-addon.init-1.js"></script>

    <!-- TODO: Script para cargar la API de Google Sing-In de manera asincrona -->
    <script src="https://accounts.google.com/gsi/client" async></script>
    <!-- Sweet Alerts js -->
    <script src="../../assets/js/sweetalert2.min.js"></script>

    <script type="text/javascript" src="accesopersonal.js"></script>
</body>

</html>