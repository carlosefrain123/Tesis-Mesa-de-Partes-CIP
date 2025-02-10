/* console.log("Hola"); */
function startGoogleSignIn() {
  const auth = gapi.auth2.getAuthInstance();

  auth.signIn();
}

function handleCredentialResponse(response) {
  $.ajax({
    type:'POST',
    url:'controller/usuario.php?op=registrargoogle',
    contentType:'application/json',
    headers:{"Content-Type": "application/json"},
    data: JSON.stringify({
        request_type:'user_auth',
        credential: response.credential
    }),
    success: function (data) {
      /* var data=JSON.parse(data); */
        /* console.log(data); */
        console.log(data);
        if (data==="0") {
          window.location.href='view/home'
        }else if(data==="1"){
          window.location.href='view/home'
        }else if(data==="2"){
          /* window.location.href='../../view/home' */
          Swal.fire({
            title: "Ingreso Colaborador",
            text: "Su cuenta no tiene acceso",
            icon: "error",
            confirmButtonColor: "#5156be",
          });
        }
    }
  })
  if (response && response.credential) {
    /* console.log(response); */
    const credentialToken = response.credential;
    //TODO: Decodificar si tienen manualmente para obtener datos del usuario
    const decodedToken = JSON.parse(atob(credentialToken.split(".")[1]));
    //TODO: Imprimir en la consola los datos del usuario
    /* console.log(decodedToken); */
  }
}
