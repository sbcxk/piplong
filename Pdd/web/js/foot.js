$(function () {
    $.get("bottom.jsp",function(data){
        $("#shopping_foot").html(data);
    });
})