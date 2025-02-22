<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import = "com.rain.bean.TypeBean,com.rain.dao.AdminDao,com.rain.dao.TypeDao,com.rain.bean.BookBean,com.rain.dao.BookDao,com.rain.bean.AdminBean" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="zh-CN" class="ax-vertical-centered">
<head>
	<meta charset="UTF-8">
	<title>图书管理</title>
	    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
        <script src="static/js/bootstrap.min.js"></script>
        <script src="static/js/bootstrap-dropdown.min.js"></script>

</head>



<script src="static/js/jquery.min.js"></script>
<script src="static/js/bootstrap.min.js"></script>


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
                        <a class="navbar-brand"><strong>图书管理</strong></a>
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
                        <a href="/books/admin_book.jsp"><i class="glyphicon glyphicon-chevron-right"></i> 图书管理</a>
                    </li>
                    <li>
                        <a href="/books/admin_booktype.jsp"><i class="glyphicon glyphicon-chevron-right"></i> 图书分类管理</a>
                    </li>
                    <li>
                        <a href="/books/admin_borrow.jsp"><i class="glyphicon glyphicon-chevron-right"></i> 图书借阅信息</a>
                    </li>
                    <li>
                        <a href="/books/admin_history.jsp"><i class="glyphicon glyphicon-chevron-right"></i> 图书归还信息</a>
                    </li>
                </ul>
                
            </div>

            <!-- content -->
            <div class="col-md-10">
                
                
              <div class="row">
                    <div class="col-lg-12">
                        <div class="panel panel-default bootstrap-admin-no-table-panel">
                            <div class="panel-heading">
                                <div class="text-muted bootstrap-admin-box-title">查询</div>
                            </div>
                            <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
                                <form class="form-horizontal" action="/books/selectServlet" method="post">
                                <input type="hidden" name="tip" value="1">
                        			<div class="col-lg-7 form-group">
                                        <%--@declare id="query_bname"--%><label class="col-lg-4 control-label" for="query_bname">图书名称</label>
                                        <div class="col-lg-8">
                                            <input class="form-control" id="bookName" name="name" type="text" value="">
                                            <label class="control-label" for="query_bname" style="display: none;"></label>
                                        </div>
                                    </div>
                                    <div class="col-lg-3 form-group">

                                        <button type="submit" class="btn btn-primary" id="btn_query" onclick="">查询</button>
                                    </div>
                                    <div class="col-lg-3 form-group">

                                        <button type="button" class="btn btn-primary" id="btn_add" data-toggle="modal" data-target="#addModal">添加图书</button>
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
<td><button type="button" class="btn btn-warning btn-xs" data-toggle="modal" data-target="#updateModal" 
id="btn_update" onclick="showInfo2('<%= bean.getBid() %>','<%= bean.getCard() %>','<%= bean.getType() %>','<%= bean.getName() %>'
,'<%= bean.getAuthor() %>','<%= bean.getPress() %>','<%= bean.getNum() %>')">修改</button>
<button type="button" class="btn btn-danger btn-xs" onclick="deletebook(<%= bean.getBid() %>)">删除</button>
	</td>                                            
                          	  </tbody>
                       <%} %> 
                        </table>
                    </div>
                </div>
        </div>
    </div>
    <script type="text/javascript">
    function showInfo2(bid,card,type,name,author,press,num) {
        document.getElementById("updateISBN").value = card;
        document.getElementById("updateBookName").value = name;
        document.getElementById("updateAuthor").value = author;
        document.getElementById("updatePress").value = press;
        document.getElementById("updateBookType").value = type;
        document.getElementById("updateNum").value = num;
        document.getElementById("updateBookId").value = bid;
    }
    function deletebook(bid) {
    	con=confirm("是否删除?"); 
    	if(con==true){
    		location.href = "/books/deleteServlet?bid="+bid;
    	}
    }
    </script>
                               <form class="form-horizontal" method="post" action="/books/updateBookServlet">   <!--保证样式水平不混乱-->   
									<div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="updateModalLabel" aria-hidden="true">
										<div class="modal-dialog">
											<div class="modal-content">
												<div class="modal-header">
													<h4 class="modal-title" id="updateModalLabel">
														修改图书信息
													</h4>
												</div>
												<div class="modal-body">

										<div class="form-group">
											<%--@declare id="firstname"--%><label for="firstname" class="col-sm-3 control-label">图书号</label>
												<div class="col-sm-7">
												<input type="hidden" id="updateBookId" name="updatebid">
													<input type="text" class="form-control" id="updateISBN" name="card"  placeholder="请输入书号">
												<label class="control-label" for="updateISBN" style="display: none;"></label>
												</div>
										</div>
										
											
										 <div class="form-group">
											<label for="firstname" class="col-sm-3 control-label">图书名称</label>
												<div class="col-sm-7">
													<input type="text" class="form-control" id="updateBookName" name="name"  placeholder="请输入图书名称">
												<label class="control-label" for="updateBookName" style="display: none;"></label>
												</div>
										</div>
											
										<div class="form-group">	
											<label for="firstname" class="col-sm-3 control-label">图书类型</label>
											<div class="col-sm-7">
												 <select class="form-control" id="updateBookType" name="type" onPropertyChange="showValue(this.value)">
                                           				 <option value="-1">请选择</option> 
                                           				   <%
