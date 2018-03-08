<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style type="text/css">
#mydiv{
    position: absolute;
    left: 50%;
    top: 30%;
    margin-left: -200px;
    margin-top: -50px;
}
.mouseOver{
    background: #708090;
    color: #FFFAFA;
}
.mouseOut{
    background: #FFFAFA;
    color: #000000;
}
</style>
<script type="text/javascript">
   //定义一个全局变量
   var xmlHttp;
   //获得用户输入内容的关联信息的函数
   function getMoreContents() {
	   //首先获得用户的输入
	   var content = document.getElementById("keyword");
	   if(content.value==""){
		   clearContent();
		   return;   //为空什么都不用干
	   }
	   //给服务器发送用户输入的内容,采用ajax异步发送请求，使用ajax的XMlHttp对象
	   xmlHttp = createXMLHttp();
	   //给服务器发送数据
	   var url = "search?keyword="+escape(content.value);
	   //true表示JavaScript脚本会在send()方法之后继续执行，而不会等待来自服务器的相应。
	   xmlHttp.open("GET",url,true);
	   //xmlHttp绑定回调方法，这个回调方法会在xmlHttp的状态改变之后执行
	   //xmlHttp的状态是0-4，我们只关心4,4代表(complete)
	   xmlHttp.onreadystatechange = callback;
	   xmlHttp.send(null);
   }
   
   //获得xmlHttp对象
   function createXMLHttp() {
	   var xmlHttp;
	   //对于大多数的浏览器都适用的
	   if(window.XMLHttpRequest){
		   xmlHttp = new XMLHttpRequest();
	   }
	   //要考虑浏览器的兼容性
	   if(window.ActiveXObject){
		   xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
		   if(!xmlHttp){
			   xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
		   }
	   }
	   return xmlHttp;
   }
   //回调函数
   function callback() {
	   if(xmlHttp.readyState == 4 && xmlHttp.status ==200){ //200代表服务器相应成功
		    //交互成功，获得服务器相应的数据，是文本形式。
		    var result = xmlHttp.responseText;
	        //解析获得json格式的数据。
	        var json = eval("("+result+")");
	        //获得数据之后，就可以动态的显示这些数据了，把这些数据显示到输入框的下面
	        setContent(json);
	   }    
   }
   //设置关联数据的展示，参数代表的是服务器传递过来的关联数据。
   function setContent(contents) {
	   //设置数据前先清空
	   clearContent();
	   //首先获得关联数据的长度，确定<tr>长度
	   var size = contents.length;
	   //设置内容
	   for(var i=0;i<size;i++){
		   var nextNode = contents[i];  //代表json数据格式的第i个元素
		   var tr = document.createElement("tr");
		   var td = document.createElement("td");
		   td.setAttribute("border", "0");
		   td.setAttribute("bgcolor", "#FFFAFA");
		   td.onmouseover = function(){
			   this.className = 'mouseOver';
		   };
		   td.onmouseout = function(){
			   this.className = 'mouseOut';
		   };
		   td.onmousedown=function(){
			      document.getElementById("keyword").value = this.innerHTML;
			};
		   //层层套进去
		   var text = document.createTextNode(nextNode);
		   td.appendChild(text);
		   tr.appendChild(td);
		   document.getElementById("content_table_body").appendChild(tr);
	   }
   }

   //清空之前的数据
   function clearContent() {
	       var contentTableBody = document.getElementById("content_table_body");
	       var size = contentTableBody.childNodes.length;
	       //从下往上删除子节点
	       for(var i = size-1;i>=0;i--){
	    	   contentTableBody.removeChild(contentTableBody.childNodes[i]);
	       }
   }
   //当输入框失去焦点的时候
   function keywordBlur() {
	       clearContent();
   }
   //设置显示关联信息的位置
   function setLocation() {
	       //关联信息的显示位置要和输入框一致
	       
   }
</script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>智能搜索</title>
</head>
<body>
      <div id="mydiv">
           <!-- 输入框 -->
           <input type="text" size="50" id="keyword" onkeyup="getMoreContents()" onblur="keywordBlur()" onfocus="getMoreContents()"/>
           <input type="button" value="百度一下" width="50px" />
           <!-- 下面是内容展示的区域 -->
           <div id="popDiv" >
                <table id="content_table" bgcolor="#FFFAFA" border="0" cellspacing="0" cellpadding="0">
                       <tbody id="content_table_body">
                            <!-- 动态查询出来的数据显示在这个地方 -->
                       </tbody>
                </table>
           </div>
      </div>
      
      
      
      
      
</body>
</html>