	/**
	 * =====================================================
	 * TMap API유틸
	 * =====================================================
	 */

    //전역변수 선언
	var g_map;	
	var g_markerLayer;
	var g_vectorLayer; 
	var g_pointFeature;
	var g_lineFeature;
	var g_attrSplit="[+split+]";
	var g_marker = [];
	
	var g_initMapAttr = {
			width : document.documentElement.clientWidth,
			height : document.documentElement.clientHeight,
			initLon : 14135893.887852,
		    initLat : 4518348.1852606,
			zoomLv : 15
	};
	
	var $mapDiv;
	
   /**-------------------------------------------------------------------------------------
	 * 맵 초기 설정 시작 
	   -------------------------------------------------------------------------------------*/
	function initPage(obj , initMapAttr){
				
		if(initMapAttr != undefined){
			g_initMapAttr = $.extend(g_initMapAttr, initMapAttr);		
		}
		
		$mapDiv = obj;
		
		 g_map = new Tmap.Map({div:$mapDiv.attr("id"), width:g_initMapAttr.width+'px', height:g_initMapAttr.height+'px'});		 
		 g_map.setCenter(new Tmap.LonLat(g_initMapAttr.initLon, g_initMapAttr.initLat), g_initMapAttr.zoomLv);		 
		 
		 window.onresize=resizeBrowser;		 		 
	}
	
	

	/**-------------------------------------------------------------------------------------
	 * 맵 영역 리사이징 시작
	   -------------------------------------------------------------------------------------*/
	function resizeBrowser(){
		var pWidth =  $mapDiv.parent().closest('div').width();
		var pHeight = document.documentElement.clientHeight;
			 
		$mapDiv.css('width', parseFloat(pWidth));  
		$mapDiv.css('height', parseFloat(pHeight));  
				
		g_map.updateSize();
	}
	
		
	/**-------------------------------------------------------------------------------------
	 * 마커레이어 설정
	   -------------------------------------------------------------------------------------*/
	function setMarker() {
		if (!g_markerLayer) {
			g_markerLayer = new Tmap.Layer.Markers("markerLayer");
			g_map.addLayer(g_markerLayer);
		}
	}
		
	/**-------------------------------------------------------------------------------------
	 * 백터레이어 설정
	   -------------------------------------------------------------------------------------*/
	function setLayer() {
		if (!g_vectorLayer) {
			g_vectorLayer = new Tmap.Layer.Vector("vectorLayer");
			g_map.addLayer(g_vectorLayer);
		}
	}
	
	
	/**-------------------------------------------------------------------------------------
	 * 마커레이어 초기화
	   -------------------------------------------------------------------------------------*/
	function initMarker() {
		if (g_marker.length != 0) {
		
			g_markerLayer.clearMarkers();
			g_map.removeLayer(g_markerLayer); // 맵 삭제
			g_markerLayer.destroy(); // 메모리 삭제
			g_marker = [];
			
		}
	}

	

	/**-------------------------------------------------------------------------------------
	 * 백터레이어 초기화
	   -------------------------------------------------------------------------------------*/
	function initVector() {
		if (g_vectorLayer) {
			g_vectorLayer.removeAllFeatures();
			g_map.removeLayer(g_vectorLayer);
			g_vectorLayer.destroy();
		}
	}



	/**-------------------------------------------------------------------------------------
	  * 포인트를 vectorLayer 추가
	   -------------------------------------------------------------------------------------*/
	function addPoints( attr ) {
		
		var lonLat; 

		var style = {
			      fillColor: attr.color
			     , fillOpacity:0.6
			     , strokeColor: attr.color
			     , strokeWidth: 0.4
			     , pointRadius: 5
			};
		
		
		if ( attr.lon.toString().indexOf(attrSplit) < 0 ) {
		
			lonLat = tranceWtoM(attr.lon, attr.lat );
			var point = new Tmap.Geometry.Point(lonLat.lon, lonLat.lat);
			
			g_pointFeature = new Tmap.Feature.Vector(point , null , style);
			g_vectorLayer.addFeatures(g_pointFeature);	
			
		} else {
			
			var arrLon = attr.lon.split(attrSplit);
			var arrLat  = attr.lat.split(attrSplit);
			
			for ( var i = 0; i < arrLon.length; i++) {
				
				lonLat = tranceWtoM(arrLon[i], arrLat[i]);
			
				var point = new Tmap.Geometry.Point(lonLat.lon, lonLat.lat);
				
				g_pointFeature = new Tmap.Feature.Vector(point , null , style);
				g_vectorLayer.addFeatures(g_pointFeature);	
				
			}	
		
		}
	}


	/**-------------------------------------------------------------------------------------
	  * 마커 추가
	   -------------------------------------------------------------------------------------*/
	function addMarker( lon , lat , objAttr ) {

		
		var size = new Tmap.Size(22, 22);
		var offset = new Tmap.Pixel(-(size.w / 2), -(size.h / 2));
		var icon = new Tmap.Icon(objAttr.ico, size, offset);	
		
		
		var lonLat;
		var theMarker;
		var labelStyle;
		var label;
		
		if ( objAttr.labelFlag) {
			labelStyle = '<font style=';
			labelStyle += '"';
			labelStyle +=	'color: 0x000000;';
			labelStyle += 'font-family:\'돋움체\';';
			labelStyle += 'font-size: 11px;';
			labelStyle += '">';
			labelStyle += objAttr.labelContent + '</font>';
			
			label = new Tmap.Label("<div>" + labelStyle + "</div>");
			lonLat = new tranceWtoM(lon , lat);	
			theMarker = new Tmap.Markers(lonLat, icon, label);
			g_markerLayer.addMarker(theMarker);
			
	    	theMarker.popup.setBackgroundColor("#FFF0F5");
			theMarker.events.register("mouseover", theMarker.popup, function(){this.show();});
			theMarker.events.register("mouseout", theMarker.popup, function(){this.hide();});

			
			
		} else {
			lonLat = new tranceWtoM(lon , lat );
			theMarker = new Tmap.Markers(lonLat, icon);
			g_markerLayer.addMarker(theMarker);
		}
		
		
		
		g_marker.push(theMarker);

		g_map.setCenter(lonLat, g_map.getZoom());		
	

	}




	/**-------------------------------------------------------------------------------------
	  * 라인백터 추가
	   -------------------------------------------------------------------------------------*/
	function addLine(lon, lat, color) {
		
		var pointList = [];
		var lonLat;
		
		var arrLon = lon.split(attrSplit);
		var arrLat  = lat.split(attrSplit);
		
		for ( var i = 0; i <arrLon.length; i++) {
			lonLat = tranceWtoM(arrLon[i], arrLat[i]);
			pointList.push(new Tmap.Geometry.Point(lonLat.lon, lonLat.lat));
		}

		var lineString = new Tmap.Geometry.LineString(pointList);
		var style = {
			strokeColor : color,
			strokeWidth : 4
		};

		g_lineFeature = new Tmap.Feature.Vector(lineString, null, style);
		g_vectorLayer.addFeatures(g_lineFeature);
	}



	/**-------------------------------------------------------------------------------------
	  * Map영역 최적화 
	  -------------------------------------------------------------------------------------*/
	function getDataExtent() {

			var bounds = new Tmap.Bounds();
			
			// i=0 은 map자체의 layer
			for ( var i = 1 ; Tmap.layers.length ; i++){
				 bounds.extend ( Tmap.layers[i].getDataExtent() );				
			}
	
			g_map.zoomToExtent( bounds );
			
	}
	
	/**-------------------------------------------------------------------------------------
	  * Map 설정
	   -------------------------------------------------------------------------------------*/
	function setMap(type,  objAttr ) {
		
		setLayer();
		setMarker();
		
		var a = {};
		
		if (type == 'marker') {
			
			a = objAttr;
			addMarker( a.lon , a.lat , a);
			
		} else if (type == "vector") {

			a= objAttr;
			if (a.feature  == "line") {
				addLine(a.lon, a.lat, a.color );
			} else if (a.feature  == "point") {
				addPoint( a  );
			}

		}
	}
	

	/**-------------------------------------------------------------------------------------
	  * 좌표변환
	   -------------------------------------------------------------------------------------*/
	function tranceWtoM(lon, lat) {
		return new Tmap.LonLat(lon, lat).transform(new Tmap.Projection("EPSG:4326"), new Tmap.Projection("EPSG:3857"));
	}

	function tranceMtoW(lon, lat) {
		return new Tmap.LonLat(lon, lat).transform(new Tmap.Projection("EPSG:3857"), new Tmap.Projection("EPSG:4326"));
	}
