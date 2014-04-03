<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  

  
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>sample</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" /> 
	<script src="https://apis.skplanetx.com/tmap/js?version=1&format=javascript&appKey=ce8112aa-758b-3525-9332-97e319a1e1ae"></script>
    
    <!-- 부트스트랩 -->
    <link href="<c:url value='/css/bootstrap/bootstrap.min.css'/>" rel="stylesheet" media="screen">
   
	<!-- AXJ -->   
    <link href="<c:url value='/css/axj/default/AXJ.css'/>" rel="stylesheet" media="screen">

       
    <style> 		
		div#loading{
		    display: none;
		    width:350px;
		    height:40px;
		    position: fixed;
		    top: 50%;
		    left: 50%;
		    background:url(/images/loading.gif) no-repeat center #fff;
		    text-align:center;
		    padding:10px;
		    font:normal 16px Tahoma, Geneva, sans-serif;
		    border:0px solid #666;
		    margin-left: -50px;
		    margin-top: -50px;
		    z-index:100000;
		    overflow: auto; 
		    opacity:0.9;  
		}
	</style>  

    <!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요한) -->
    <script src="<c:url value='/js/jquery/jquery.js'/>"></script>
    
        
    <!-- 모든 합쳐진 플러그인을 포함하거나 (아래) 필요한 각각의 파일들을 포함하세요 -->
    <script src="<c:url value='/js/bootstrap/bootstrap.min.js'/>"></script>
 
    <!-- Respond.js 으로 IE8 에서 반응형 기능을 활성화하세요 (https://github.com/scottjehl/Respond) -->
    <script src="<c:url value='/js/bootstrap/respond.js'/>"></script>
           
    <!-- common.js (공통 함수 제공-Ajax포함) -->
    <script src="<c:url value='js/cmm/common.js'/>"></script>
        
    <!-- map.js (Tmap 함수 제공) -->
    <script src="<c:url value='/js/cmm/map.js'/>"></script>
    
    <!-- AXJ 함수  -->
    <script src="<c:url value='/js/axj/AXJ.js'/>"></script>

    
    <!-- 초기 설정 -->
    <script type="text/javascript"> 
	$(window).load(function() {
		 //로딩바 div 추가
		 var $bar = $('<div></div>');
		 $bar.attr('id', "loading");
		 $bar.appendTo('body');
	});
	</script>   
    
    