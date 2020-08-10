<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2020/7/9
  Time: 12:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>添加品牌</title>
</head>
<link href="/js/dataTable/DataTables-1.10.20/css/jquery.dataTables.min.css" rel="stylesheet"/>
<link href="/js/bootstrap3/css/bootstrap.min.css" rel="stylesheet">
<link href="/js/bootstrap3/bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css" rel="stylesheet"/>
<script src="/js/jquery.min.js"></script>
<script src="/js/dataTable/DataTables-1.10.20/js/jquery.dataTables.js"></script>
<link href="/js/bootstrap-fileinput/css/fileinput.min.css" rel="stylesheet"/>
<body>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <form class="form-horizontal">
                <div class="form-group">
                    <label  class="col-sm-2 control-label">品牌名</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" id="brandName" placeholder="请输入商品名...">
                    </div>
                </div>
                <div class="form-group">
                    <label  class="col-sm-2 control-label">logo</label>
                    <div class="col-sm-10">
                        <input type="file" id="mainImage" name="imageInfo">
                        <input type="text" id="mainImagePath"/>
                    </div>
                </div>

                <div style="text-align: center;">
                    <button type="button" class="btn btn-primary" onclick="addBrand();"><i class="glyphicon glyphicon-ok"></i> 增加</button>
                    <button type="reset" class="btn btn-default"><i class="glyphicon glyphicon-refresh"></i>重置</button>
                </div>
            </form>
        </div>
    </div>
</div>


<script src="/js/bootstrap3/js/bootstrap.min.js"></script>
<script src="/js/bootstrap3/js/bootbox.min.js"></script>
<script src="/js/bootstrap3/js/bootbox.locales.min.js"></script>
<script src="/js/bootstrap3/bootstrap-datetimepicker/js/moment-with-locales.js"></script>
<script src="/js/bootstrap3/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
<script src="/js/bootstrap-fileinput/js/fileinput.min.js"></script>
<script src="/js/bootstrap-fileinput/js/locales/zh.js"></script>


<script>
    //添加
    function addBrand() {
        var v_param = {};
        v_param.brandName = $("#brandName").val();
        $.ajax({
            type:"post",
            url:'/brand/add.jhtml',
            data:v_param,
            success:function (result) {
                if (result.code == 200) {
                    location.href="/brand/toList.jhtml";
                }
            }
        })

    }
</script>
</body>
</html>
