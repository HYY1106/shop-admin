<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2020/7/16
  Time: 21:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户页面</title>
    <link href="/js/dataTable/DataTables-1.10.20/css/jquery.dataTables.min.css" rel="stylesheet"/>
    <link href="/js/bootstrap3/css/bootstrap.min.css" rel="stylesheet">
    <link href="/js/bootstrap3/bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css" rel="stylesheet"/>
    <script src="/js/jquery.min.js"></script>
    <script src="/js/dataTable/DataTables-1.10.20/js/jquery.dataTables.js"></script>
    <link href="/js/bootstrap-fileinput/css/fileinput.min.css" rel="stylesheet"/>

    <script src="/js/bootstrap3/js/bootbox.min.js"></script>
    <script src="/js/bootstrap3/js/bootbox.locales.min.js"></script>
</head>
<body>
       <div class="container">
           <div class="row">
               <div class="clo-md-12">
                   <div class="panel panel-primary">
                       <div class="panel-heading">用户查询</div>
                       <div class="panel-body">
                           <form class="form-horizontal" id="userForm">
                               <div class="form-group">
                                   <label class="clo-sm-2 control-label">用户名称</label>
                                   <div class="clo-sm-4">
                                       <input type="text" class="form-control" id="userName" name="userName" placeholder="请输入用户名称...">
                                   </div>
                               </div>

                               <div class="form-group">
                                   <label class="clo-sm-2 control-label">真实姓名</label>
                                   <div class="clo-sm-4">
                                       <input type="text" class="form-control" id="realName" name="realName" placeholder="请输入真实姓名...">
                                   </div>
                               </div>

                               <div style="text-align: center;">
                                   <button type="button" class="btn btn-primary" onclick="search()"><i class="glyphicon glyphicon-search"></i>查询</button>
                                   <button type="reset" class="btn btn-default"><i class="glyphicon glyphicon-refresh"></i>重置</button>
                               </div>
                           </form>
                       </div>
                   </div>
               </div>
           </div>


           <div class="row">
               <div class="panel panel-primary">
                   <div class="panel-heading">
                       <button type="button" class="btn btn-success" onclick="toAdd();"><i class="glyphicon glyphicon-plus"></i>增加</button>
                       <button type="button" class="btn btn-danger" onclick="deleteBatch();"><i class="glyphicon glyphicon-trash"></i>批量删除</button>
                   </div>
                   <table id="userTable" class="table table-striped table-bordered" style="width: 100%">
                       <thead>
                       <tr>
                           <th>选择</th>
                           <th>用户名称</th>
                           <th>真实姓名</th>
                           <th>操作</th>
                       </tr>
                       </thead>

                       <tbody>
                       <tr>
                           <th>选择</th>
                           <th>用户名称</th>
                           <th>真实姓名</th>
                           <th>操作</th>
                       </tr>
                       </tbody>
                   </table>
               </div>
           </div>
       </div>





<script>
    
    $(function () {
        initTable();//查询
    })



    //条件查询
    function search() {
        var v_param = {};

        //v_param.shengId = $("select[name='areaSelect']")[0].value;
        //v_param.shiId = $($("select[name='areaSelect']")[1]).val();
        //v_param.xianId = $($("select[name='areaSelect']")[2]).val();

        v_param.userName = $("#userName").val();
        v_param.realName = $("#realName").val();

        userTable.settings()[0].ajax.data = v_param;
        userTable.ajax.reload();
    }


   //查询
    var userTable;
    function initTable() {
        userTable = $('#userTable').DataTable({
            "language": {
                "url": "/js/Chinese.json"
            },
            // 是否允许检索
            "searching": false,
            "processing": true,
            "lengthMenu": [5,10,15,20],
            "serverSide": true,
            "ajax": {
                "url": "/user/queryList.jhtml",
                "type": "POST"
            },
            "columns": [
                {
                    "data":"id",
                    "render": function (data, type, row, meta) {
                        return "<input type='checkbox' name='ids' value='"+data+"'/>"
                    }
                },
                { "data": "userName" },
                {"data": "realName"},
                {
                    "data": "id",
                    "render": function (data, type, row, meta) {
                        var v_isHot = row.isHot;
                        var v_text = "";
                        var v_icon = "";
                        var v_color = "";
                        var v_hot_status;

                        var v_status = row.status;
                        var v_status_text = "";
                        var v_status_icon = "";
                        var v_status_color = "";
                        var v_up_status;

                        if (v_isHot == 1) {
                            // 非热销
                            v_text = "非热销";
                            v_hot_status = 0;
                            v_icon = "glyphicon glyphicon-hand-down";
                            v_color = "btn btn-default";
                        } else {
                            v_text = "热销";
                            v_hot_status = 1;
                            v_icon = "glyphicon glyphicon-fire";
                            v_color = "btn btn-success";
                        }
                        if (v_status == 1) {
                            // 下架
                            v_status_text = "下架";
                            v_status_icon = "glyphicon glyphicon-arrow-down";
                            v_status_color = "btn btn-default";
                            v_up_status = 0;
                        } else {
                            // 上架
                            v_status_text = "上架";
                            v_status_icon = "glyphicon glyphicon-arrow-up";
                            v_status_color = "btn btn-success";
                            v_up_status = 1;
                        }
                        return "<button type=\"button\" class=\"btn btn-warning\" onclick=\"updateUser('"+data+"');\"><i class=\"glyphicon glyphicon-pencil\"></i>修改</button>\n" +
                            " <button type=\"button\" class=\"btn btn-danger\" onclick=\"deleteUser('"+data+"')\"><i class=\"glyphicon glyphicon-trash\"></i>删除</button>" +
                            " <button type=\"button\" class=\""+v_color+"\" onclick=\"updateHotStatus('"+data+"','"+v_hot_status+"')\"><i class=\""+v_icon+"\"></i>"+v_text+"</button>"+
                            " <button type=\"button\" class=\""+v_status_color+"\" onclick=\"updateStatus('"+data+"','"+v_up_status+"')\"><i class=\""+v_status_icon+"\"></i>"+v_status_text+"</button>";
                    }
                },
            ]
        });
    }






    function toAdd() {
        location.href="/user/toAdd.jhtml";
    }

    function updateUser(userId) {
        event.stopPropagation();
        location.href = "/user/toEdit.jhtml?id="+userId;
    }
</script>
</body>
</html>
