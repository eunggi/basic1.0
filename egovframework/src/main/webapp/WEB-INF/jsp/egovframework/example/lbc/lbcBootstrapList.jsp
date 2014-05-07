<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="lbc"  uri="/WEB-INF/config/tld/mytags.tld" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <link href="<c:url value='/css/axj/36rollLight/AXGrid.css'/>" rel="stylesheet" media="screen">
    <link href="<c:url value='/css/axj/36rollLight/AXSelect.css'/>" rel="stylesheet" media="screen">


     <!-- http://dev.axisj.com/ -->
    <script src="<c:url value='/js/axj/AXGrid.js'/>"></script>
    <script src="<c:url value='/js/axj/AXSelect.js'/>"></script>
    
    <!-- http://html.nhncorp.com/nwagon -->
    <script src="<c:url value='/js/Nwagon/Nwagon.js'/>"></script>        
          
    <script src="http://openlayers.org/api/OpenLayers.js"></script>
       
    <style> 
    .starter-template {
	  padding: 70px 15px;
	  text-align: center;
	}
	
	
       #map2 {
           width: 400px;
           height: 300px;
           border: 1px solid black;
       }

	</style>

	<script type="text/javascript"> 
	
	var op_map, op_layer;
	var op_layer2;
	
	$(window).load(function() {
		//지도호출
	   var initMapAttr = {
			width : 400,
			height : 300,
			initLon : 14135893.887852,
		    initLat : 4518348.1852606,
			zoomLv : 8
			};
	
		
		initPage($("#map_div"),initMapAttr);
		
	    op_layer2 = new OpenLayers.Layer.WMS( "OpenLayers WMS",
         //                                                        "http://192.168.9.36/gisserv/test", {layers: 'B_WG,GU_WG,DO_WGS,HEATMAP',srs: 'EPSG:3857',transparent: true} );
	    
	    		  "http://192.168.9.36/mapcache/", {layers: 'test',srs: 'EPSG:3857',transparent: true} );
	    //		   "http://192.168.9.36/gisserv/test", {layers: 'B_WG,GU_WG,DO_WGS',srs: 'EPSG:3857',transparent: true} );
	    //	"http://192.168.9.4/tile/tilecache.cgi", {layers: 'TEST',srs: 'EPSG:3857',transparent: true} );
	    g_map.addLayer(op_layer2);
	    op_layer2.setVisibility(true);
	    op_layer2.setOpacity(0.8);
	    
	    g_map.events.register("zoomend" , '', reloadLayer2);
   
	    
	  // http://192.168.9.4/tile/tilecache.cgi?LAYERS=TEST&FORMAT=PNG&TRANSPARENT=TRUE&SERVICE=WMS&VERSION=1.1.1&REQUEST=GetMap&STYLES=&SRS=EPSG:4326&BBOX=124.526368,33.015648,131.874773,38.629528&WIDTH=256&HEIGHT=600
	    		
	    
	    	    
	    
	    
		var bound = g_map.getExtent() ;
		
		var L1 = tranceMtoW(bound.left,bound.bottom);
		var L2 = tranceMtoW(bound.right,bound.top);
				
		op_map = new OpenLayers.Map( 'map2' );
		op_layer = new OpenLayers.Layer.WMS( "OpenLayers WMS",
		  //                                                      "http://192.168.9.36/gisserv/test", {layers: 'B_WG,GU_WG,DO_WGS',srs: 'EPSG:4326'} );
				  "http://192.168.9.36/mapcache/", {layers: 'test',srs: 'EPSG:4326'} );

		
	 	op_map.addLayer(op_layer);
	    op_map.addControl(new OpenLayers.Control.LayerSwitcher());
	    op_map.addControl(new OpenLayers.Control.MousePosition());
	    op_map.zoomToExtent(new OpenLayers.Bounds(L1.lon,L1.lat,L2.lon,L2.lat));	    
	    var L3 = tranceMtoW(g_initMapAttr.initLon, g_initMapAttr.initLat);    
	    op_map.setCenter(new Tmap.LonLat(L3.lon,L3.latt), 8);	  
		   
	    
	});
	
	
	function reloadLayer2(){
		op_layer2.redraw();
	}
	
	function btnSearchOnClick(){
	      $().custAjax({
				"url" : '/sample/ages',
				"data" : {
					          "_method" : "GET"    //RESTFUL 방식의 method 설정
				},
				"loading":true
		     }, callbackFunc);	
	}
	
	
	function callbackFunc(obj, data){
		log(obj);
		log(data);
	}
	
	
	
	
	function btnExcelDown(){
		$('<form name="moveForm" action="/sample/listExcelCategory" method="GET"></form>') .appendTo('body').submit().remove();
	}
	
 	function sampleMarker(){
 		var mkAttr = {};
 		
		mkAttr.lon =128.5225976;
		mkAttr.lat =35.8138146;
			
		mkAttr.ico = "/images/egovframework/cmmn/ico04.png";
		mkAttr.labelFlag = false;
		mkAttr.labelContent = "["+ 1 +"]  "+ "테스트" + "<br/>" + "테스트 라벨";	
		setMap ("marker" , mkAttr);
 	}
	
			
	</script> 
  		
  		
  		
 	<script type="text/javascript">
	var myGrid = new AXGrid();
	
	var fnObj = {
		getColGroup: function(){
			return [
				{key:"no", label:"번호", width:"50", align:"right"},
				{key:"title", label:"제목", width:"200", tooltip:function(){
					return this.item.no + "." + this.item.title;
				}},
				{key:"writer", label:"작성자", width:"100", align:"center"},
				{key:"regDate", label:"작성일", width:"100", align:"center"},
				{key:"price", label:"가격", width:"100", align:"right", formatter:"money"},
				{key:"amount", label:"수량", width:"80", align:"right", formatter:"money"},
				{key:"cost", label:"금액", width:"100", align:"right", formatter:function(){
					return (this.item.price.number() * this.item.amount.number()).money();
				}},
				{key:"desc", label:"비고", width:"200"}
			];
		},
		
		init: function(){
			myGrid.setConfig({
				targetID : "AXGridTarget",
				//sort:false, 정렬을 원하지 않을 경우 (tip 
				fitToWidth:false, // 너비에 자동 맞춤
				colGroup : fnObj.getColGroup(),
				body : {
					onclick: function(){
					},
					ondblclick: function(){
					},
					addClass: function(){
						// red, green, blue, yellow
						if(this.index % 2 == 0){
							return "green";
						}else{
							return "red";
						}
					}
				},
				page: {
	                paging: false
	            }
			});
			
			var list = [
				{no:1, title:"AXGrid 첫번째 줄 입니다.", writer:"김기영", regDate:"2013-01-18", desc:"myGrid.setList 의 첫번째 사용법 list json 직접 지정 법", price:123000, amount:10}, // item
				{no:2, title:"AXGrid 두번째 줄 입니다.", writer:"정기영", regDate:"2013-01-18", desc:"myGrid.setList 의 첫번째 사용법 list json 직접 지정 법", price:12300, amount:7},
				{no:3, title:"AXGrid 세번째 줄 입니다.", writer:"한기영", regDate:"2013-01-18", desc:"myGrid.setList 의 첫번째 사용법 list json 직접 지정 법", price:12000, amount:5},
				{no:4, title:"AXGrid 세번째 줄 입니다.", writer:"박기영", regDate:"2013-01-18", desc:"myGrid.setList 의 첫번째 사용법 list json 직접 지정 법", price:13000, amount:4},
				{no:5, title:"AXGrid 세번째 줄 입니다.", writer:"곽기영", regDate:"2013-01-18", desc:"myGrid.setList 의 첫번째 사용법 list json 직접 지정 법", price:3000, amount:3},
				{no:6, title:"AXGrid 세번째 줄 입니다.", writer:"문기영", regDate:"2013-01-18", desc:"myGrid.setList 의 첫번째 사용법 list json 직접 지정 법", price:123000, amount:2},
				{no:7, title:"AXGrid 세번째 줄 입니다.", writer:"소기영", regDate:"2013-01-18", desc:"myGrid.setList 의 첫번째 사용법 list json 직접 지정 법", price:129500, amount:1},
				{no:8, title:"AXGrid 첫번째 줄 입니다.", writer:"재기영", regDate:"2013-01-18", desc:"myGrid.setList 의 첫번째 사용법 list json 직접 지정 법", price:123000, amount:10},
				{no:9, title:"AXGrid 두번째 줄 입니다.", writer:"원기영", regDate:"2013-01-18", desc:"myGrid.setList 의 첫번째 사용법 list json 직접 지정 법", price:12300, amount:7},
				{no:10, title:"AXGrid 세번째 줄 입니다.", writer:"고기영", regDate:"2013-01-18", desc:"myGrid.setList 의 첫번째 사용법 list json 직접 지정 법", price:12000, amount:5},
				{no:11, title:"AXGrid 세번째 줄 입니다.", writer:"장기영", regDate:"2013-01-18", desc:"myGrid.setList 의 첫번째 사용법 list json 직접 지정 법", price:13000, amount:4},
				{no:12, title:"AXGrid 세번째 줄 입니다.", writer:"장기영", regDate:"2013-01-18", desc:"myGrid.setList 의 첫번째 사용법 list json 직접 지정 법", price:3000, amount:3},
				{no:13, title:"AXGrid 세번째 줄 입니다.", writer:"장기영", regDate:"2013-01-18", desc:"myGrid.setList 의 첫번째 사용법 list json 직접 지정 법", price:123000, amount:2},
				{no:14, title:"AXGrid 세번째 줄 입니다.", writer:"장기영", regDate:"2013-01-18", desc:"myGrid.setList 의 첫번째 사용법 list json 직접 지정 법", price:129500, amount:1},
				{no:15, title:"AXGrid 두번째 줄 입니다.", writer:"장기영", regDate:"2013-01-18", desc:"myGrid.setList 의 첫번째 사용법 list json 직접 지정 법", price:12300, amount:7},
				{no:16, title:"AXGrid 세번째 줄 입니다.", writer:"장기영", regDate:"2013-01-18", desc:"myGrid.setList 의 첫번째 사용법 list json 직접 지정 법", price:12000, amount:5},
				{no:17, title:"AXGrid 세번째 줄 입니다.", writer:"장기영", regDate:"2013-01-18", desc:"myGrid.setList 의 첫번째 사용법 list json 직접 지정 법", price:13000, amount:4},
				{no:18, title:"AXGrid 세번째 줄 입니다.", writer:"장기영", regDate:"2013-01-18", desc:"myGrid.setList 의 첫번째 사용법 list json 직접 지정 법", price:3000, amount:3},
				{no:19, title:"AXGrid 세번째 줄 입니다.", writer:"장기영", regDate:"2013-01-18", desc:"myGrid.setList 의 첫번째 사용법 list json 직접 지정 법", price:123000, amount:2},
				{no:20, title:"AXGrid 세번째 줄 입니다.", writer:"장기영", regDate:"2013-01-18", desc:"myGrid.setList 의 첫번째 사용법 list json 직접 지정 법", price:129500, amount:1}
			];
			myGrid.setList(list);
			trace(myGrid.getSortParam());
		}
	};
	
	$(window).load(function(){
		fnObj.init();
	});
	  		
	</script>
  		
  		
  	<!-- 챠트 -->	
    <script>
    function columnClick(obj){
    	alert(obj);
    }
    
	$(window).load(function() {
	var NwagonDivwidth = $("#Nwagon").width();
    var options = {
        'legend': {
            names: ['EunJeong','HanSol','InSook','Eom','Pearl','SeungMin','TJ','Taegyu','YongYong'],
            hrefs: [
                'javascript:columnClick("sss");',
                'location.href="http://naver.com"'
            ]
        },
        'dataset': {
            title: 'Playing time per day',
            values: [5,7.8,2,4,6,3,5,2,10],
            colorset: ['#DC143C', '#FF8C00', "#30a1ce"]
        },
        'chartDiv': 'Nwagon',
        'chartType': 'column',
        'chartSize': { width: NwagonDivwidth, height: 300 },
        'maxValue': 10,
        'increment': 2
    };
    Nwagon.chart(options);
	});
