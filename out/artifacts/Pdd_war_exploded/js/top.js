$(function () {
        $.get("top.jsp",function(data){
            $("#shopping_top").html(data);
        });
})