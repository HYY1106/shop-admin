<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/12/13 0013
  Time: 上午 11:43
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
    <title>商品管理</title>
    <link href="/js/dataTable/DataTables-1.10.20/css/jquery.dataTables.min.css" rel="stylesheet"/>
    <link href="/js/bootstrap3/css/bootstrap.min.css" rel="stylesheet">
    <link href="/js/bootstrap3/bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css" rel="stylesheet"/>
    <script src="/js/jquery.min.js"></script>
    <script src="/js/dataTable/DataTables-1.10.20/js/jquery.dataTables.js"></script>
    <link href="/js/bootstrap-fileinput/css/fileinput.min.css" rel="stylesheet"/>



</head>
<body>
<%--条件查询--%>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-primary">
                <div class="panel-heading">商品查询</div>
                <div class="panel-body">
                    <form class="form-horizontal" id="productForm">
                        <div class="form-group">
                            <label  class="col-sm-2 control-label">商品名</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" id="productName" name="productName" placeholder="请输入商品名...">
                            </div>
                            <label  class="col-sm-2 control-label">价格范围</label>
                            <div class="col-sm-4">

                                <div class="input-group">
                                    <input type="text" class="form-control" id="minPrice" name="minPrice" placeholder="请输入最小价格...">
                                    <span class="input-group-addon" ><i class="glyphicon glyphicon-yen"></i> </span>
                                    <input type="text" class="form-control" id="maxPrice" name="maxPrice" placeholder="请输入最大价格...">
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label  class="col-sm-2 control-label">品牌</label>
                            <div class="col-sm-4" id="brandSelectDiv">

                            </div>
                            <label  class="col-sm-2 control-label">日期范围</label>
                            <div class="col-sm-4">

                                <div class="input-group">
                                    <input type="text" class="form-control" id="minDate" name="minDate" placeholder="请输入最小日期...">
                                    <span class="input-group-addon" ><i class="glyphicon glyphicon-calendar"></i> </span>
                                    <input type="text" class="form-control" id="maxDate" name="maxDate" placeholder="请输入最大日期...">
                                </div>
                            </div>
                        </div>
                        <div style="text-align: center;">
                            <button type="button" class="btn btn-primary" onclick="search();"><i class="glyphicon glyphicon-search"></i> 查询</button>
                            <button type="reset" class="btn btn-default"><i class="glyphicon glyphicon-refresh"></i>重置</button>
                        </div>
                    </form>
                </div>
            </div>

        </div>
    </div>

    <%--展示页面--%>
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    商品列表
                    <button type="button" class="btn btn-success" onclick="toAdd();"><i class="glyphicon glyphicon-plus"></i> 增加</button>
                    <button type="button" class="btn btn-danger" onclick="deleteBatch();"><i class="glyphicon glyphicon-trash"></i>批量删除</button>

                </div>
                <table id="productTable" class="table table-striped table-bordered" style="width:100%">
                    <thead>
                    <tr>
                        <th></th>
                        <th>选择</th>
                        <th>商品id</th>
                        <th>商品名</th>
                        <th>logo</th>
                        <th>是否热销</th>
                        <th>状态</th>
                        <th>价格</th>
                        <th>品牌名</th>
                        <th>生产日期</th>
                        <th>录入时间</th>
                        <th>修改时间</th>
                        <th>操作</th>
                    </tr>
                    </thead>

                    <tfoot>
                    <tr>
                        <th></th>
                        <th>选择</th>
                        <th>商品id</th>
                        <th>商品名</th>
                        <th>logo</th>
                        <th>是否热销</th>
                        <th>状态</th>
                        <th>价格</th>
                        <th>品牌名</th>
                        <th>生产日期</th>
                        <th>录入时间</th>
                        <th>修改时间</th>
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

