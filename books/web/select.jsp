<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import = "com.rain.bean.AdminBean,com.rain.dao.AdminDao,com.rain.bean.BookBean,com.rain.dao.BookDao" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="zh-CN" class="ax-vertical-centered">
<head>
	<meta charset="UTF-8">
	<title>图书查询</title>
	    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
        <script src="static/js/bootstrap.min.js"></script>
            <script src="static/js/bootstrap-dropdown.min.js"></script>
              <script src="static/js/reader.js"></script>
    <script src="static/js/jquery.min.js"></script>
    <script src="static/js/bootstrap.min.js"></script>
</head>
<body class="bootstrap-admin-with-small-navbar">
<%
AdminBean admin = new AdminBean();
String aid = (String)session.getAttribute("aid");
AdminDao admindao = new AdminDao();
admin = admindao.get_AidInfo2(aid);

%>
<nav class="navbar navbar-inverse navbar-fixed-top bootstrap-admin-navbar bootstrap-admin-navbar-under-small" role="navigation">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="collapse navbar-collapse main-navbar-collapse">
                    <a class="navbar-brand"><strong>图书查询</strong></a>
                    <ul class="nav navbar-nav navbar-right">
                        <li class="dropdown">
                           <a href="#" role="button" class="dropdown-toggle" data-hover="dropdown"> <i class="glyphicon glyphicon-user"></i>
                                <span><% out.write(admin.getName());%></span>  <i class="caret"></i></a>

							<ul class="dropdown-menu">
                                <li><a href="/books/login.jsp">退出</a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</nav>

<div class="container">
    <div class="row">
        <div class="col-md-2 bootstrap-admin-col-left">
            <ul class="nav navbar-collapse collapse bootstrap-admin-navbar-side">
                <li>
                    <a href="/books/select.jsp"><i class="glyphicon glyphicon-chevron-right"></i> 图书查询</a>
                </li>
	            <li>
	                 <a href="/books/borrow.jsp"><i class="glyphicon glyphicon-chevron-right"></i> 借阅信息</a>
	                </li>
            </ul>
        </div>

        <!-- content -->
        <div class="col-md-10">
           
       <div class="row">
                    <div class="col-lg-12">
                        <div class="panel panel-default bootstrap-admin-no-table-panel">
                            <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
                                <form class="form-horizontal" action="/books/selectServlet" method="post">
                                <input type="hidden" name="tip" value="2">
                                    <div class="col-lg-8 form-group">
                                        <%--@declare id="query_bname"--%><label class="col-lg-4 control-label" for="query_bname">查询图书名称</label>
                                        <div class="col-lg-8">
                                            <input class="form-control" id="bookName" name="name" type="text" value="">
                                            <label class="control-label" for="query_bname" style="display: none;"></label>
                                        </div>
                                    </div>
                                    
                                  
                                    <div class="col-lg-4 form-group">

                                        <button type="submit" class="btn btn-primary" id="btn_query" >查询</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                
                
                <div class="row">
                    <div class="col-lg-12">
                        <table id="data_list" class="table table-hover table-bordered" cellspacing="0" width="100%">
                            <thead>
                            <tr>
                                <th>图书号</th>
                                <th>图书类型</th>
                                <th>图书名称</th>
                                <th>作者名称</th>
                                 <th>出版社</th>
                                <th>总数量</th>
                                <th>操作</th>
                                
                            </tr>
                            </thead>
                            
                            
                            <!---在此插入信息-->
                            <!---在此插入信息-->
                             <%
                             ArrayList<BookBean> bookdata = new ArrayList<BookBean>();
                             bookdata = (ArrayList<BookBean>)request.getAttribute("data");
                           if(bookdata==null){
                        	   BookDao bookdao = new BookDao();
                        	   bookdata = (ArrayList<BookBean>)bookdao.get_ListInfo();
                           }
	
  for (BookBean bean : bookdata){
  %>                 
								<tbody>
	                         	   	<td><%= bean.getCard() %></td>
	                                <td><%= bean.getType() %></td>
	                                <td><%= bean.getName() %></td>
	                                <td><%= bean.getAuthor() %></td>
	                                <td><%= bean.getPress() %></td>  
	                                <td><%= bean.getNum() %></td>
<td><button type="button" class="btn btn-info btn-xs" data-toggle="modal" onclick="borrowbook(<%= bean.getBid() %>,<%= bean.getNum() %>)" >借阅</button>   	</td>
                                          
                          	  </tbody>
                       <%} %> 
                            
                        </table>
                        
                        
                           
                    </div>
                </div>
         
         <script type="text/javascript">
    function borrowbook(bid,num) {
        if(num==0){
            alert("数量不足，不能借阅了!");
            return;
        }
    	con=confirm("是否借阅?"); 
    	if(con==true){
    		location.href = "/books/borrowServlet?tip=1&bid="+bid;
    	}
    }
    </script>
        </div>
    </div>
</div>

</body>
</html>