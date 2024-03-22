package com.rain.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import com.rain.bean.AdminBean;
import com.rain.dao.AdminDao;


@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public LoginServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		AdminDao userdao = new AdminDao();
		boolean result = userdao.Login_verify(username, password);
		HttpSession session = request.getSession();
		if(result){
			AdminBean adminbean = new AdminBean();
			AdminDao admindao = new AdminDao();
			adminbean = admindao.getAdminInfo(username,password);
			session.setAttribute("aid", ""+adminbean.getAid());
			session.setMaxInactiveInterval(6000);
			if(adminbean.getStatus()==1){
				response.sendRedirect("/books/index2.jsp");
			}else{
				response.sendRedirect("/books/admin.jsp");
			}
		}else{
			session.setAttribute("state", "密码错误");
			response.sendRedirect("/books/login.jsp");
		}
	}

}
