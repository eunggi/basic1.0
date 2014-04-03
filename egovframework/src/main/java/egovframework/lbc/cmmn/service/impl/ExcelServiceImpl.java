package egovframework.lbc.cmmn.service.impl;

import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import egovframework.lbc.cmmn.service.ExcelService;

public class ExcelServiceImpl implements ExcelService{

    protected Log log = LogFactory.getLog(this.getClass());
    
    /**
     * 엑셀 Template를 다운한다.
     * @param response
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unused")
	public HSSFWorkbook downExcelTemplate(HttpServletRequest request, HttpServletResponse response) throws Exception{
    	  HSSFWorkbook wb = new HSSFWorkbook();
          String fileName = "템플릿.xls";
          
          try {
            log.debug("ExcelServiceImpl downExcelTemplate ...");
              
       		String userAgent = request.getHeader("User-Agent");

    	    if(userAgent.indexOf("MSIE") > -1){
    			fileName = URLEncoder.encode(fileName, "utf-8");
    		}else{
    			fileName = new String(fileName.getBytes("utf-8"), "iso-8859-1");
    		}
    		    
    	    
    		response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\";");
    		response.setHeader("Content-Transfer-Encoding", "binary");
    		
    		
    		
      	      HSSFSheet sheet1 = wb.createSheet("templete sheet");
      	     
      	      wb.createSheet();
              
              wb.write(response.getOutputStream());

          } catch (Exception e) {
              log.error("ExcelServiceImpl downExcelTemplate Error...");
          }

          return wb;
    	
    }
    
    /**
     * xlsx 엑셀 Template를 다운한다.
     * @param templateName
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unused")
	public XSSFWorkbook downXSSFExcelTemplate(HttpServletRequest request, HttpServletResponse response) throws Exception{
    	XSSFWorkbook wb = new XSSFWorkbook();
    	String fileName = "템플릿.xlsx";
    	
    	 try {
             log.debug("ExcelServiceImpl downXSSFExcelTemplate ...");
              
     		String userAgent = request.getHeader("User-Agent");

    	    if(userAgent.indexOf("MSIE") > -1){
    			fileName = URLEncoder.encode(fileName, "utf-8");
    		}else{
    			fileName = new String(fileName.getBytes("utf-8"), "iso-8859-1");
    		}
    		    
    	    
    		response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\";");
    		response.setHeader("Content-Transfer-Encoding", "binary");
    		
    		
             XSSFSheet sheet1 =  wb.createSheet("templete sheet"); 
             
             wb.write(response.getOutputStream());

         } catch (Exception e) {
             log.error("ExcelServiceImpl downXSSFExcelTemplate Error...");
         }
         return wb;
   	
    }
       
    /**
     * 엑셀 파일을 다운한다.
     * @param workbook
     * @throws Exception
     */
    public void downWorkbook(String fileName, HSSFWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception{
    	fileName += ".xls";
    	
    	try {
             log.debug("ExcelServiceImpl downWorkbook ...");
             
      		 String userAgent = request.getHeader("User-Agent");

   	    if(userAgent.indexOf("MSIE") > -1){
   	    	fileName = URLEncoder.encode(fileName, "utf-8");
   		}else{
   			fileName = new String(fileName.getBytes("utf-8"), "iso-8859-1");
   		}
   		    
   	    
   		response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\";");
   		response.setHeader("Content-Transfer-Encoding", "binary");
   		         
   		workbook.write(response.getOutputStream());

	    } catch (Exception e) {
	         log.error("ExcelServiceImpl downWorkbook Error...");
	    }
		   	
    }
    
    /**
     * xlsx 엑셀 파일을 다운한다.
     * @param workbook
     * @throws Exception
     */
    public void downXSSFWorkbook(String fileName, XSSFWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception{
    	fileName += ".xlsx";
    	
    	try {
             log.debug("ExcelServiceImpl downXSSFWorkbook ...");
             
      		 String userAgent = request.getHeader("User-Agent");

   	    if(userAgent.indexOf("MSIE") > -1){
   	    	fileName = URLEncoder.encode(fileName, "utf-8");
   		}else{
   			fileName = new String(fileName.getBytes("utf-8"), "iso-8859-1");
   		}
   		    
   	    
   		response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\";");
   		response.setHeader("Content-Transfer-Encoding", "binary");
   		         
   		workbook.write(response.getOutputStream());

	    } catch (Exception e) {
	         log.error("ExcelServiceImpl downXSSFWorkbook Error...");
	    }
    }

}
