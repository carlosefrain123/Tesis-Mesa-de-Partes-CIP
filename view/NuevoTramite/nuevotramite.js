let arrImages = [];
let myDropzone = new Dropzone(".dropzone", {
  url: "../../assets/document",
  maxFilesize: 5,
  maxFiles: 5,
  acceptedFiles: "application/pdf",
  addRemoveLinks: true,
  dictRemoveFile: "Quitar",
  dictDefaultMessage:
    "Arrastra y suelta archivos aqui o haz click para seleccionar archivos.",
});
function init() {
  $("#documento_form").on("submit", function (e) {
    guardar(e);
  });
}
function guardar(e) {
  e.preventDefault();
  var formData = new FormData($("#documento_form")[0]);
  $.ajax({
    url: "../../controller/documento.php?op=registrar",
    type: "POST",
    data: formData,
    contentType: false,
    processData: false,
    success: function (data) {
      console.log(data);
    },
  });
}
$(document).ready(function () {
  $.post("../../controller/area.php?op=combo", function (data) {
    $("#area_id").html(data);
    /* console.log(data); */
  });
  $.post("../../controller/tramite.php?op=combo", function (data) {
    $("#tra_id").html(data);
    /* console.log(data); */
  });
  $.post("../../controller/tipo.php?op=combo", function (data) {
    $("#tip_id").html(data);
    /* console.log(data); */
  });
  /* $('#area_id').select2(); */
});

init();
