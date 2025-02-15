var tabla;
function init() {
  $("#mnt_form").on("submit", function (e) {
    guardaryeditar(e);
  });
}
function guardaryeditar(e) {
  e.preventDefault();
  var formData = new FormData($("#mnt_form")[0]);
  
  $.ajax({
    url: "../../controller/tipo.php?op=guardaryeditar",
    type: "POST",
    data: formData,
    contentType: false,
    processData: false,
    success: function (data) {
      /* data=JSON.parse(data); */
      console.log(data);
      $("#mnt_form")[0].reset();
      $("#listado_table").DataTable().ajax.reload();
      $("#mnt_modal").modal('hide');
    },
  });
}
$(document).ready(function () {
  tabla = $("#listado_table")
    .dataTable({
      aProcessing: true,
      aServerSide: true,
      dom: "Bfrtip",
      searching: true,
      lengthChange: false,
      colReorder: true,
      buttons: ["copyHtml5", "excelHtml5", "csvHtml5", "pdfHtml5"],
      ajax: {
        url: "../../controller/tipo.php?op=listar",
        type: "get",
        datatype: "json",
        error: function (e) {
          console.log(e.responseText);
        },
      },
      bDestroy: true,
      responsive: true,
      bInfo: true,
      iDisplayLength: 10,
      autoWidth: false,
      language: {
        sProcessing: "Procesando...",
        sLengthMenu: "Mostrar _MENU_ registros",
        sZeroRecords: "No se encontraron resultados",
        sEmptyTable: "Ningún dato disponible en esta tabla",
        sInfo: "Mostrando un total de _TOTAL_ registros",
        sInfoEmpty: "Mostrando un total de 0 registros",
        sInfoFiltered: "(filtrado de un total de _MAX_ registros)",
        sInfoPostFix: "",
        sSearch: "Buscar:",
        sUrl: "",
        sInfoThousands: ",",
        sLoadingRecords: "Cargando...",
        oPaginate: {
          sFirst: "Primero",
          sLast: "Último",
          sNext: "Siguiente",
          sPrevious: "Anterior",
        },
        oAria: {
          sSortAscending:
            ": Activar para ordenar la columna de manera ascendente",
          sSortDescending:
            ": Activar para ordenar la columna de manera descendente",
        },
      },
    })
    .DataTable();
});
$(document).on("click", "#btnnuevo", function () {
  $("#mnt_form")[0].reset();
  $("#mnt_modal").modal("show");
});
function editar(doc_id) {
  console.log(doc_id);
}
function eliminar(doc_id) {
  console.log(doc_id);
}
init();
