/* console.log("Hola"); */
$(document).ready(function(){
    $.post("../../controller/email.php?op=recuperar",{usu_correo:"Carloschallo1@hotmail.com"},function(data){});
})