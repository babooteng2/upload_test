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
				var str = "";
				if(checkImageType(data)){
					str = "<div>"
						+ "<a href='displayFile?fileName=" + getImageLink(data) + "'>"
						+ "<img src='displayFile?fileName=" + data + "'/>"
						+ getImageLink(data) + "</a></div>";
				}else{
					str = "<div><a href='displayFile?fileName=" + data + "'>"
						+ getOriginalName(data) 
						+ "</a></div>";
				}
				$(".uploadedList").append(str);
			}
		})
	});
});

function checkImageType(fileName) {
	var pattern = /jpg|gif|png|jpeg/i;
	return fileName.match(pattern);
}

function getOriginalName(fileName) {
	if(checkImageType(fileName)){
		return;
	}
	var idx = fileName.indexOf("_") + 1;
	return fileName.substr(idx);
}

function getImageLink(fileName) {
	if(!checkImageType(fileName)){
		return;
	}
	// /년/월/일 경로 추출
	var front = fileName.substr(0,12);
	// 파일 이름앞의 s_ 제거
	var end = fileName.substr(14);
	return front + end;
}
</script>
</head>
<body>
	<h3>Ajax File Upload</h3>
	<div class="fileDrop"></div>
	<div class="uploadedList"></div>	
</body>
</html>