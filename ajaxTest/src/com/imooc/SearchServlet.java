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
	//这些事模拟数据
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
		//首先获得客户端发送过来的数据keyword
		String keyword = request.getParameter("keyword");
		//获得关键字之后进行处理，获得关联数据。
		List<String> listData = getData(keyword);
		//返回json格式
		response.getWriter().write(JSONArray.fromObject(listData).toString());
	}
	
	//获得关联数据的方法
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
