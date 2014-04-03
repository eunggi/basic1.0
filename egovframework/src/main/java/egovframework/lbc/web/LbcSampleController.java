/*
 * Copyright 2008-2009 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package egovframework.lbc.web;

import java.awt.Color;
import java.io.IOException;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFColor;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import egovframework.lbc.cmmn.TilesDefConstant;
import egovframework.lbc.cmmn.service.SelTagService;

/**  
 * @Class Name : EgovSampleController.java
 * @Description : EgovSample Controller Class
 * @Modification Information  
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2009.03.16           최초생성
 * 
 * @author 개발프레임웍크 실행환경 개발팀
 * @since 2009. 03.16
 * @version 1.0
 * @see
 * 
 *  Copyright (C) by MOPAS All right reserved.
 */

@Controller
//@SessionAttributes(types=SampleVO.class)
public class LbcSampleController {
	
	/** EgovSampleService */
    @Resource(name = "selTagService")
    private SelTagService selTagService;
    
	@Value("#{prop.sample}")
    private String value1;
	     
  
	protected Log log = LogFactory.getLog(this.getClass());
	
	
    /**
	 * 글 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 SampleDefaultVO
	 * @param model
	 * @return "/sample/egovSampleList"
	 * @exception Exception
	 */
    @RequestMapping(value="/sample/lbc/{ctgryId}", method = RequestMethod.GET)
    public String samplePage(@PathVariable String ctgryId, ModelMap model)
            throws Exception {
    
          
        return TilesDefConstant.lbcMain+"/lbc/lbcBootstrapList";
    } 
    
    
	@RequestMapping(value="/sample/ages", method = RequestMethod.GET)
	public String getAges(Model model, HttpServletRequest request, HttpServletResponse response) throws IOException {
		request.setCharacterEncoding("UTF-8");							
		model.addAttribute("successFlag", false);		
		return "jsonMjView";
		
	}
    
	
	@RequestMapping(value="/sample/listExcelCategory", method = RequestMethod.GET)
	public void selectCategoryList(HttpServletRequest request, HttpServletResponse response) throws Exception {
	 
		egovframework.lbc.cmmn.service.impl.ExcelServiceImpl excelService = new egovframework.lbc.cmmn.service.impl.ExcelServiceImpl();
		
	    excelService.downXSSFWorkbook("샘플", this.createSampleXSSFWorkbook(), request, response);		
	}
	
	
	public XSSFWorkbook createSampleXSSFWorkbook() throws Exception {
			XSSFWorkbook wb = new XSSFWorkbook();
		    
		    XSSFSheet sheet1 = wb.createSheet("new sheet");
		     
		    // 셀의 크기
		     
		    XSSFFont f2 = wb.createFont();
		    XSSFCellStyle cs = wb.createCellStyle();
		    cs = wb.createCellStyle();
		     
		    cs.setFont( f2 );
		    cs.setWrapText( true );
		     
		    // 정렬
		    cs.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
		    cs.setFillPattern(XSSFCellStyle.DIAMONDS); // 무늬 스타일
		     
		    // 셀의 색상
		    
		    cs.setFillForegroundColor(new XSSFColor(Color.BLUE)); // 무늬 색
		    cs.setFillBackgroundColor(new XSSFColor(Color.RED));  // 배경색
		     
		  
		    for (int i = 0; i < 100; i++) {
		    	XSSFRow row = sheet1.createRow(i);
		    	row.setHeight((short)300); // row의 height 설정
		     
		    	for (int j = 0; j < 5; j++) {
		    		XSSFCell cell = row.createCell(j);
		    		cell.setCellValue("row " + i + ", cell " + j);
		    		cell.setCellStyle( cs );
		    		
		    	}
		    }
		   
		    for(int i = 0; i < sheet1.getRow(sheet1.getFirstRowNum()).getLastCellNum(); i++){
		    	sheet1.autoSizeColumn(i,true);    	
		    }
		    
		    return wb;
	}

	
	

	public HSSFWorkbook createSampleWorkbook() throws Exception {
			HSSFWorkbook wb = new HSSFWorkbook();
		    
		    HSSFSheet sheet1 = wb.createSheet("new sheet");
		     
		    // 셀의 크기
		     
		    HSSFFont f2 = wb.createFont();
		    HSSFCellStyle cs = wb.createCellStyle();
		    cs = wb.createCellStyle();
		     
		    cs.setFont( f2 );
		    cs.setWrapText( true );
		     
		    // 정렬
		    cs.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
		    cs.setFillPattern(HSSFCellStyle.DIAMONDS); // 무늬 스타일
		     
		    // 셀의 색상
		    cs.setFillForegroundColor(new HSSFColor.BLUE().getIndex()); // 무늬 색
		    cs.setFillBackgroundColor(new HSSFColor.RED().getIndex());  // 배경색
		     
		  
		    for (int i = 0; i < 100; i++) {
		    	HSSFRow row = sheet1.createRow(i);
		    	row.setHeight((short)300); // row의 height 설정
		     
		    	for (int j = 0; j < 5; j++) {
		    		HSSFCell cell = row.createCell(j);
		    		cell.setCellValue("row " + i + ", cell " + j);
		    		cell.setCellStyle( cs );
		    		
		    	}
		    }

		    for(int i = 0; i < sheet1.getRow(sheet1.getFirstRowNum()).getLastCellNum(); i++){
		    	sheet1.autoSizeColumn(i,true);    	
		    }
		    
		    return wb;
	}
}
