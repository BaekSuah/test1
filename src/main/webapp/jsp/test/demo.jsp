<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- contextPath -->
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>demo</title>

<script src="/webjars/jquery/3.6.0/jquery.min.js"></script>
<script src="<%=request.getContextPath() %>/webjars/jquery/3.6.0/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/webjars/jquery/3.6.0/jquery.min.js"></script>
<script src="<c:url value="/webjars/jquery/3.6.0/jquery.min.js" />"></script>
<script src="${contextPath}/webjars/jquery/3.6.0/jquery.min.js"></script>

<script>
$(function() {
	$("body").css("background", "blue");
});
</script>
</head>
<body>
demo
</body>
</html>