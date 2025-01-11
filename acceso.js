/* console.log("Hola"); */
function startGoogleSignIn() {
  const auth = gapi.auth2.getAuthInstance();

  auth.signIn();
}

function handleCredentialResponse(response) {
  if (response && response.credential) {
    /* console.log(response); */
    const credentialToken = response.credential;

    const decodedToken = JSON.parse(atob(credentialToken.split(".")[1]));

    console.log(decodedToken);
  }
}
