<!-- ========== Left Sidebar Start ========== -->
<div class="vertical-menu">

    <div data-simplebar="" class="h-100">

        <!--- Sidemenu -->
        <div id="sidebar-menu">
            <!-- Left Menu Start -->
            <ul class="metismenu list-unstyled" id="side-menu">
                <li class="menu-title" data-key="t-menu">Menu</li>
                <?php
                if ($_SESSION["rol_id"] == 1) {
                ?>
                    <li>
                        <a href="../home/">
                            <i data-feather="home"></i>
                            <span data-key="t-dashboard">Inicio</span>
                        </a>
                    </li>

                    <li>
                        <a href="../NuevoTramite/">
                            <i data-feather="grid"></i>
                            <span data-key="t-apps">Nuevo Trámite</span>
                        </a>

                    </li>

                    <li>
                        <a href="../ConsultarTramite/">
                            <i data-feather="users"></i>
                            <span data-key="t-authentication">Consultar Trámite</span>
                        </a>
                    </li>
                <?php
                }elseif ($_SESSION["rol_id"]==2) {
                    ?>
                    <li>
                        <a href="../homecolaborador/">
                            <i data-feather="home"></i>
                            <span data-key="t-dashboard">Inicio Colaborador</span>
                        </a>
                    </li>

                    <li>
                        <a href="../gestionartramite/">
                            <i data-feather="grid"></i>
                            <span data-key="t-apps">Gestionar Trámite</span>
                        </a>

                    </li>

                    <li>
                        <a href="../buscartramite/">
                            <i data-feather="users"></i>
                            <span data-key="t-authentication">Consultar Trámite</span>
                        </a>
                    </li>
                <?php
                }elseif ($_SESSION["rol_id"]==3) {
                    ?>
                    <li>
                        <a href="../mntusuario/">
                            <i data-feather="grid"></i>
                            <span data-key="t-apps">Mnt.Usuario</span>
                        </a>

                    </li>

                    <li>
                        <a href="../mntarea/">
                            <i data-feather="users"></i>
                            <span data-key="t-authentication">Mnt.Area</span>
                        </a>
                    </li>
                    <li>
                        <a href="../mntramite/">
                            <i data-feather="users"></i>
                            <span data-key="t-authentication">Mnt.Tramite</span>
                        </a>
                    </li>
                    <li>
                        <a href="../mntipo/">
                            <i data-feather="users"></i>
                            <span data-key="t-authentication">Mnt.T</span>
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