

$(document).ready(function() {
    $.post("../../controller/area.php?op=combo",function(data){
        $('#area_id').html(data);
        /* console.log(data); */
    });
    $.post("../../controller/tramite.php?op=combo",function(data){
        $('#tra_id').html(data);
        /* console.log(data); */
    });
    /* $('#area_id').select2(); */
});