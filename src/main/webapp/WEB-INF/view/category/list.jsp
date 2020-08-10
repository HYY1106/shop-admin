<%--
  Created by IntelliJ IDEA.
  User: 毛宁波
  Date: 2019/12/28
  Time: 15:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--表格插件--%>
<link href="/js/dataTable/DataTables-1.10.20/css/jquery.dataTables.min.css" rel="stylesheet"/>
<%--bootStrap--%>
<link href="/js/bootstrap3/css/bootstrap.min.css" rel="stylesheet">
<%--树形结构--%>
<link href="/js/zTree/css/zTreeStyle/zTreeStyle.css" rel="stylesheet">
<%--jquery--%>
<script src="/js/jquery.min.js"></script>
<%--表格插件--%>
<script src="/js/dataTable/DataTables-1.10.20/js/jquery.dataTables.js"></script>
<script src="/js/bootstrap3/js/bootstrap.min.js"></script>
<%--输入框--%>
<script src="/js/bootstrap3/js/bootbox.min.js"></script>
<script src="/js/bootstrap3/js/bootbox.locales.min.js"></script>
<%--树形结构--%>
<script type="text/javascript" src="/js/zTree/js/jquery.ztree.all.js"></script>

<html>
<body>
<title>分类管理</title>
<script type="text/javascript">
    var setting = {
        view:{
            // 禁止多选
            //selectedMulti:false
        },
        data:{
            simpleData:{
                enable:true,
                pIdKey:"pid"
                // idKey:"id" 默认是id
            },
            key:{
                url:"",
                name:"categoryName"
            },
        }
    };


    var addCategoryHtml;
    var updateCategoryHtml;

    var zTreeObj;
    $(function () {
        queryCategory();
        addCategoryHtml = $("#addCategoryDiv").html();
    })
    // 查询
    function queryCategory() {
        $.ajax({
            url:"/category/queryCategory.jhtml",
            type:"post",
            dataType:"json",
            success:function (result) {
                if (result.code ==200){
                    zTreeObj = $.fn.zTree.init($("#categoryZTree"),setting,result.data);
                }
            }
        })
    }

    // 添加
    function addCategory() {
        var selectedNode = zTreeObj.getSelectedNodes();
        if (selectedNode.length == 0){
            alert("请选择节点");
        }else {
            var nodes = selectedNode[0];
            var id = nodes.id;

            console.log(id);
            bootbox.confirm({
                title:"新增分类",
                message:$("#addCategoryDiv").children(),
                buttons:{
                    confirm:{
                        label:"确认"
                    },
                    cancel:{
                        label:"取消",
                        className:"btn btn-danger"
                    }
                },
                callback:function (result) {
                    if (result){
                        var v_param = {};
                        v_param.categoryName = $("#addCategoryName").val();
                        v_param.pid = id;

                        $.ajax({
                            url:"/category/addCategory.jhtml",
                            data:v_param,
                            type:"post",
                            success:function (result) {
                                if (result.code == 200){
                                    var newNodes = {id:result.data , categoryName:v_param.categoryName , pid:id};
                                    zTreeObj.addNodes(nodes, newNodes);
                                }
                            }
                        })
                    }
                    $("#addCategoryDiv").html(addCategoryHtml);
                }
            })
        }
    }

    // 删除
    function deleteCategory(id) {

        var selectedNode = zTreeObj.getSelectedNodes();
        if (selectedNode.length == 0){
            alert("请选择要删除的节点");
        }else {
            var v_ids = [];
            var nodes = zTreeObj.transformToArray(selectedNode);
            for (var i = 0; i < nodes.length ; i ++){
                v_ids.push(nodes[i].id);
            }
            console.log(v_ids);
            $.ajax({
                url:"/category/deleteCategory.jhtml",
                type:"post",
                data:{"ids" : v_ids},
                success:function (result) {
                    for (var i = 0; i<selectedNode.length ; i++){
                        zTreeObj.removeNode(selectedNode[i]);
                    }
                }
            })
        }

    }


</script>
</body>


<div class="panel panel-primary">
    <div class="panel-heading">
        <h1 class="panel-title">
            分类列表
            <button type="button" onclick="addCategory()" class="btn btn-success"><span class="glyphicon glyphicon-plus"></span>新增</button>
            <button type="button" onclick="deleteCategory()" class="btn btn-danger"><span class="glyphicon glyphicon-trash"></span>删除</button>
            <button type="button" onclick="deleteProduct()" class="btn btn-warning"><span class="glyphicon glyphicon-plus"></span>修改</button>
        </h1>
    </div>
    <div class="panel-body">
        <div>
            <ul id="categoryZTree" class="ztree"></ul>
        </div>
    </div>
</div>
<div class="panel panel-primary" style="display: none" id="addCategoryDiv">
    <div class="panel-body">
        <form class="form-horizontal" >
            <label  class="col-sm-3 control-label">分类名</label>
            <div class="col-sm-7">
                <input type="text" class="form-control" id="addCategoryName" placeholder="请输入分类名...">
            </div>
        </form>
    </div>
</div>
