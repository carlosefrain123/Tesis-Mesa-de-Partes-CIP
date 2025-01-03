/* console.log("Hola"); */
$(document).ready(function(){
    $.post("../../controller/email.php?op=recuperar",{usu_correo:"Carloschallo1@hotmail.com"},function(datos){
        if (datos==1) {
            Swal.fire({
                title: "Recuperar",
                text: "Se cambio la contraseña, y se envio a su correo electronico",
                icon: "success",
                confirmButtonColor: "#5156be",
              });
        }else{
            Swal.fire({
                title: "Recuperar",
                text: "El correo electrónico no existe",
                icon: "error",
                confirmButtonColor: "#5156be",
              });
        }
    });
})