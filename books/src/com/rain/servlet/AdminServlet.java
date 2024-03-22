package com.rain.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.rain.bean.AdminBean;
import com.rain.dao.AdminDao;
import com.rain.dao.BookDao;


@WebServlet("/AdminServlet")
public class AdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public AdminServlet() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		BookDao bookdao = new BookDao();
		int tip = Integer.parseInt(request.getParameter("tip"));
		String url = request.getParameter("url");
		HttpSession session = request.getSession();
		AdminBean adminbean = new AdminBean();
		String aid = (String) session.getAttribute("aid");
		AdminDao admindao = new AdminDao();
		adminbean = admindao.get_AidInfo2(aid);
		if(tip==1){
			String password = request.getParameter("password");
			String password2 = request.getParameter("password2");
			String old_password = adminbean.getPassword();
			if(old_password.equals(password)){
				admindao.updateUser(adminbean.getAid(), adminbean.getUsername(), password2, adminbean.getName(),
						adminbean.getEmail(), adminbean.getPhone(), adminbean.getLend_num(), adminbean.getMax_num());
				response.sendRedirect("/books/"+url+".jsp");
			}else{
				out.write("<script type='text/javascript'>alert('password error');location.href='"+url+".jsp';  </script>");
				
			}
		}else{
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			String phone = request.getParameter("phone");
			admindao.updateUser(adminbean.getAid(), adminbean.getUsername(), adminbean.getPassword(), name,
					email, phone, adminbean.getLend_num(), adminbean.getMax_num());
			response.sendRedirect("/books/"+url+".jsp");
		}
	}

}
