var xmlHttp;

function checkForm1() {
    var form = document.getElementById("regis")
    if (form.name.value.trim() == "") {//判断用户名是否为空
        alert("用户名不能为空!");
        form.account.focus();
        return;
    }
    if (form.password.value.trim() == "") {//判断密码是否为空
        alert("密码不能为空!");
        form.pwd.focus();
        return;
    }
    if ($("#ajax").text() == "用户名已存在！") {
        alert("该用户名不可用");
        form.pwd.focus();
        return;
    }

    if (form.email.value.trim() == "") {
        alert("邮箱不可为空");
        form.email.focus();
        return;
    }
    var strReg = "";
    var r;
    var strText = form.email.value;
    //strReg=/^\w+((-\w+)(\.\w+))*\@[A-Za-z-9]+((\.-)[A-Za-z-9]+)*\.[A-Za-z-9]+$/i;
    strReg = /^\w+((-\w+)(\.\w+))*\@{}\w+\.{}\w{,}(\.{,}\w{}){,}/ig;
    r = strText.search(strReg);
    if (r == -1) {
        alert("邮箱格式错误!");
        document.getElementById("email").focus();
        form.email.focus();
        return;
    }

    if (form.validate.value != document.getElementById("valiDate").value) {//验证码是否正确
        alert("验证码错误！请重新输入")
        form.validate.focus();
        return;
    }
    form.action = "/user/addUser";
    form.method = "post";
    form.submit();
}

function getCode(n) {//生成验证码的数字
    var all = "azxcvbnmsdfghjklqwertyuiopZXCVBNMASDFGHJKLQWERTYUIOP0123456789";
    var b = "";
    for (var i = 0; i < n; i++) {
        var index = Math.floor(Math.random() * 62);//从这62个字母或数字中取一个
        b += all.charAt(index);
    }
    return b;
}

function change() {
    document.getElementById("valiDate").value = getCode(4);
}

function checkForm() {//检查登陆界面的表单是否符合标准
    var form = document.getElementById("login")
    if (form.name.value.trim() == "") {
        alert("用户名不能为空!");
        form.id.focus();
        return;
    }
    if (form.password.value.trim() == "") {
        alert("密码不能为空!");
        form.pwd.focus();
        return;
    }
    if (form.validate.value != document.getElementById("valiDate").value) {
        alert("验证码错误！请重新输入")
        form.validate.focus();
        return;
    }
    form.action = "/user/findUser";
    form.method = "post";
    form.submit();
}