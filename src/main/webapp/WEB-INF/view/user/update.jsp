<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/12/26 0026
  Time: 上午 10:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>Bootstrap 101 Template</title>

    <link href="/js/bootstrap3/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="/js/bootstrap3/bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css" rel="stylesheet"/>
    <link href="/js/bootstrap-fileinput/css/fileinput.min.css" rel="stylesheet"/>

    <script src="/js/jquery.min.js"></script>
    <script src="/js/bootstrap3/js/bootstrap.min.js"></script>
    <script src="/js/bootstrap3/bootstrap-datetimepicker/js/moment-with-locales.js"></script>
    <script src="/js/bootstrap3/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
    <script src="/js/date-format.js"></script>
    <script src="/js/bootstrap-fileinput/js/fileinput.min.js"></script>
    <script src="/js/bootstrap-fileinput/js/locales/zh.js"></script>
</head>
<body>

<div class="container">
    <div class="row">
        <div class="col-md-12">
            <form class="form-horizontal">
                <div class="form-group">
                    <label  class="col-sm-2 control-label">用户名</label>
                    <div class="col-sm-3">
                        <input type="text" class="form-control" id="userName" placeholder="请输入用户名...">
                    </div>
                </div>

                <div class="form-group">
                    <label  class="col-sm-2 control-label">真实姓名</label>
                    <div class="col-sm-3">
                        <input type="text" class="form-control" id="realName" placeholder="请输入真实姓名...">
                    </div>
                </div>
                <div class="form-group">
                    <label  class="col-sm-2 control-label">密码</label>
                    <div class="col-sm-3">
                        <input type="text" class="form-control" id="password" placeholder="请输入密码...">
                    </div>
                </div>

                <div style="text-align: center;">
                    <button type="button" class="btn btn-primary" onclick="updateUser();"><i class="glyphicon glyphicon-ok"></i> 更新</button>
                    <button type="reset" class="btn btn-default"><i class="glyphicon glyphicon-refresh"></i>重置</button>
                </div>
            </form>
        </div>
    </div>
</div>



<script>
    $(function () {
        findUser();
    })

    //var v_shengId;
    //var v_shiId;
    //var v_xianId;
    function findUser() {
        var v_userId = '${param.id}';
        $.ajax({
            type:"post",
            url:"/user/findUser.jhtml?id="+v_userId,
            success:function (result) {
                if (result.code == 200) {
                    var v_user = result.data;
                    //v_shengId = v_user.shengId;
                    //v_shiId = v_user.shiId;
                    //v_xianId = v_user.xianId;

                    $("#userName").val(v_user.userName);
                    $("#realName").val(v_user.realName);
                    $("#password").val(v_user.password);
                    //$("#areaDiv").append("<span id='areaNameSpan'>"+v_user.areaName+"</span><button type=\"button\" class=\"btn btn-primary\" onclick='editArea();'><i class=\"glyphicon glyphicon-pencil\"></i><span id='areaButton'>编辑</span></button>");
                }
            }
        })
    }


   /* function initAreaList(id, obj) {
        // 先清除
        if (obj) {
            $(obj).parent().nextAll().remove();
        }
        $.ajax({
            type:"post",
            url:"/area/findChilds.jhtml",
            data:{"id":id},
            success:function (result) {
                if (result.code == 200) {
                    var v_areaList = result.data;
                    if (v_areaList.length > 0) {
                        var v_html = '<div class="col-sm-3" name="areaNameDiv"><select class="form-control" onchange="initAreaList(this.value, this)" name="areaSelect"><option value="-1">===请选择===</option>';
                        for (var i = 0; i < v_areaList.length; i++) {
                            var v_area = v_areaList[i];
                            v_html += "<option value='"+v_area.id+"'>"+v_area.areaName+"</option>";
                        }
                        v_html += "</select></div>";
                        $("#areaDiv").append(v_html);
                    }
                }
                console.log(result);
            }
        })
    }*/

    function updateUser() {
        var v_param = {};
        v_param.userName = $("#userName").val();
        v_param.realName = $("#realName").val();
        v_param.password = $("#password").val();

        //console.log($("select[name='areaSelect']")[0]);

       /* if ($("select[name='areaSelect']")[0]) {
            v_shengId = $("select[name='areaSelect']")[0].value;
        }
        if($("select[name='areaSelect']")[1]) {
            v_shiId = $("select[name='areaSelect']")[1].value;
        }
        if($("select[name='areaSelect']")[2]) {
            v_xianId = $("select[name='areaSelect']")[2].value;
        }
        v_param.shengId = v_shengId;
        v_param.shiId = v_shiId;
        v_param.xianId = v_xianId;*/
        // v_param.shengId = $("select[name='areaSelect']")[0].value;
        // v_param.shiId = $($("select[name='areaSelect']")[1]).val();
        // v_param.xianId = $($("select[name='areaSelect']")[2]).val();
        v_param.id = '${param.id}';
        $.ajax({
            type:"post",
            url:"/user/update.jhtml",
            data:v_param,
            success:function (result) {
                if (result.code == 200) {
                    location.href="/user/toList.jhtml";
                }
            }
        })
    }
</script>
</body>
</html>
