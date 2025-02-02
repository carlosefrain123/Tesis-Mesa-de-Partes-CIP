let arrImages = [];
Dropzone.autoDiscover = false;
let myDropzone = new Dropzone(".dropzone", {
  url: "../../assets/document",
  maxFilesize: 2,
  maxFiles: 5,
  acceptedFiles: "application/pdf",
  addRemoveLinks: true,
  dictRemoveFile: "Quitar",
});
myDropzone.on("maxfilesexceeded", function (file) {
  Swal.fire({
    title: "Mesa de Partes",
    text: "Solo se permiten un máximo de 5 archivos",
    icon: "error",
    confirmButtonColor: "#5156be",
  });
  myDropzone.removeFile(file);
});
myDropzone.on('addfile',function (file){
  if (file.size>2*1024*1024) {
    swal.fire({
      title: "Mesa de Partes",
      text: 'El archivo"'+file.name+'" excede el tamaño máximo de 2 mb',
      icon: "error",
      confirmButtonColor: "#5156be",
    });
    myDropzone.removeFile(file);
  }
})
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