TypeDao typedao = new TypeDao();
ArrayList<TypeBean> data = (ArrayList<TypeBean>)typedao.get_ListInfo();
  data = (ArrayList<TypeBean>)typedao.get_ListInfo();
  for (TypeBean bean : data){
  %>                 <option value="<%= bean.getName() %>"><%= bean.getName() %></option>                        <%} %>                                        
                                      			  </select>
											<label class="control-label" for="updateBookType" style="display: none;"></label>
											</div>
										</div>
											
										<div class="form-group">	
											<label for="firstname" class="col-sm-3 control-label">作者名称</label>
												<div class="col-sm-7">
													<input type="text" class="form-control" id="updateAuthor" name="author" placeholder="请输入作者名称">
												<label class="control-label" for="updateAuthor" style="display: none;"></label>
												</div>
										</div>
										
										
										<div class="form-group">	
											<label for="firstname" class="col-sm-3 control-label">出版社</label>
												<div class="col-sm-7">
													<input type="text" class="form-control" id="updatePress" name="press"  placeholder="请输入出版社">
												<label class="control-label" for="updatePress" style="display: none;"></label>
												</div>
										</div>		
										<div class="form-group">	
											<label for="firstname" class="col-sm-3 control-label">总数量</label>
												<div class="col-sm-7">
													<input type="text" class="form-control" id="updateNum" name="num"  placeholder="请输入总数量">
												<label class="control-label" for="updatePress" style="display: none;"></label>
												</div>
										</div>	
										</div>
												<div class="modal-footer">
													<button type="button" class="btn btn-default" data-dismiss="modal">关闭
													</button>
													<button type="submit" class="btn btn-primary" >
														修改
													</button>
												</div>
											</div><!-- /.modal-content -->
										</div><!-- /.modal -->
									</div>
	
                                 </form>
                                   <!-------------------------------------------------------------->
 
    
    
    
    
    
    
     <!--------------------------------------添加的模糊框------------------------>  
                                 <form class="form-horizontal" method="post" action="/books/AddBookServlet">   <!--保证样式水平不混乱-->   
                                        <!-- 模态框（Modal） -->
									<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
										<div class="modal-dialog">
											<div class="modal-content">
												<div class="modal-header">
													<h4 class="modal-title" id="myModalLabel">
														添加新图书
													</h4>
												</div>
												<div class="modal-body">
												
										<!---------------------表单-------------------->
										
										<div class="form-group">
											<label for="firstname" class="col-sm-3 control-label">图书号</label>
												<div class="col-sm-7">
													<input type="text" class="form-control" id="addISBN" required="required" name="card" placeholder="请输入书号">
												<label class="control-label" for="addISBN" style="display: none;"></label>	
												</div>
										</div>
										
										 <div class="form-group">
											<label for="firstname" class="col-sm-3 control-label">图书名称</label>
												<div class="col-sm-7">
													<input type="text" class="form-control" id="addBookName" required="required" name="name"  placeholder="请输入图书名称">
													<label class="control-label" for="addBookName" style="display: none;"></label>	
												</div>
										</div>
											
										<div class="form-group">	
											<label for="firstname" class="col-sm-3 control-label">图书类型</label>
											<div class="col-sm-7">
												 <select class="form-control" id="addBookType" name="type">
                                           				 <option value="无分类">请选择</option>
                                           				  <%
	
  data = (ArrayList<TypeBean>)typedao.get_ListInfo();
  for (TypeBean bean : data){
  %>                 <option value="<%= bean.getName() %>"><%= bean.getName() %></option>                        <%} %>
                                      			  </select>
												<label class="control-label" for="addBookType" style="display: none;"></label>	
											</div>
										</div>
											
										<div class="form-group">	
											<label for="firstname" class="col-sm-3 control-label">作者名称</label>
												<div class="col-sm-7">
													<input type="text" class="form-control" id="addAuthor" required="required" name="author"  placeholder="请输入作者名称">
												<label class="control-label" for="addAuthor" style="display: none;"></label>	
												</div>
										</div>
										
										
										<div class="form-group">	
											<label for="firstname" class="col-sm-3 control-label">出版社</label>
												<div class="col-sm-7">
													<input type="text" class="form-control" id="addPress" required="required" name="press"  placeholder="请输入出版社">
												<label class="control-label" for="addPress" style="display: none;"></label>	
												</div>
										</div>
										
										
										<div class="form-group">	
											<label for="firstname" class="col-sm-3 control-label">总数量</label>
												<div class="col-sm-7">
													<input type="text" class="form-control" id="addNum" required="required" name="num" placeholder="请输入图书总数量">
												<label class="control-label" for="addNum" style="display: none;"></label>	
												</div>
										</div>
										
										
										
										<!---------------------表单-------------------->
									</div>
												<div class="modal-footer">
													<button type="button" class="btn btn-default" data-dismiss="modal">关闭
													</button>
													<button type="submit" class="btn btn-primary" >
														添加
													</button>
												</div>
											</div><!-- /.modal-content -->
										</div><!-- /.modal -->
									</div>

                                 </form>	
 								<!--------------------------------------添加的模糊框------------------------>
</div>
</body>
</html>