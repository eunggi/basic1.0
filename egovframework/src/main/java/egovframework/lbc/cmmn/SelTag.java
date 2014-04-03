package egovframework.lbc.cmmn;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import egovframework.lbc.cmmn.service.SelTagService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

public class SelTag extends SimpleTagSupport
{
	  
    private String elemCodeId;
    private String elemName;
    private String elemStyle;
    private String elemClass;
    private String elemDefaultName;
    private String elemDefaultValue;
    private String elemInitSelectCd;
    private String elemExcludeCd;    

	protected Log log = LogFactory.getLog(this.getClass());
	
	public void setElemCodeId(String elemCodeId) {
		this.elemCodeId = elemCodeId;
	}


	public void setElemName(String elemName) {
		this.elemName = elemName;
	}

	public void setElemStyle(String elemStyle) {
		this.elemStyle = elemStyle;
	}


	public void setElemClass(String elemClass) {
		this.elemClass = elemClass;
	}


	public void setElemDefaultName(String elemDefaultName) {
		this.elemDefaultName = elemDefaultName;
	}


	public void setElemDefaultValue(String elemDefaultValue) {
		this.elemDefaultValue = elemDefaultValue;
	}


	public void setElemInitSelectCd(String elemInitSelectCd) {
		this.elemInitSelectCd = elemInitSelectCd;
	}

	
	public void setElemExcludeCd(String elemExcludeCd) {
		this.elemExcludeCd = elemExcludeCd;
	}

	    

	@SuppressWarnings({ "rawtypes", "unused", "unchecked" })
	public void doTag() throws JspException, IOException
    {	
		JspWriter pw=getJspContext().getOut();

        PageContext pageContext = (PageContext) getJspContext();
        ApplicationContext applicationContext = WebApplicationContextUtils
                .getRequiredWebApplicationContext(pageContext
                        .getServletContext());
        SelTagService selTagService = (SelTagService) applicationContext.getBean("selTagService");

		
		
		String strElemCodeId = "";
		String strElemName = "";
		String strElemStyle = "";
		String strElemClass = "";
		String strElemDefaultName = "";
		String strElemDefaultValue = "";
		String strElemInitSelectCd = "";
		String strElemExcludeCd = "";
		
		
		
		if (elemCodeId != null) strElemCodeId = elemCodeId;
		if (elemName != null) strElemName = elemName;
		if (elemStyle != null) strElemStyle = elemStyle;
		if (elemClass != null) strElemClass = elemClass;
		if (elemDefaultName != null) strElemDefaultName = elemDefaultName;
		if (elemDefaultValue != null) strElemDefaultValue = elemDefaultValue;
		if (elemInitSelectCd != null) strElemInitSelectCd = elemInitSelectCd;
		if (elemExcludeCd != null) strElemExcludeCd = elemExcludeCd;
				
		
        
        ArrayList<EgovMap> alData= new ArrayList<EgovMap>();
        String sqlId = "";
        
        if("SEX_CD".equals(elemCodeId)){
        	sqlId = "selTagDAO.getSexCd";
        }else if("AGE_CD".equals(elemCodeId)){
        	sqlId = "selTagDAO.getAgeCd";
        }
               
        
        
		try {	
			if(!sqlId.isEmpty()){
				alData = (ArrayList) selTagService.selectList(sqlId);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
			
		
		StringBuffer sb = new StringBuffer();
		String cd = "";
		String cdNm = "";
		String selected = "";
		String[] elemExcludeCd = {};
		boolean chk = false;
		
		if(strElemExcludeCd != null && !"".equals(strElemExcludeCd)){
			elemExcludeCd = strElemExcludeCd.split(",");
		}
		
		
		//select 속성설정
		sb.append("<select id=\""+strElemName+"\" ");
		sb.append("name=\""+strElemName+"\" ");
		sb.append("style=\""+strElemStyle+"\" ");
		sb.append("class=\""+strElemClass+"\" >");
		
		
		//option추가
		if(elemDefaultName != null && elemDefaultValue != null){
			sb.append("<option value='" + elemDefaultValue + "' selected>" + elemDefaultName + "</option>");
		}
		
				
		for(EgovMap eM:alData){
			cd = eM.get("cd").toString();
			cdNm = eM.get("cdNm").toString();
			selected = "";
			
			
			//초기 선택값 설정
			if(strElemInitSelectCd != null && !"".equals(strElemInitSelectCd)){
				if(cd.equals(strElemInitSelectCd)){
					selected = "selected";
				}				
			}
			
			
			//option제거 코드 설정
			if(elemExcludeCd != null && elemExcludeCd.length > 0){
				chk = false;
				for(String str:elemExcludeCd){
					if(cd.equals(str)){
						chk = true;
						break;
					}
				}
				
				if(chk){
					continue;
				}
			}
			
			sb.append("<option value='" + cd + "'" + selected + ">" + cdNm + "</option>");
		}
		
		
		
		//select종료
		sb.append("</select>");
		
		
		
		pw.println(sb.toString());
    }
}
