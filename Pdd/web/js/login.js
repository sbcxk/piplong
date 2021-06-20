window.onload = function () {
    var passwordtitle=document.getElementById("login_type_password_title");
    var QRcodetitle=document.getElementById("login_type_QRcode_title");
    var passwordform=document.getElementById("login_type_password_form");
    var QRcodeform=document.getElementById("login_type_QRcode_form");

    passwordtitle.onclick=function () {
        passwordtitle.style.color="#C71523";
        QRcodetitle.style.color="#656565";

        passwordform.style.display="block";
        QRcodeform.style.display="none";
    }
    QRcodetitle.onclick=function () {
        passwordtitle.style.color="#656565";
        QRcodetitle.style.color="#C71523";

        passwordform.style.display="none";
        QRcodeform.style.display="block";
    }
}