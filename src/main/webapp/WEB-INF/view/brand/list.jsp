<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2020/7/9
  Time: 12:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>品牌列表</title>
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
            <div class="panel panel-primary">
                <div class="panel-heading">
                    品牌列表
                    <button type="button" class="btn btn-success" onclick="toAdd();"><i class="glyphicon glyphicon-plus"></i> 增加</button>
                    <button type="button" class="btn btn-danger" onclick="deleteBatch();"><i class="glyphicon glyphicon-trash"></i>批量删除</button>

                </div>
                <table id="brandTable" class="table table-striped table-bordered" style="width:100%">
                    <thead>
                    <tr>
                        <th>选择</th>
                        <th>品牌名</th>
                        <th>logo</th>
                        <th>操作</th>
                    </tr>
                    </thead>

                    <tfoot>
                    <tr>
                        <th>选择</th>
                        <th>品牌名</th>
                        <th>logo</th>
                        <th>操作</th>
                    </tr>
                    </tfoot>
                </table>
            </div>
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
</body>
<script>
    //跳转添加
    function toAdd() {
        location.href="/brand/toAdd.jhtml";
    }


    $(function () {
        initBrandTable();//查询
    })

    //查询
    var v_brandTable;
    function initBrandTable() {
        v_brandTable = $('#brandTable').DataTable({
            "language": {
                "url": "/js/Chinese.json"
            },
            // 是否允许检索
            "searching": false,
            "processing": true,
            "lengthMenu": [5,10,15,20],
            "serverSide": true,
            "ajax": {
                "url": "/brand/list.jhtml",
                "type": "POST"
            },
            "columns": [
                {
                    "data":"id",
                    "render": function (data, type, row, meta) {
                        return "<input type='checkbox' name='ids' value='"+data+"'/>"
                    }
                },
                { "data": "brandName" },
                { "data": "logo" },
                {
                    "data": "id",
                    "render": function (data, type, row, meta) {
                        return "<button type=\"button\" class=\"btn btn-warning\" onclick=\"editType('"+data+"');\"><i class=\"glyphicon glyphicon-pencil\"></i>修改</button>\n" +
                            " <button type=\"button\" class=\"btn btn-danger\" onclick=\"deleteType('"+data+"')\"><i class=\"glyphicon glyphicon-trash\"></i>删除</button>"
                    }
                }
            ]
        });
    }

    //刷新
    function search() {
        v_brandTable.ajax.reload();
    }



</script>
</html>
