<?php
require_once("../../models/Rol.php");
$rol = new Rol();
$datos=$rol->get_menu_x_rol($_SESSION["rol_id"]);
?>
<!-- ========== Left Sidebar Start ========== -->
<div class="vertical-menu">

    <div data-simplebar="" class="h-100">

        <!--- Sidemenu -->
        <div id="sidebar-menu">
            <!-- Left Menu Start -->
            <ul class="metismenu list-unstyled" id="side-menu">
                <li class="menu-title" data-key="t-menu">Menu</li>
                <?php
                foreach ($datos as $row) {
                ?>
                    <li>
                        <a href="<?php echo $row["men_ruta"]?>">
                            <i data-feather="<?php echo $row["men_icon"]?>"></i>
                            <span data-key="t-dashboard"><?php echo $row["men_nom_vista"]?></span>
                        </a>
                    </li>
                <?php
                }
                ?>
            </ul>
        </div>
        <!-- Sidebar -->
    </div>
</div>