<script>

    $(function () {
        initTable();//查询
        initEvent();//背景色
        initBrandList();//品牌下拉框
        initDate("minDate");//日期
        initDate("maxDate");
    })



    //背景色
    var v_ids = [];
    function initEvent() {
        // $("#productTable tbody").on("click", "tr", function () {
        //     var v_checkbox = $(this).find("input[name='ids']:checkbox");
        //     var v_checked = v_checkbox.prop("checked");
        //     if (v_checked) {
        //         // 取消选中,取消背景色
        //         v_checkbox.prop("checked", false);
        //         $(this).css("background", "");
        //         for (var i = v_ids.length-1; i >= 0; i--) {
        //             if (v_ids[i] == v_checkbox.val()) {
        //                 v_ids.splice(i, 1);
        //                 break;
        //             }
        //         }
        //         console.log(v_ids);
        //     } else {
        //         // 选中，加上背景色
        //         v_checkbox.prop("checked", true);
        //         $(this).css("background", "pink");
        //         v_ids.push(v_checkbox.val());
        //         console.log(v_ids);
        //     }
        // })

        $('#productTable tbody').on('click', 'td.details-control', function () {
            var tr = $(this).closest('tr');
            var row = productTable.row( tr );

            if ( row.child.isShown() ) {
                // This row is already open - close it
                row.child.hide();
                tr.removeClass('shown');
            }
            else {
                // Open this row
                row.child( format(row.data()) ).show();
                tr.addClass('shown');
            }
        } );
    }


    //批量删除
    function deleteBatch() {
        if (v_ids.length > 0) {
            bootbox.confirm({
                message: "你确定删除吗?",
                size: 'small',
                title: "提示信息",
                buttons: {
                    confirm: {
                        label: '<span class="glyphicon glyphicon-ok"></span>确定',
                        className: 'btn-success'
                    },
                    cancel: {
                        label: '<span class="glyphicon glyphicon-remove"></span>取消',
                        className: 'btn-danger'
                    }
                },
                callback: function (result) {
                    if (result) {
                        // 发送请求，进行删除
                        $.ajax({
                            type:"post",
                            url:"/product/deleteBatch.jhtml",
                            data:{"ids":v_ids},
                            success:function (result) {
                                if (result.code == 200) {
                                    // 刷新
                                    search();
                                }
                            }
                        })
                    }
                }
            })
        } else {
            bootbox.alert({
                message: "<span class='glyphicon glyphicon-exclamation-sign'></span><b><font color='red'> 至少选择一个</font></b>",
                size: 'small',
                title: "提示信息"
            });
        }
    }

    //跳转添加
    function toAdd() {
        location.href="/product/toAdd.jhtml";
    }



    //日期转换
    function initDate(elementId) {
        $('#'+elementId).datetimepicker({
            format: 'YYYY-MM-DD',
            locale: 'zh-CN',
            showClear: true
        });
    }


    //品牌下拉框
    function initBrandList() {
        $.ajax({
            type:"post",
            url:"/brand/all.jhtml",
            success:function (result) {
                if (result.code == 200) {
                    var v_html = "<select class='form-control' id='brandSelect' name='brandId'><option value='-1'>===请选择===</option>";
                    var v_brandList = result.data;
                    for (var i = 0; i < v_brandList.length; i++) {
                        var v_brand = v_brandList[i];
                        v_html += "<option value='"+v_brand.id+"'>"+v_brand.brandName+"</option>";
                    }
                    v_html += "</select>";
                    $("#brandSelectDiv").html(v_html);
                }
            }
        })
    }
    //背景色
    function isExist(id) {
        for (var i = 0; i < v_ids.length; i++) {
            if (id == v_ids[i]) {
                return true;
            }
        }
        return false;
    }



    //查询
    var productTable;
    function initTable() {
        productTable = $('#productTable').DataTable({
            "language": {
                "url": "/js/Chinese.json"
            },
            // 是否允许检索
            "searching": false,
            "processing": true,
            "lengthMenu": [5,10,15,20],
            "serverSide": true,
            "ajax": {
                "url": "/product/queryList.jhtml",
                "type": "POST"
            },
            "drawCallback":function (s) {
                $("#productTable tbody tr").each(function () {
                    var v_checkbox = $(this).find("input[name='ids']:checkbox")[0];
                    // js中的非空判断，证明 v_checkbox 有值的时候，才会执行
                    if (v_checkbox) {
                        console.log(v_checkbox);
                        var v_id = v_checkbox.value;
                        if (isExist(v_id)) {
                            // 回填背景色
                            $(this).css("background", "pink");
                            $(v_checkbox).prop("checked", true);
                        }
                    }
                })
            },
            "columns": [
                {
                    "className":      'details-control',
                    "orderable":      false,
                    "data":           null,
                    "defaultContent": ''
                },
                {
                    "data":"id",
                    "render": function (data, type, row, meta) {
                        return "<input type='checkbox' name='ids' value='"+data+"'/>"
                    }
                },
                { "data": "id" },
                { "data": "productName" },//商品名
                {
                    "data": "mainImagePath",   //图片
                    "render": function (data, type, row, meta) {
                        return "<img src='"+data+"' width='100px' height='100px'/>"
                    }

                },
                {
                    "data": "isHot",       //热销
                    "render": function (data, type, row, meta) {
                        return data==0?"非热销":"热销";
                    }
                },
                {
                    "data": "status",      //上下架
                    "render": function (data, type, row, meta) {
                        return data==0?"下架":"上架";
                    }
                },
                { "data": "price" },//价格
                { "data": "brandName" },//品牌名
                { "data": "createDate" },//创建日期
                { "data": "insertTime" },//添加日期
                { "data": "updateTime" },//修改日期
                {
                    "data": "id",
                    "render": function (data, type, row, meta) {
                        //热销
                        var v_isHot = row.isHot;
                        var v_text = "";
                        var v_icon = "";
                        var v_color = "";
                        var v_hot_status;
                        //上下架
                        var v_status = row.status;
                        var v_status_text = "";
                        var v_status_icon = "";
                        var v_status_color = "";
                        var v_up_status;

                        //热销
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
                        //上下架
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
                        return "<button type=\"button\" class=\"btn btn-warning\" onclick=\"editProduct('"+data+"');\"><i class=\"glyphicon glyphicon-pencil\"></i>修改</button>\n" +
                            " <button type=\"button\" class=\"btn btn-danger\" onclick=\"deleteProduct('"+data+"')\"><i class=\"glyphicon glyphicon-trash\"></i>删除</button>" +
                            " <button type=\"button\" class=\""+v_color+"\" onclick=\"updateHotStatus('"+data+"','"+v_hot_status+"')\"><i class=\""+v_icon+"\"></i>"+v_text+"</button>"+
                            " <button type=\"button\" class=\""+v_status_color+"\" onclick=\"updateStatus('"+data+"','"+v_up_status+"')\"><i class=\""+v_status_icon+"\"></i>"+v_status_text+"</button>";
                    }
                },
            ]
        });
    }

    //跳转回显
    function editProduct(id) {
        event.stopPropagation();
        location.href = "/product/toUpdate.jhtml?id="+id;
    }

    //热销
    function updateHotStatus(id, status) {
        // 停止事件冒泡
        event.stopPropagation();
        $.ajax({
            type:"post",
            url:"/product/updateIsHotStatus.jhtml?id="+id+"&status="+status,
            success:function (result) {
                if (result.code == 200) {
                    search();
                }
            }
        })
    }

    //上下架
    function updateStatus(id, status) {
        // 停止事件冒泡
        event.stopPropagation();
        $.ajax({
            type:"post",
            url:"/product/updatesStatus.jhtml?id="+id+"&status="+status,
            success:function (result) {
                if (result.code == 200) {
                    search();
                }
            }
        })
    }


    //删除
    function deleteProduct(id) {
        bootbox.confirm({
            message: "你确定删除吗?",
            size: 'small',
            title: "提示信息",
            buttons: {
                confirm: {
                    label: '<span class="glyphicon glyphicon-ok"></span>确定',
                    className: 'btn-success'
                },
                cancel: {
                    label: '<span class="glyphicon glyphicon-remove"></span>取消',
                    className: 'btn-danger'
                }
            },
            callback: function (result) {
                if (result) {
                    // 发送请求，进行删除
                    $.ajax({
                        type:"post",
                        url:"/product/deleteProduct.jhtml",
                        data:{"id":id},
                        success:function (result) {
                            if (result.code == 200) {
                                // 刷新
                                search();
                            }
                        }
                    })
                }
            }
        })
    }

    //条件查询
    function search() {
        var v_param = {};
        v_param.productName = $("#productName").val();

        v_param.minPrice = $("#minPrice").val();
        v_param.maxPrice = $("#maxPrice").val();

        v_param.brandId = $("#brandSelect").val();

        v_param.minDate = $("#minDate").val();
        v_param.maxDate = $("#maxDate").val();

        productTable.settings()[0].ajax.data = v_param;
        productTable.ajax.reload();
    }
</script>
</body>
</html>