</script>


  				
    <div class="navbar navbar-inverse navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#">Project name</a>
        </div>
        <div class="collapse navbar-collapse">
          <ul class="nav navbar-nav">
            <li class="active"><a href="#">Home</a></li>
            <li><a href="#about">About</a></li>
            <li><a href="#contact">Contact</a></li>
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </div>


    <div class="starter-template">      
        <div class="row">
	        <div class="col-lg-5">         	
	        
	         	 <lbc:selTag elemCodeId='SEX_CD' elemName='cbSexCd' elemStyle='width:100px;'  elemClass='select' elemDefaultName='전체' elemDefaultValue='' elemInitSelectCd='1' elemExcludeCd=''/>	
				 <lbc:selTag elemCodeId='SEX_CD' elemName='cbSexCd' elemStyle='width:100px;'  elemDefaultName='전체' elemDefaultValue='' elemExcludeCd='1'/>
				 <lbc:selTag elemCodeId='AGE_CD' elemName='cbAgeCd' elemStyle='width:100px;' /> 	
				 <lbc:selTag elemCodeId='AGE_CD' elemName='cbAgeCd' elemStyle='width:100px;' elemDefaultName='선택' elemDefaultValue='' elemExcludeCd='10,30'/>  

				 <div class="well row" style="margin:10px 0px 10px 0px;"  style="width:120px">				
					<button type="button" class="form-control btn btn-primary btn-sm" onclick="javascript:btnSearchOnClick();return false;">검색</button>		
					<button type="button" class="form-control btn btn-primary btn-sm" onclick="javascript:btnExcelDown();return false;">엑셀다운로드</button>		
					<button type="button" class="form-control btn btn-primary btn-sm" onclick="javascript:sampleMarker();return false;">마커</button>														
				</div>
				
		       <!-- 그리드 영역 시작 -->
				<div id="AXGridTarget"></div>
				<!-- 그리드 영역 끝 -->	
		
		      <!-- 챠트영역 시작 -->
		       <div id="Nwagon"></div>
		      <!-- 챠트영역 끝 -->
		
	        </div>
	        <div class="col-lg-7" id="map">
	           <div id="map_div"></div>
	           
	           <div id="map2"></div>	
	       </div>      
      </div>
      
      

    </div><!-- /.container -->

