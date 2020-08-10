<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2020/6/30
  Time: 20:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>会员管理</title>


    <!--bootstrap-->
    <link href="/js/bootstrap3/css/bootstrap.min.css" rel="stylesheet">
    <%--表格插件--%>
    <link href="/js/dataTable/DataTables-1.10.20/css/jquery.dataTables.min.css" rel="stylesheet"/>
    <%--日期插件--%>
    <link href="/js/bootstrap3/bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css" rel="stylesheet"/>

</head>
<body>

<%--条件查询--%>
<div class="container">
    <div class="row">
        <div class="col-md-12">
          <div class="panel panel-primary">
              <div class="panel-heading">会员查询</div>
              <div class="panel-body">
                  <form class="form-horizontal" id="memberForm">
                      <%--会员名--%>
                      <div class="form-group">
                          <label class="col-sm-2 control-label">会员名</label>
                          <div class="col-sm-4">
                              <input type="text" class="form-control" id="memberName" placeholder="请输入会员名...">
                          </div>
                      </div>
                        <%--真实姓名--%>
                      <div class="form-group">
                          <label class="col-sm-2 control-label">真实姓名</label>
                      <div class="col-sm-4">
                          <input type="text" class="form-control" id="realName" placeholder="请输入真实姓名...">
                       </div>
                      </div>
                        <%--出生日期--%>
                      <div class="form-group">
                          <label class="col-sm-2 control-label">出生日期</label>
                          <div class="col-sm-4">
                              <div class="input-group">
                                  <input type="text" class="form-control" id="minDate">
                                  <span class="input-group-addon" id="sizing-addon2"><i class="glyphicon glyphicon-calendar"></i></span>
                                  <input type="text" class="form-control" id="maxDate">
                              </div>
                          </div>
                      </div>
                          <%--地区名--%>
                          <div class="form-group" id="areaDiv">
                              <label class="col-sm-2 control-label">地区名</label>

                          </div>



                          <%--按钮--%>
                      <div style="text-align: center;">
                          <button type="button" class="btn btn-primary" onclick="search()"><i class="glyphicon glyphicon-ok"></i>查询</button>
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
          <table id="memberTable" class="table table-striped table-bordered"  style="width:100%">
            <thead>
              <tr>
                  <th>选择</th>
                  <th>会员id</th>
                  <th>会员名</th>
                  <th>真实姓名</th>
                  <th>出生日期</th>
                  <th>手机号</th>
                  <th>邮箱</th>
                  <th>地区</th>
              </tr>
            </thead>

              <tfoot>
                <tr>
                    <th>选择</th>
                    <th>会员id</th>
                    <th>会员名</th>
                    <th>真实姓名</th>
                    <th>出生日期</th>
                    <th>手机号</th>
                    <th>邮箱</th>
                    <th>地区</th>
                </tr>
              </tfoot>
          </table>
        </div>
    </div>
</div>



<!--jquery(bootstrap的所有javascript插件都依赖jquery，所以必须放在前边)-->
<script src="/js/jquery.min.js"></script>
<!--加载bootstrap的所有javascript插件，你也可以根据需要只加载举个插件-->
<script src="/js/bootstrap3/js/bootstrap.min.js"></script>
<%--对话框--%>
<script src="/js/bootstrap3/js/bootbox.min.js"></script>
<script src="/js/bootstrap3/js/bootbox.locales.min.js"></script>
<%--表格插件--%>
<script  src="/js/DataTables/DataTables-1.10.20/js/jquery.dataTables.min.js"></script>
<script  src="/js/DataTables/DataTables-1.10.20/js/dataTables.bootstrap.min.js"></script>
<%--日期插件--%>
<<script src="/js/bootstrap3/bootstrap-datetimepicker/js/moment-with-locales.js"></script>
<script src="/js/bootstrap3/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js"></script>



<script>

    $(function () {
        initArea(0);//地区下拉框
        initDate();//日期转换
        initMemberTable();//查询
    })


    //地区下拉框
    function initArea(id,obj){

        if (obj){
            //删除当前下拉列表后的所有元素
            $(obj).parent().nextAll().remove();
        }


        $.ajax({
            type:"get",
            url:"/area/findChilds.jhtml",
            data:{"id":id},
            success:function(result){
                if (result.code == 200){
                    var v_areaArr = result.data;
                    if (v_areaArr.length > 0){
                        var v_areaHtml = '<div class="col-sm-3">\n'+
                            '<select class="form-control" onchange="initArea(this.value,this)" name="areaSelect"><option value="-1">===请选择===</option>';
                        for (let area of v_areaArr){
                            v_areaHtml += '<option value="'+area.id+'" data-area-name="'+area.areaName+'">'+area.areaName+'</option>';
                        }
                        v_areaHtml += '</select></div>';
                        $("#areaDiv").append(v_areaHtml);
                    }
                }
            }
        })
    }





    //日期转化格式
    function initDate(){
        $('#minDate').datetimepicker({
            format:'YYYY-MM-DD',
            locale:'zh-CN',
            showClear:true
        });

        $('#maxDate').datetimepicker({
            format:'YYYY-MM-DD',
            locale:'zh-CN',
            showClear:true
        });
    }

    //条件查询
    function search(){
        var param = {};
        param.memberName = $("#memberName").val();//会员名
        param.realName = $("#realName").val();//真实姓名
        param.minDate = $("#minDate").val();//最晚日期
        param.maxDate = $("#maxDate").val();//最早日期

        var shengId = $($("select[name='areaSelect']")[0]).val();
        var shiId = $($("select[name='areaSelect']")[1]).val();
        var xianId = $($("select[name='areaSelect']")[2]).val();
        param.shengId = shengId;
        param.shiId = shiId;
        param.xianId = xianId;

        memberTable.settings()[0].ajax.data = param;
        memberTable.ajax.reload();
    }

    //查询
    var memberTable;
    function initMemberTable(){
        memberTable = $('#memberTable').DataTable({
           "language":{
               "url":"/js/Chinese.json"//语言转为中文
           },
            //是否允许检索
            "searching":false,
            "processing":true,
            "lengthMenu":[5,10,15,20],//展示几条
            "serverSide":true,
            "ajax":{
               "url":"/member/queryList.jhtml",//查询路径
                "type":"post"//请求方式
            },
            "columns":[
                {
                    "data":"id",
                    "render":function(data,type,row,meta){
                        return "<input type='checkbox' name='ids' value='"+data+"'/>"
                    }
                },
                {"data":"id"},
                {"data":"memberName"},//会员名
                {"data":"realName"},//真实姓名
                {"data":"birthday"},//出生日期
                {"data":"phone"},//手机号
                {"data":"mail"},//邮箱
                {"data":"areaName"}//地区名
            ]
        });
    }
</script>

</body>
</html>
