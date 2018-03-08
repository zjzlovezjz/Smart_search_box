package com.imooc;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

public class SearchServlet extends HttpServlet {
	
	static List<String> datas = new ArrayList<String>();
	//��Щ��ģ������
	static{
		datas.add("ajax");
		datas.add("alibaba");
		datas.add("ade");
		datas.add("abc");
		datas.add("abcd");
		datas.add("abcdefg");
		datas.add("becky");
		datas.add("bilibili");
		datas.add("bbb");
		datas.add("bbbk");
		datas.add("ajax1");
		datas.add("ajax2");
		datas.add("ajax3");
	}
	

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    request.setCharacterEncoding("utf-8");
	    response.setCharacterEncoding("utf-8");
		//���Ȼ�ÿͻ��˷��͹���������keyword
		String keyword = request.getParameter("keyword");
		//��ùؼ���֮����д�����ù������ݡ�
		List<String> listData = getData(keyword);
		//����json��ʽ
		response.getWriter().write(JSONArray.fromObject(listData).toString());
	}
	
	//��ù������ݵķ���
	public List<String> getData(String keyword){
		List<String> list = new ArrayList<String>();
		for(String data:datas){
			if(data.contains(keyword)){
				list.add(data);
			}
		}	
		return list;
	}

	
	
	
	
	
	
	
	
}
