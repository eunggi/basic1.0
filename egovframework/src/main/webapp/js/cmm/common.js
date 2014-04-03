	/**
	 * =====================================================
	 * 공통 유틸리티
	 * =====================================================
	 */

     /**-------------------------------------------------------------------------------------
	 * console log설정 
	   -------------------------------------------------------------------------------------*/
	function log(arg){
		if(typeof console != 'undefined'){
			console.log(arg);
		}
		
	}
	

	/**-------------------------------------------------------------------------------------
	 * ie9호환성 toLowerCase 오류 해결 시작
	   -------------------------------------------------------------------------------------*/
	function addJavascript(jsname,pos) {
		var th = document.getElementsByTagName(pos)[0];
		var s = document.createElement('script');
		s.setAttribute('type','text/javascript');
		s.setAttribute('src',jsname);
		th.appendChild(s);
	}
	
	function setSrcForIE(){	
		var ver = getInternetExplorerVersion();
		if (ver > -1) {
			if (ver < 10 && ver >= 8.0) {
				addJavascript('http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE8.js','head');
			}
		}
	}

	setSrcForIE();
	
	/**-------------------------------------------------------------------------------------
	 * ie버전 확인
	   -------------------------------------------------------------------------------------*/
	function getInternetExplorerVersion() {
		var rv = -1; // Return value assumes failure.   
		if (navigator.appName == 'Microsoft Internet Explorer') {
			var ua = navigator.userAgent;
			var re = new RegExp("MSIE ([0-9]{1,}[\.0-9]{0,})");
			if (re.exec(ua) != null) 
				rv = parseFloat(RegExp.$1);
		}
		return rv;
	}
	
	
	
	/**-------------------------------------------------------------------------------------
	 * 로딩이미지 표시
	   -------------------------------------------------------------------------------------*/
	var loading_cnt = 0;
	function loading_st(){
	   if(loading_cnt < 1){
		   loading_cnt++;
		   $("#loading").show();
		   setTimeout("loading_ed();",60000);
	   }
	}

	/**-------------------------------------------------------------------------------------
	 * 로딩이미지 숨김
	   -------------------------------------------------------------------------------------*/
	function loading_ed(){
		loading_cnt--;
		if(loading_cnt <= 0){
			$("#loading").hide();
			loading_cnt = 0;
		}
	}
	
	
	
	/**-------------------------------------------------------------------------------------
	 * Ajax설정
	 * ex)
	      $().custAjax({
			"url" : '/test/list.do',
			"data" : {
				          "_method" : "GET"    //RESTFUL 방식의 method 설정
				         , "data1" : "a"
			}
	     }, callbackFunc);	
	   -------------------------------------------------------------------------------------*/
	jQuery(function($){
		// ajax 호출 함수
		$.fn.custAjax = function(params, callMethod) {
			var targetID = $(this);
			var callbacks = $.Callbacks();
			var callFunction = callMethod;
			
			var param = $.extend({
				async:true,
				url : null,
				data : ""
			}, params||{});

			if(param.loading){
				loading_st();				
			}
		
			$.ajax({
				async : param.async,
				type : "POST",
				url : param.url,
				cache : false,
				dataType : "json",
				data : param.data,
				success : function(data, status) {
					callbacks.add(callFunction);
					callbacks.fire(targetID, data);
					loading_ed();
				},
				error : function(data, status, errorThrown) {
					loading_ed();
					if (data.responseText.indexOf('<div id="login_content">') != -1 ) goLogout(); 
				}
			});		
		};	
	});

	/**-------------------------------------------------------------------------------------
	 * Ajax session 종료시 logout 이동
	   -------------------------------------------------------------------------------------*/
	function goLogout( ){
		alert("session 시간이 만료 되었습니다. 다시 로그인 부탁 드립니다");
		location.replace("/bts/logout");
	}

	
	
	
	
	
	
	
	
