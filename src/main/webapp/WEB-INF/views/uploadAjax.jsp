<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
	.fileDrop {
		width: 100%;
		height: 200px;
		border: 1px dotted blue;
	}
	
	small {
		margin-left: 3px;
		font-weight: bold;
		color: gray;
	}
</style>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script>
$(document).ready(function(){
	$(".fileDrop").on("dragenter dragover",function(e){
		e.preventDefault();
		$(this).css("border-color","red");
	});
	$(".fileDrop").on("drop",function(e){
		e.preventDefault();
		var files = e.originalEvent.dataTransfer.files;
		// IE 10 이상만 가능
		var formData = new FormData();
		var file = files[0];
		formData.append("file", file);		
		
		$.ajax({
			url: '/uploadAjax',
			data: formData,
			type: 'POST',			
			processData: false,			
			contentType: false,
			success: function(data) {
				alert(data);
			}
		})
	});
});
</script>
</head>
<body>
	<h3>Ajax File Upload</h3>
	<div class="fileDrop"></div>
	<div class="uploadedList"></div>	
</body>
</html>