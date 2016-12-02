package com.bolim.util;

import java.io.File;
import java.text.DecimalFormat;
import java.util.Calendar;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/*
 * 1. 자동적인 폴더의 생성
 * 2. 파일저장은 UUID를 이용
 * 3. 썸네일 이미지를 생성
*/
public class UploadFileUtils {
	private static final Logger logger = LoggerFactory.getLogger(UploadFileUtils.class);
	
	public static String uploadFile(String uploadPath, String originalName, byte[] fileData) throws Exception {
		
		return null;
	}
	
	private static String calcPath(String uploadPath) {
		Calendar cal = Calendar.getInstance();
		String yearPath = File.separator + cal.get(Calendar.YEAR);
		String monthPath = yearPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.MONTH)+1);
		String datePath = monthPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.DATE));
		makeDir(uploadPath, yearPath, monthPath, datePath);
		logger.info(datePath);
		return datePath;
	}
	
	private static void makeDir(String uploadPath, String... paths) {
		if(new File(paths[paths.length-1]).exists()){
			return;
		}
		
		for(String path: paths) {
			File dirPath = new File(uploadPath + path);
			if(!dirPath.exists()){
				dirPath.mkdir();
			}
		}
	}
}
