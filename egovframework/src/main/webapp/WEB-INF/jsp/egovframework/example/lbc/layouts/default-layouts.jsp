<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>


<html>
 <head>
  <tiles:insertAttribute name="header"/>
 </head>
 <body>
  <tiles:insertAttribute name="content"/>
  <tiles:insertAttribute name="footer"/>
 </body>
</html>