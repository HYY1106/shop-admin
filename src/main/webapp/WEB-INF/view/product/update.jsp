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
    <title>修改商品</title>
</head>
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
<body>
    <div class="container">
       <div class="row">
           <div class="col-md-12">
               <form class="form-horizontal" >
                   <div class="form-group">
                       <label class="col-sm-2 control-label">商品名</label>
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
                           <input type="text" id="oldMainImagePath" />
                           <input type="text" id="mainImagePath" />
                       </div>
                   </div>
                   <%--<div class="form-group">
                       <label class="col-sm-2 control-label">库存</label>
                       <div class="col-sm-10">
                           <input type="text" class="form-control" id="stock">
                       </div>
                   </div>--%>

                   <div style="text-align: center;">
                       <button type="button" class="btn btn-primary" onclick="updateProduct();"><i class="glyphicon glyphicon-ok"></i> 修改</button>
                       <button type="reset" class="btn btn-default"><i class="glyphicon glyphicon-refresh"></i>重置</button>
                   </div>
               </form>
           </div>
       </div>
    </div>
</body>
   <script>

       $(function(){
           initBrandList();//品牌下拉框
           findProductById();//回显
           showDate();//日期转换
       })

       //


       //日期转换
       function showDate(){
           $("#createDate").datetimepicker({
               format:"YYYY-MM-DD",
               locale:"zh-CN",
           });
       }


       //回显
       function findProductById(){
           var v_id = '${param.id}';
           alert(v_id)
           $.ajax({
               url:"/product/findProductById.jhtml",
               data:{"id":v_id},
               type:"post",
               success:function(result){
                  if(result.code==200){
                      // 回填值
                      console.log(result);
                      var data = result.data;

                      $("#productName").val(data.productName);
                      $("#price").val(data.price);
                      $("[name='isHot'][value=" + data.isHot + "]").prop("checked",true);
                      $("[name='status'][value=" + data.status + "]").prop("checked",true);
                      //$("#stock").val(data.stock);
                      $("#brandSelect").val(data.brandId);
                      $("#createDate").val(data.createDate);

                      var v_imageArr = [];
                      v_imageArr.push(data.mainImagePath);
                      $("#oldMainImagePath").val(data.mainImagePath);
                      initMainImage(v_imageArr);
                  }
               },

               error:function(){
                   alert("回显失败")
               }
           })

       }
       //图片上传
       /*function initMainImage() {
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
       }*/


       function initMainImage(imageArr) {

           var s = {
               language: 'zh',
               uploadUrl: "/file/uploadImage.jhtml",
               showUpload : false,
               showRemove : false,
               initialPreview:imageArr,
               initialPreviewAsData: true,
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



                //修改
               function updateProduct(){
                   var v_id = '${param.id}';
                   var v_productName = $("#productName").val();
                   var v_price = $("#price").val();
                   var v_brandId = $("#brandSelect").val();
                   var v_mainImagePath = $("#mainImagePath").val();
                   var v_oldMainImagePath = $("#oldMainImagePath").val();
                   var v_isHot = $("[name='isHot']:checked").val();
                   var v_status = $("[name='status']:checked").val();
                   $.ajax({
                       url:"/product/updateProduct.jhtml",
                       data:{
                           "id":v_id,
                           "productName":v_productName,
                           "price":v_price,
                           "brandId":v_brandId,
                           "mainImagePath":v_mainImagePath,
                           "oldMainImagePath":v_oldMainImagePath,
                           "isHot":v_isHot,
                           "status":v_status
                       },
                       type:"post",
                       success:function(result){
                             location.href="/product/index.jhtml"
                       },
                       error:function(){
                           alert("添加失败")
                       }
                   })
               }


       //品牌下拉框
       function initBrandList() {
           $.ajax({
               type:"post",
               url:"/brand/all.jhtml",
               async:false,
               success:function (result) {
                   if (result.code == 200) {
                       var v_brandList = result.data;
                       var v_html = "<select class='form-control' id='brandSelect'><option value='-1'>===请选择===</option>";
                       for (var i = 0; i < v_brandList.length; i++) {
                           var v_brand = v_brandList[i];
                           v_html+= "<option value='"+v_brand.id+"'>"+v_brand.brandName+"</option>";
                       }
                       v_html+= "</select>";
                       $("#brandSelectDiv").html(v_html);
                   }
               }
           })
       }

   </script>
</html>
