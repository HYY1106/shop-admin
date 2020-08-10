<%--
  Created by IntelliJ IDEA.
  User: sss
  Date: 2019/12/13
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false"%>
<html>
<head>
    <title>添加商品</title>
</head>
<link href="/js/bootstrap3/css/bootstrap.min.css" rel="stylesheet"/>
<link href="/js/bootstrap3/bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css" rel="stylesheet">
<link href="/js/bootstrap-fileinput/css/fileinput.min.css" rel="stylesheet"/>
<script src="/js/jquery.min.js"></script>
<body>
    <div class="container">
       <div class="row">
           <div class="col-md-12">
              <form class="form-horizontal" >
                  <div class="form-group">
                      <label class="col-sm-2 control-label">商品名称</label>
                      <div class="col-sm-10">
                          <input type="text" class="form-control" id="productName" placeholder="请输入商品名...">
                      </div>
                  </div>
                  <div class="form-group">
                      <label class="col-sm-2 control-label">商品价格</label>
                      <div class="col-sm-10">
                          <input type="text" class="form-control" id="price" placeholder="请输入商品价格...">
                      </div>
                  </div>
                  <div class="form-group">
                      <label class="col-sm-2 control-label">商品品牌</label>
                      <div class="col-sm-10" id="brandSelectDiv">

                      </div>
                  </div>
                  <div class="form-group">
                      <label class="col-sm-2 control-label">是否热销</label>
                      <div class="col-sm-10">
                          <input type="radio"  name="isHot" value="1">热销
                          <input type="radio"  name="isHot" value="0">非热销
                      </div>
                  </div>
                  <div class="form-group">
                      <label class="col-sm-2 control-label">生产日期</label>
                      <div class="col-sm-10">
                          <input type="text" class="form-control" id="createDate" placeholder="请输入生产日期...">
                      </div>
                  </div>

                  <div class="form-group">
                      <label class="col-sm-2 control-label">是否上架</label>
                      <div class="col-sm-10">
                          <input type="radio"  name="status" value="1">上架
                          <input type="radio"  name="status" value="0">下架
                      </div>
                  </div>
                  <div class="form-group">
                      <label  class="col-sm-2 control-label">主图</label>
                      <div class="col-sm-10">
                          <input type="file" id="mainImage" name="imageInfo">
                          <input type="text" id="mainImagePath"/>
                      </div>
                  </div>

                  <div style="text-align: center;">
                      <button type="button" class="btn btn-primary" onclick="addProduct();"><i class="glyphicon glyphicon-ok"></i> 增加</button>
                      <button type="reset" class="btn btn-default"><i class="glyphicon glyphicon-refresh"></i>重置</button>
                  </div>
              </form>
           </div>
       </div>
    </div>
    <script src="/js/bootstrap3/js/bootstrap.min.js"></script>
    <script src="/js/bootstrap3/bootstrap-datetimepicker/js/moment-with-locales.js"></script>
    <script src="/js/bootstrap3/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
    <script src="/js/bootstrap-fileinput/js/fileinput.min.js"></script>
    <script src="/js/bootstrap-fileinput/js/locales/zh.js"></script>
</body>
   <script>

               //添加
               function addProduct(){

                   var v_name = $("#productName").val();
                   var v_price = $("#price").val();
                   var v_brandId = $("#brandSelect").val();
                   var v_createDate = $("#createDate").val();
                   var v_param = {};

                   v_param.productName = v_name;
                   v_param.price = v_price;
                   v_param.brandId = v_brandId;
                   v_param.createDate = v_createDate;
                   v_param.mainImagePath = $("#mainImagePath").val();
                   //v_param.stock = $("#stock").val();
                   v_param.isHot = $("[name='isHot']:checked").val();
                   v_param.status = $("[name='status']:checked").val();
                   alert(v_param.status)

                   $.ajax({
                       url:"/product/addProduct.jhtml",
                       data:v_param,
                       type:"post",
                       success:function(result){
                           if(result.code==200){
                               location.href="/product/index.jhtml"
                           }
                       },
                       error:function(){
                           alert("添加失败")
                       }
                   })
               }


$(function(){
    initBrandList();//品牌下拉框
    showDate();//日期转换
    initMainImage();//图片上传
})

               //图片上传
               function initMainImage() {
                   var s = {
                       language: 'zh',
                       uploadUrl: "/file/uploadImage.jhtml",
                       showUpload : false,
                       showRemove : false,
                       allowedFileExtensions : [ 'jpg', 'png', 'jpeg', 'gif'] //上传的文件的后缀名
                   };
                   $("#mainImage").fileinput(s).on("fileuploaded", function (event, r, previewId, index){
                       var result = r.response;
                       if (result.code == 200) {
                           // 赋值
                           $("#mainImagePath").val(result.data);
                       }
                   });
               }






               //品牌下拉框
               function initBrandList() {
                   $.ajax({
                       type:"post",
                       url:"/brand/all.jhtml",
                       success:function (result) {
                           if (result.code == 200) {
                               var v_html = "<select class='form-control' id='brandSelect'><option value='-1'>===请选择===</option>";
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

               //日期转换
               function showDate(){
                   $("#createDate").datetimepicker({
                       format:"YYYY-MM-DD",
                       locale:"zh-CN",
                   });
               }
   </script>
</html>
