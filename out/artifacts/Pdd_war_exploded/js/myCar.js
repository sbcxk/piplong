$(function() {
    showTotal();//计算总计
    //setJieSuan(false);
    //setItemCheckBox(false);
    /*
    给全选添加click事件
    */
    document.getElementById("selectAll").onclick = function(){
        //第一个cb点击
        //1.获取所有的checkbox
        var cbs = document.getElementsByName("checkboxBtn");
        //获取第一个cb
        var bools = document.getElementsByName("selectAll");
        //alert(bools[0].checked);
        var bool=false;
        //alert(bools[0].checked)

        try{
            bool=bools[0].checked;
        }catch(err) {
                console.log(err.stack);
        }
        //alert(bool+","+bools[0].checked);
        //2.遍历
        for (var i = 0; i < cbs.length; i++) {
            //3.设置每一个cb的状态和第一个cb的状态一样
            cbs[i].checked =  this.checked;
        }
        //2. 让所有条目的复选框与全选的状态同步
        setItemCheckBox(bool);
        setJieSuan(bool);
        showTotal();
    }

    /*
    给所有条目的复选框添加click事件
    */
    $(":checkbox[name=checkboxBtn]").click(function() {
        //1.获取所有的checkbox
        var cbs = document.getElementsByName("checkboxBtn");
        var all = cbs.length;
        //获取所有被选择条目的个数
        var select = 0;
        for (var i = 0; i < cbs.length; i++) {
            if(cbs[i].checked ==  true){
                select++;
            }
        }
        //alert("条目个数: "+all);
        //alert("已选个数: "+select);
        if(all == select) {//全都选中了
            //勾选全选复选框
            //获取第一个cb
            var bools = document.getElementsByName("selectAll");
            try{
                bools[0].checked=true;
            }catch(err) {
                console.log(err.stack);
            }

            setJieSuan(true);//让结算按钮有效
        } else if(select == 0) {//谁都没有选中
            //取消全选
            var bools = document.getElementsByName("selectAll");
            try{
                bools[0].checked=false;
            }catch(err) {
                console.log(err.stack);
            }

            setJieSuan(false);//让结算失效
        } else {
            //取消全选
            var bools = document.getElementsByName("selectAll");
            try{
                bools[0].checked=false;
            }catch(err) {
                console.log(err.stack);
            }

            setJieSuan(true);//让结算有效
        }
        showTotal();//重新计算总计
    });

    /*
    给减号添加click事件
    */
    $(".reduction").click(function() {
        // 获取cartItemId
        var id = $(this).attr("id").substring(0, 32);
        // 获取输入框中的数量
            //var text = $("#" + id + "Count").text();
        try {
            var count = document.getElementById("" + id + "Count").value;
        }catch (e) {
        }
        //alert("id: "+id);
        //alert("数量："+count)
        // 判断当前数量是否为1，如果为1,那就不是修改数量了，而是要删除了。
        if(count == 1) {
            if (confirm("您忍心抛弃我吗?")) {
                location.href = "./CartItemServlet?method=batchDelete&cartItemIds=" + id;
            }
        } else {
            sendUpdateCount(id, count-1);
        }
    });

    // 给加号添加click事件
    $(".sign").click(function() {
        // 获取cartItemId
        var id = $(this).attr("id").substring(0, 32);
        // 获取输入框中的数量
        try {
            var count = document.getElementById("" + id + "Count").value;
        }catch (e) {

        }
        sendUpdateCount(id, Number(count)+1);
    });
});
// 请求服务器，修改数量。
function sendUpdateCount(id, count) {
    $.ajax({
        async:false,
        cache:false,
        url:"./CartItemServlet",
        data:{method:"updateCount",cartItemId:id,count:count},
        type:"POST",
        dataType:"json",
        success:function(result) {
            //1. 修改数量
            //$("#" + id + "Count").val(result.count);
            document.getElementById("" + id + "Count").value=result.count;
            //alert("数量："+result.count);
            //2. 修改小计
            document.getElementById("" + id + "Subtotal").innerHTML=result.subtotal;
            //alert("小计："+result.subtotal);
            //$("#" + id + "Subtotal").text(result.subtotal);
            //3. 重新计算总计
            showTotal();
        }
    });
}
/*
 * 计算总计
 */
function showTotal() {

    var total = 0.00;
    /*
    1. 获取所有的被勾选的条目复选框！循环遍历之
    */
    $(":checkbox[name=checkboxBtn]").each(function() {
        if(this.checked){
            var id = $(this).val();
            //3. 再通过前缀找到小计元素，获取其文本
            var text = $("#" + id + "Subtotal").text();
            //var text =document.getElementById("" + id + "Subtotal").value;
            //alert(text);
            //4. 累加计算
            total += Number(text);
        }
    });

    // 5. 把总计显示在总计元素上
    total = total.toFixed(2);
    document.getElementById("total").innerHTML=total;
    //$("#total").text(round(total, 2));//round()函数的作用是把total保留2位
    //alert("o总计："+total);
}

/*
 * 统一设置所有条目的复选按钮
 */
function setItemCheckBox(bool) {
    $(":checkbox[name=checkboxBtn]").attr("checked", bool);
}

/*
 * 设置结算按钮样式
 */
function setJieSuan(bool) {

    let b=document.getElementById('btn');
    if (bool) {
        b.disabled = false;
        $("#btn").removeClass("nono");
        /*$("#jiesuan").removeClass("kill").addClass("jiesuan");
        $("#jiesuan").unbind("click");//撤消当前元素止所有click事件*/
    } else {
        b.disabled = true;
        $("#btn").addClass("nono");
        /*$("#jiesuan").removeClass("jiesuan").addClass("kill");
        $("#jiesuan").click(function() {return false;});*/
    }

}


/*
 * 结算
 */
function order() {
    // 1. 获取所有被选择的条目的id，放到数组中
    var cartItemIdArray = new Array();
    $(":checkbox[name=checkboxBtn]").each(function() {
        if(this.checked){
            cartItemIdArray.push($(this).val());//把复选框的值添加到数组中
        }

    });
    //alert(cartItemIdArray.toString());
    // 2. 把数组的值toString()，然后赋给表单的cartItemIds这个hidden
    $("#cartItemIds").val(cartItemIdArray.toString());
    // 把总计的值，也保存到表单中
    var val=document.getElementById("total").innerHTML;
    //alert(val);
    $("#hiddenTotal").val(val);
    // 3. 提交这个表单
    $("#orderForm").submit();
}