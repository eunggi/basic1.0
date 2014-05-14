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
    <script src="<c:url value='/js/cmm/heatmap.js'/>"></script>
    <script src="<c:url value='/js/cmm/heatmap-openlayers.js'/>"></script>
        
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
	var op_map2, op_layer2;
	var op_layer3;

	//두번째 TMap		
	var $mapDiv;
	var g_map2;	
	var g_initMapAttr2 = {
			width : document.documentElement.clientWidth,
			height : document.documentElement.clientHeight,
			initLon : 14135893.887852,
		    initLat : 4518348.1852606,
			zoomLv : 15
	};
	
	function initPage2(obj , initMapAttr){
				
		if(initMapAttr != undefined){
			g_initMapAttr2 = $.extend(g_initMapAttr2, initMapAttr);		
		}
		
		$mapDiv2 = obj;
		
		 g_map2 = new Tmap.Map({div:$mapDiv2.attr("id"), width:g_initMapAttr2.width+'px', height:g_initMapAttr2.height+'px'});		 
		 g_map2.setCenter(new Tmap.LonLat(g_initMapAttr2.initLon, g_initMapAttr2.initLat), g_initMapAttr2.zoomLv);		 
		 
		 window.onresize=resizeBrowser2;		 		 
	}
	
	function resizeBrowser2(){		
		var pWidth =  g_initMapAttr2.width;
		var pHeight = g_initMapAttr2.height;
			
					
		$mapDiv2.css('width', parseFloat(pWidth));  
		$mapDiv2.css('height', parseFloat(pHeight));  
		
		g_map2.updateSize();
	}	
	//두번째 TMap생성함수
	
	
	
	
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
	    op_layer = new OpenLayers.Layer.WMS( "OpenLayers WMS",
      //                                                          "http://192.168.9.36/gisserv/test", {layers: 'B_WG,GU_WG,DO_WGS,HEATMAP',srs: 'EPSG:3857', transparent: true},{isBaseLayer: false, opacity: 0.5});
	                                                   		   "http://192.168.9.36/mapcache/", {layers: 'test',srs: 'EPSG:3857',transparent: true},{isBaseLayer: false, opacity: 0.5});
	  
	    
	    g_map.addLayer(op_layer);
	    op_layer.setVisibility(true);	    
	    g_map.events.register("zoomend" , '', reloadLayer);
	    
	    
	    
	    
	    //두번째 지도 
	    initPage2($("#map_div2"),initMapAttr);		
	    
	  
	    
	  	heatmap();
	
	    
