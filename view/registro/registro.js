function init() {
  //TODO: Escucha el evento submit del formulario
  $("#mnt_form").on("submit", function (e) {
    //TODO: Evita que el formulario se envie automaticamente
    e.preventDefault();
    //TODO: Validar el fomrulario antes de enviarlo
    if (isFormValid()) {
      //TODO: Si es valido, enviar datos
      registrar(e);
    } else {
      //TODO: Si no es valido, muestra mensajes de error
      displayValidationMessages();
    }
  });
}
function isFormValid() {
  //TODO: Usa Validator.js para validar cada campo del fomrulario
  return (
    validateEmail() &&
    validateText("usu_nomape") &&
    validatePassword() &&
    validatePasswordMatch()
  );
}
function validateEmail() {
  var email = $("#usu_correo").val();
  var isValid = validator.isEmail(email);
  //TODO: Muestra el mensaje de error si la validación no es exitosa
  displayErrorMessage("#usu_correo", isValid, "Ingrese Correo Electrónico");
  return isValid;
}
function validateText(fieldId) {
  var value = $("#" + fieldId).val();
  var isValid = validator.isLength(value, { min: 1 });
  displayErrorMessage("#" + fieldId, isValid, "Este campo es obligatorio");
  return isValid;
}
function validatePassword() {
  var password = $("#usu_pass").val();
  var isValid = validator.isLength(password, { min: 8 });
  //TODO: Muestra el mensaje de error si la validación no es exitosa
  displayErrorMessage(
    "#usu_pass",
    isValid,
    "La contraseña debe tener 8 caracteres"
  );
  return isValid;
}
function validatePasswordMatch() {
  var password = $("#usu_pass").val();
  var confirmPassword = $("#usu_pass_confir").val();
  var isValid = validator.equals(password, confirmPassword);
  //TODO: Muestra el mensaje de error si la validación no es exitosa
  displayErrorMessage(
    "#usu_pass_confir",
    isValid,
    "Las contraseñas no coinciden"
  );
  return isValid;
}
function displayErrorMessage(fieldSelector, isValid, message) {
  //TODO: Busca el elemento de mensaje de error y actualiza su contenido
  var errorField = $(fieldSelector).next(".validation-error");
  errorField.text(isValid ? "" : message);
  errorField.toggleClass("text-danger", !isValid);
}
function displayValidationMessages() {
  validateEmail();
  validateText("usu_nomape");
  validatePassword();
  validatePasswordMatch();
}
function registrar(e) {
  e.preventDefault();
  var formData = new FormData($("#mnt_form")[0]);
  $.ajax({
    url: "../../controller/usuario.php?op=registrar",
    type: "POST",
    data: formData,
    contentType: false,
    processData: false,
    success: function (datos) {
      if (datos == 1) {
        Swal.fire({
          title: "Registro",
          text: "Se registró correctamente. Por favor, inicie sesión. Redireccionando en 10 segundos",
          icon: "success",
          confirmButtonColor: "#5156be",
          timer: 10000,
          timerProgressBar: true,
          didOpen: function () {
            Swal.showLoading();
            var timerInterval = setInterval(function () {
              const container = Swal.getHtmlContainer();
              if (container) {
                const b = container.querySelector("b");
                if (b) b.textContent = Swal.getTimerLeft();
              }
            }, 100);
          },
          willClose: function () {
            window.location.href = "../../index.php";
          },
        });
      } else if (datos == 0) {
        Swal.fire({
          title: "Registro",
          text: "El correo electrónico ya existe",
          icon: "error",
          confirmButtonColor: "#5156be",
        });
      }
      console.log(datos);
    },
  });
}

/* console.log("Hola"); */
function startGoogleSignIn() {
  const auth = gapi.auth2.getAuthInstance();

  auth.signIn();
}

function handleCredentialResponse(response) {
  $.ajax({
    type:'POST',
    url:'../../controller/usuario.php?op=registrargoogle',
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
          window.location.href='../home/'
        }else if(data==="1"){
          window.location.href='../home/'
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


init();
/* console.log("hols"); */
