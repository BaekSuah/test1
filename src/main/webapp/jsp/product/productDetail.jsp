<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>  

<%@ include file="../header.jsp" %>  
<%@ include file="sub_img.jsp"%> 
<%@ include file="sub_menu.html" %> 
      
  <article>
    <h1> Item </h1>
    
    <div id="itemdetail" >
      <form  method="post" name="formm">    
        <fieldset>
          <legend> Item detail Info</legend> 
         
          <a href="${contextPath}/product/product_detail?pseq=${productVO.pseq}">         
            <span style="float: left;">
              <img  src="${contextPath}/product_images/${productVO.image}"  />
            </span> 
            </a>    

			<br><br>
	        <div class="row mb-2 mt-3">
        		<h4> ${productVO.name} </h4>  
        	</div>
        	
        	<div class="row mb-2 ">
        	  <div class="col-3">
				<label>가 격 :</label>
			  </div>

			  <div class="col-7 mt-1"> 
				<p><fmt:formatNumber maxFractionDigits="3" value="${productVO.price2}" /> 원</p>
			  </div>
			</div>
			
			<div class="row mb-2">
			  <div class="col-3">
				<label >수 량 :</label>
			  </div>

			  <div class="col-4">
				<input  type="number" class="form-control" name="quantity" size="2" value="1" min="1"><br>
			  </div>
			
				<input  type="hidden" name="pseq"     value="${productVO.pseq}">
			</div>
        </fieldset>
   
        <div id="product_content" class="row p-2 m-2">
       		${productVO.content}
        </div>
        
        <div class="clear"></div>
        
        <div id="buttons">
          <input type="button" value="장바구니에 담기"   class="submit"    onclick="go_cart()"> 
          <input type="button" value="즉시 구매"       class="submit"    onclick="go_order()"> 
          <input type="reset"  value="취소"          class="cancel">
        </div>
      </form>  
    </div>
  </article>
<%@ include file="../footer.jsp" %>    