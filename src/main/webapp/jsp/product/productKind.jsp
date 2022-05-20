<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>  

<%@ include file="../header.jsp" %>  
<%@ include file="sub_img.jsp"%> 
<%@ include file="sub_menu.html" %>   
    
  <article>
    <h2>Item</h2>  
       
    <c:forEach items="${productKindList}"  var="productVO" varStatus="st">
    
      <div id="productItem${st.index}">
        <a href="${contextPath}/product/product_detail?pseq=${productVO.pseq}"> 
          <img src="${contextPath}/product_images/${productVO.image}" />
          <h5>${productVO.name} </h5>        
          <p><fmt:formatNumber maxFractionDigits="3" value="${productVO.price2}" /> 원</p>
        </a>  
      </div>
    </c:forEach>   
     
    <div class="clear"></div>
  </article>
  
<%@ include file="../footer.jsp" %>    