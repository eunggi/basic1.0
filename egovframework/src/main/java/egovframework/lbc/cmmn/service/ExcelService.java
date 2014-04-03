package egovframework.lbc.cmmn.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public interface ExcelService {

    /**
     * 엑셀 Template를 다운한다.
     * @param response
     * @return
     * @throws Exception
     */
    public HSSFWorkbook downExcelTemplate(HttpServletRequest request, HttpServletResponse response) throws Exception;
    
    /**
     * xlsx 엑셀 Template를 다운한다.
     * @param templateName
     * @return
     * @throws Exception
     */
    public XSSFWorkbook downXSSFExcelTemplate(HttpServletRequest request, HttpServletResponse response) throws Exception;
       
    /**
     * 엑셀 파일을 다운한다.
     * @param workbook
     * @throws Exception
     */
    public void downWorkbook(String filename, HSSFWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception;
    
    /**
     * xlsx 엑셀 파일을 다운한다.
     * @param workbook
     * @throws Exception
     */
    public void downXSSFWorkbook(String filename, XSSFWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception;
    
 

}