/* 	    op_layer2 = new OpenLayers.Layer.WMS( "OpenLayers WMS",
        //                                                          "http://192.168.9.36/gisserv/test", {layers: 'B_WG,GU_WG,DO_WGS',srs: 'EPSG:3857', transparent: true},{isBaseLayer: false, opacity: 0.2});
	                                                    		    "http://192.168.9.36/mapcache/", {layers: 'test',srs: 'EPSG:3857',transparent: true},{isBaseLayer: false, opacity: 0});

	  g_map2.addLayer(op_layer2);    
	    op_layer2.setVisibility(true);	    
	    g_map2.events.register("zoomend" , '', function (){
			op_layer2.redraw();
		});
	     */
	    	    
	  // http://192.168.9.4/tile/tilecache.cgi?LAYERS=TEST&FORMAT=PNG&TRANSPARENT=TRUE&SERVICE=WMS&VERSION=1.1.1&REQUEST=GetMap&STYLES=&SRS=EPSG:4326&BBOX=124.526368,33.015648,131.874773,38.629528&WIDTH=256&HEIGHT=600
	    		
	    
	    
		var bound = g_map2.getExtent() ;
		
		var L1 = tranceMtoW(bound.left,bound.bottom);
		var L2 = tranceMtoW(bound.right,bound.top);
				
		op_map = new OpenLayers.Map( 'map2' );
		
 		op_layer3 = new OpenLayers.Layer.WMS( "OpenLayers WMS",
		                                                    //   "http://192.168.9.36/gisserv/test", {layers: 'B_WG,GU_WG,DO_WGS',srs: 'EPSG:4326'} );
				                                                  "http://192.168.9.36/mapcache/", {layers: 'test',srs: 'EPSG:4326'} );
	 	op_map.addLayer(op_layer3);
	    op_map.addControl(new OpenLayers.Control.LayerSwitcher());
	    op_map.addControl(new OpenLayers.Control.MousePosition());
	    op_map.zoomToExtent(new OpenLayers.Bounds(L1.lon,L1.lat,L2.lon,L2.lat));	    
	    var L3 = tranceMtoW(g_initMapAttr.initLon, g_initMapAttr.initLat);    
	    op_map.setCenter(new Tmap.LonLat(L3.lon,L3.latt), 8);	  

	});
	
	
	function reloadLayer(){
		op_layer.redraw();
	}
    
	function heatmap(){
		
		var testData={
	            max: 1071913,

	            data: [
							{lat:37.592128,lon:126.97942,count:155575},
							{lat:37.557335,lon:126.997985,count:121144},
							{lat:37.528582,lon:126.981987,count:227400},
							{lat:37.54824,lon:127.043114,count:296135},
							{lat:37.543059,lon:127.088351,count:368021},
							{lat:37.579132,lon:127.057221,count:346770},
							{lat:37.595194,lon:127.095157,count:403105},
							{lat:37.602917,lon:127.019697,count:457570},
							{lat:37.64071,lon:127.013272,count:324413},
							{lat:37.66633,lon:127.034471,count:348625},
							{lat:37.649734,lon:127.077134,count:587248},
							{lat:37.616431,lon:126.929119,count:450583},
							{lat:37.574997,lon:126.941155,count:313814},
							{lat:37.556708,lon:126.910326,count:369432},
							{lat:37.52194,lon:126.857526,count:469434},
							{lat:37.55844,lon:126.824859,count:546938},
							{lat:37.491581,lon:126.858351,count:417339},
							{lat:37.457775,lon:126.902894,count:242510},
							{lat:37.519739,lon:126.912303,count:396243},
							{lat:37.496075,lon:126.953734,count:397317},
							{lat:37.46457,lon:126.947435,count:520849},
							{lat:37.47074,lon:127.033245,count:393270},
							{lat:37.493712,lon:127.065334,count:527641},
							{lat:37.502168,lon:127.118003,count:646970},
							{lat:37.547522,lon:127.149107,count:465958},
							{lat:35.101944,lon:129.039539,count:121144},
							{lat:35.084875,lon:129.021139,count:116600},
							{lat:35.12365,lon:129.049072,count:93976},
							{lat:35.066859,lon:129.070848,count:139723},
							{lat:35.162253,lon:129.045424,count:380395},
							{lat:35.20313,lon:129.081491,count:266147},
							{lat:35.112394,lon:129.102184,count:293900},
							{lat:35.226523,lon:129.026455,count:302141},
							{lat:35.178523,lon:129.165612,count:410084},
							{lat:34.997514,lon:128.961625,count:343324},
							{lat:35.255804,lon:129.093816,count:247333},
							{lat:35.105822,lon:128.876958,count:546938},
							{lat:35.179332,lon:129.085238,count:202943},
							{lat:35.150145,lon:129.122858,count:169814},
							{lat:35.15599,lon:128.989335,count:252243},
							{lat:35.285976,lon:129.21811,count:93783},
							{lat:35.86346,lon:128.595722,count:121144},
							{lat:35.931561,lon:128.687718,count:93976},
							{lat:35.872043,lon:128.551837,count:116600},
							{lat:35.832102,lon:128.587631,count:293900},
							{lat:35.925558,lon:128.579681,count:302141},
							{lat:35.830795,lon:128.663483,count:445365},
							{lat:35.824435,lon:128.53159,count:605752},
							{lat:37.429197,lon:126.454548,count:121144},
							{lat:37.483644,lon:126.630247,count:93976},
							{lat:37.449826,lon:126.666862,count:293900},
							{lat:37.369932,lon:126.620373,count:277429},
							{lat:37.427541,lon:126.728662,count:460750},
							{lat:37.493873,lon:126.72327,count:547395},
							{lat:37.554491,lon:126.736766,count:336809},
							{lat:37.555125,lon:126.64056,count:116600},
							{lat:37.704898,lon:126.324436,count:56633},
							{lat:35.114296,lon:126.951525,count:93976},
							{lat:35.13235,lon:126.853116,count:116600},
							{lat:35.091018,lon:126.858869,count:293900},
							{lat:35.190188,lon:126.927519,count:302141},
							{lat:35.161924,lon:126.755194,count:370586},
							{lat:36.32101,lon:127.477219,count:93976},
							{lat:36.277898,lon:127.413187,count:121144},
							{lat:36.27729,lon:127.347241,count:116600},
							{lat:36.374029,lon:127.33555,count:293505},
							{lat:36.409268,lon:127.442362,count:204969},
							{lat:35.568031,lon:129.310518,count:121144},
							{lat:35.50875,lon:129.337066,count:293900},
							{lat:35.518029,lon:129.440218,count:93976},
							{lat:35.607264,lon:129.394373,count:302141},
							{lat:35.533266,lon:129.199639,count:189038},
							{lat:36.557838,lon:127.260787,count:0},
							{lat:37.27751,lon:127.009862,count:1071913},
							{lat:37.311146,lon:127.005774,count:0},
							{lat:37.257881,lon:126.981736,count:0},
							{lat:37.274808,lon:127.018764,count:0},
							{lat:37.272128,lon:127.058952,count:0},
							{lat:37.404536,lon:127.118384,count:949964},
							{lat:37.432483,lon:127.106361,count:0},
							{lat:37.43062,lon:127.166028,count:0},
							{lat:37.37654,lon:127.108147,count:0},
							{lat:37.733414,lon:127.070553,count:417412},
							{lat:37.399909,lon:126.930022,count:602122},
							{lat:37.401305,lon:126.913484,count:0},
							{lat:37.39758,lon:126.957604,count:0},
							{lat:37.50146,lon:126.790754,count:853039},
							{lat:37.496992,lon:126.781031,count:0},
							{lat:37.472141,lon:126.798892,count:0},
							{lat:37.524808,lon:126.795516,count:0},
							{lat:37.442346,lon:126.866792,count:329010},
							{lat:37.004924,lon:126.97996,count:388508},
							{lat:37.913705,lon:127.079958,count:91828},
							{lat:37.31242,lon:126.872196,count:0},
							{lat:37.662215,lon:126.839065,count:905076},
							{lat:37.652942,lon:126.880426,count:0},
							{lat:37.677613,lon:126.799868,count:0},
							{lat:37.677295,lon:126.730063,count:0},
							{lat:37.431047,lon:127.004849,count:66704},
							{lat:37.596298,lon:127.133418,count:185550},
							{lat:37.659779,lon:127.24577,count:529898},
							{lat:37.160466,lon:127.053399,count:183890},
							{lat:37.376217,lon:126.771005,count:407090},
							{lat:37.340658,lon:126.923214,count:278083},
							{lat:37.359636,lon:126.991819,count:144501},
							{lat:37.520074,lon:127.208057,count:138829},
							{lat:37.21868,lon:127.223876,count:856765},
							{lat:37.200536,lon:127.255018,count:0},
							{lat:37.264601,lon:127.123445,count:0},
							{lat:37.33065,lon:127.073611,count:0},
							{lat:37.861609,lon:126.793959,count:328128},
							{lat:37.20694,lon:127.48313,count:195175},
							{lat:37.032077,lon:127.304961,count:179782},
							{lat:37.720017,lon:126.613728,count:224350},
							{lat:37.148723,lon:126.796777,count:488758},
							{lat:37.400294,lon:127.303262,count:228747},
							{lat:37.80594,lon:127.003268,count:187911},
							{lat:37.967218,lon:127.252502,count:140997},
							{lat:37.299674,lon:127.617847,count:0},
							{lat:38.098433,lon:126.988323,count:41770},
							{lat:37.815822,lon:127.452354,count:50879},
							{lat:37.515227,lon:127.581334,count:82802},
							{lat:37.887143,lon:127.742144,count:276232},
							{lat:37.305344,lon:127.931613,count:311449},
							{lat:37.719264,lon:128.854771,count:218471},
							{lat:37.516535,lon:129.079176,count:90574},
							{lat:37.169507,lon:128.982308,count:51558},
							{lat:38.178883,lon:128.544566,count:80791},
							{lat:37.277725,lon:129.146281,count:67454},
							{lat:37.742074,lon:128.07674,count:62888},
							{lat:37.506119,lon:128.079229,count:37798},
							{lat:37.201129,lon:128.502252,count:35050},
							{lat:37.554171,lon:128.485026,count:37522},
							{lat:37.375958,lon:128.741325,count:35980},
							{lat:38.273143,lon:127.449577,count:43271},
							{lat:38.135753,lon:127.687348,count:22119},
							{lat:38.208578,lon:127.996471,count:19363},
							{lat:38.073332,lon:128.261873,count:28765},
							{lat:38.378628,lon:128.415849,count:26753},
							{lat:38.00963,lon:128.632306,count:25475},
							{lat:36.638243,lon:127.467774,count:666924},
							{lat:36.649767,lon:127.507608,count:0},
							{lat:36.628841,lon:127.435277,count:0},
							{lat:37.012117,lon:127.897995,count:203212},
							{lat:37.057525,lon:128.14319,count:134698},
							{lat:36.48698,lon:127.731406,count:30509},
							{lat:36.317481,lon:127.658799,count:49730},
							{lat:36.156742,lon:127.816397,count:46231},
							{lat:36.783603,lon:127.606727,count:31531},
							{lat:36.868037,lon:127.442726,count:61915},
							{lat:36.76665,lon:127.83183,count:31392},
							{lat:36.973337,lon:127.616346,count:84088},
							{lat:36.991548,lon:128.390085,count:28165},
							{lat:36.801303,lon:127.204709,count:574623},
							{lat:36.7613,lon:127.223079,count:0},
							{lat:36.890014,lon:127.163972,count:0},
							{lat:36.47693,lon:127.077219,count:122153},
							{lat:36.301728,lon:126.373511,count:97770},
							{lat:36.805642,lon:126.980771,count:278676},
							{lat:36.824052,lon:126.443223,count:156843},
							{lat:36.187911,lon:127.159797,count:119222},
							{lat:36.28868,lon:127.236534,count:41528},
							{lat:36.908339,lon:126.65653,count:0},
							{lat:36.116075,lon:127.480407,count:52952},
							{lat:36.243424,lon:126.858946,count:67584},
							{lat:36.10214,lon:126.650413,count:53914},
							{lat:36.427643,lon:126.855127,count:29755},
							{lat:36.564942,lon:126.610361,count:82811},
							{lat:36.667713,lon:126.786319,count:77830},
							{lat:36.693737,lon:126.054564,count:53888},
							{lat:35.825406,lon:127.117609,count:649728},
							{lat:35.789287,lon:127.121382,count:0},
							{lat:35.856035,lon:127.114409,count:0},
							{lat:35.939556,lon:126.318706,count:260546},
							{lat:36.020223,lon:126.991617,count:296366},
							{lat:35.599631,lon:126.907961,count:110352},
							{lat:35.419514,lon:127.444049,count:78770},
							{lat:35.806173,lon:126.879633,count:83302},
							{lat:35.825888,lon:127.432189,count:20446},
							{lat:35.936421,lon:127.715059,count:21827},
							{lat:35.654512,lon:127.546445,count:19424},
							{lat:35.595247,lon:127.238779,count:23663},
							{lat:35.430593,lon:127.092011,count:25241},
							{lat:35.462782,lon:126.586624,count:53333},
							{lat:35.656101,lon:126.441029,count:50814},
							{lat:34.792687,lon:126.363716,count:249960},
							{lat:34.399731,lon:127.602127,count:269937},
							{lat:34.986217,lon:127.394692,count:258670},
							{lat:34.985734,lon:126.722833,count:78679},
							{lat:35.00889,lon:127.660127,count:137810},
							{lat:35.288332,lon:126.997354,count:41027},
							{lat:35.213572,lon:127.26565,count:27272},
							{lat:35.233766,lon:127.505228,count:22419},
							{lat:34.53102,lon:127.336516,count:63392},
							{lat:34.797811,lon:127.17895,count:40166},
							{lat:35.005162,lon:127.035627,count:62219},
							{lat:34.640587,lon:126.938425,count:35763},
							{lat:34.605207,lon:126.774656,count:34204},
							{lat:34.542041,lon:126.493902,count:66042},
							{lat:34.790408,lon:126.618013,count:58748},
							{lat:34.97762,lon:126.401725,count:68462},
							{lat:35.109686,lon:126.527486,count:30995},
							{lat:35.277718,lon:126.287409,count:48663},
							{lat:35.326541,lon:126.770664,count:38507},
							{lat:34.217049,lon:126.797152,count:46777},
							{lat:34.300262,lon:126.130665,count:28565},
							{lat:36.090389,lon:129.356228,count:511390},
							{lat:35.966234,lon:129.473022,count:0},
							{lat:36.167785,lon:129.28342,count:0},
							{lat:35.817116,lon:129.262225,count:256150},
							{lat:36.057529,lon:128.079977,count:127889},
							{lat:36.577384,lon:128.782293,count:166197},
							{lat:36.204413,lon:128.357675,count:402607},
							{lat:36.867689,lon:128.599896,count:108888},
							{lat:36.012777,lon:128.944884,count:95256},
							{lat:36.426535,lon:128.069226,count:98103},
							{lat:36.687889,lon:128.150975,count:69021},
							{lat:35.831179,lon:128.811123,count:266036},
							{lat:36.167189,lon:128.650367,count:19993},
							{lat:36.359083,lon:128.617172,count:51247},
							{lat:36.354158,lon:129.05971,count:24008},
							{lat:36.69358,lon:129.147362,count:16540},
							{lat:36.464388,lon:129.380906,count:36428},
							{lat:35.669924,lon:128.789231,count:38228},
							{lat:35.733904,lon:128.308257,count:31817},
							{lat:35.904127,lon:128.236035,count:36859},
							{lat:36.01259,lon:128.46486,count:114246},
							{lat:36.651039,lon:128.424701,count:43015},
							{lat:36.931283,lon:128.91526,count:31242},
							{lat:36.884542,lon:129.36305,count:47108},
							{lat:35.171477,lon:128.607857,count:1058021},
							{lat:35.305749,lon:128.651831,count:0},
							{lat:35.192204,lon:128.670524,count:0},
							{lat:35.112368,lon:128.514675,count:0},
							{lat:35.228983,lon:128.539154,count:0},
							{lat:35.108085,lon:128.720692,count:0},
							{lat:35.202081,lon:128.131925,count:337896},
							{lat:34.714592,lon:128.370757,count:129366},
							{lat:35.029132,lon:128.035156,count:107524},
							{lat:35.269091,lon:128.847463,count:494510},
							{lat:35.495349,lon:128.79185,count:99128},
							{lat:34.85394,lon:128.636145,count:231271},
							{lat:35.398851,lon:129.043282,count:252507},
							{lat:35.389426,lon:128.279325,count:25602},
							{lat:35.287936,lon:128.433076,count:60794},
							{lat:35.505449,lon:128.495298,count:55189},
							{lat:34.995207,lon:128.302051,count:26753},
							{lat:34.746423,lon:127.981462,count:43919},
							{lat:35.125875,lon:127.784215,count:41862},
							{lat:35.36562,lon:127.886519,count:31898},
							{lat:35.548708,lon:127.724213,count:38002},
							{lat:35.729624,lon:127.906289,count:57323},
							{lat:35.573564,lon:128.143692,count:43639},
							{lat:33.259351,lon:126.605696,count:130713},
							{lat:35.756736,lon:128.50062,count:169227},
							{lat:35.756736,lon:128.50062,count:169227},
							{lat:37.363445,lon:125.799643,count:14550},
							{lat:37.363445,lon:125.799643,count:14550},
							{lat:37.363445,lon:125.799643,count:14550},
							{lat:37.363445,lon:125.799643,count:14550},
							{lat:37.228287,lon:126.628044,count:728775},
							{lat:37.228287,lon:126.628044,count:728775},
							{lat:37.213164,lon:126.584159,count:0},
							{lat:37.213164,lon:126.584159,count:0},
							{lat:36.621704,lon:127.507345,count:143762},
							{lat:35.915852,lon:127.217529,count:83408},
							{lat:35.915852,lon:127.217529,count:83408},
							{lat:34.791465,lon:125.912352,count:33222},
							{lat:34.791465,lon:125.912352,count:33222},
							{lat:34.791465,lon:125.912352,count:33222},
							{lat:34.791465,lon:125.912352,count:33222},
							{lat:34.791465,lon:125.912352,count:33222},
							{lat:37.508122,lon:130.878053,count:7764},
							{lat:37.508122,lon:130.878053,count:7764},
							{lat:33.65215,lon:126.384967,count:401192},
							{lat:33.65215,lon:126.384967,count:401192}
	                   ]
	    };
		
		var transformedTestData = { max: testData.max , data: [] },
        data = testData.data,
        datalen = data.length,
        nudata = [];
 
	    while(datalen--){
	        nudata.push({
	            lonlat: new OpenLayers.LonLat(data[datalen].lon, data[datalen].lat),
	            count: data[datalen].count
	        });
	    }
	    transformedTestData.data = nudata;
        
	    // create our heatmap layer
	    var heatmap = new OpenLayers.Layer.Heatmap("Heatmap Layer", g_map2, g_map2.layers[0],
	    		{visible: true, radius: 10} ,
	    		{isBaseLayer: false, opacity: 1, projection: new OpenLayers.Projection("EPSG:4326")});
	    
	    g_map2.addLayer(heatmap);
	   
	    heatmap.setDataSet(transformedTestData);
		   
		  
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
                'javascript:columnClick("1");',
                'location.href="http://naver.com"',
                'javascript:columnClick("2");',
                'javascript:columnClick("3");'
            
            ]
        },
        'dataset': {
        	title: 'Playing time per day',
        	values: [
        		[5,7,2], [2,5,7], [7,2,3], [6,1,5], [5,3,8], [8,3,1], [6,3,9], [6,2,6], [8,2,4]
        	],
        	colorset: ['#DC143C', '#FF8C00', "#30a1ce"],
        	fields: ['Working Time', 'Late count', 'Mail count']
        },
        'chartDiv': 'Nwagon',
        'chartType': 'multi_column',
        'chartSize': { width: NwagonDivwidth, height: 300 },
        'maxValue': 15,
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
	           </br>
	           <div id="map_div2"></div>	           
	           </br>
	           <div id="map2"></div>	
	       </div>      
      </div>
      
      

    </div><!-- /.container -->

