<%@ page import="java.util.List"%>
<%@ page import="model.entity.Department"%>
<%@ page import="model.entity.DepartmentManager"%>
<%@ page import="model.entity.DepartmentEmployee"%>
<%@ page import="model.entity.Employee"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">

<%
	Department data = (Department) request.getAttribute("data1");
%>

<title><%= data.getDeptName() %></title>

<link rel="icon" type="image/ico" href="favicon.ico" />

<!-- External Files and Plugins -->
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/united.min.css">
<link rel="stylesheet" href="css/navbar-fixed-left.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="css/default.css">

</head>
<body>
	
	<nav class="navbar navbar-expand-md navbar-dark bg-primary fixed-left">
    <a class="navbar-brand" href="Console">
    <img class="mr-2" src="favicon.ico"
			style="width: 50px"><strong>Console</strong></a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExampleDefault" aria-controls="navbarsExampleDefault" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarsExampleDefault">
        <ul class="navbar-nav">
        	<li class="nav-item">
                <a class="nav-link" href="Main">Home</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="Console">Profile</a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" href="Departments">Departments</a>
            </li>
            
            <li><hr class="bg-light"></li>
            <li><h4 class="text-light font-weight-bold ml-2">Admin Access</h4></li>
            <li class="nav-item">
                <a class="nav-link" href="Employees">Employees</a>
            </li>
            <li class="nav-item">
					<a class="nav-link" href="Register">Registration</a>
				</li>
        </ul>
    </div>
    <button type="button" class="btn btn-block btn-dark mt-auto" data-toggle="modal" data-target="#SignOutModal">Sign Out</button>
</nav>

<!-- Modal -->
	<div class="modal" id="SignOutModal" tabindex="-1"
		role="dialog" aria-labelledby="SignOutModalLabel"
		aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="SignOutModalLabel">Confirm Sign Out?</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
					<form action="SignOut" method="GET">
						<input type="submit" class="btn btn-block btn-dark" value="Confirm">
					</form>
				</div>
			</div>
		</div>
	</div>

	<div class="d-flex m-3 alert alert-info" role="alert" id="clockHeader">
    	<strong class="mr-auto"><i class="fa fa-clock-o" aria-hidden="true"></i> Sievert Server Time</strong>
    	<span class="text-monospace"></span>
	</div>
	
	<%
		int cur_page = (int) request.getAttribute("cur_page");
		int recordsPerPage = (int) request.getAttribute("recordsPerPage");
		int pages = (int) request.getAttribute("pages");
		int count = (int) request.getAttribute("count");
		String deptId = (String) request.getAttribute("deptId");
		List<Employee> deptEmp = (List<Employee>) request.getAttribute("paginated_emp");
	%>
	
	<div class="card m-3">
		<div class="card-header">
			<div class="badge badge-secondary float-right">ID: <%= data.getId() %></div>
			<a class="btn btn-dark btn-sm float-left" href="Departments">
			<i class="fa fa-arrow-left mr-1" aria-hidden="true"></i>
			Back to List
			</a>
		</div>
		<div class="card-body">
			<div class="card-title"><h2><strong><%= data.getDeptName() %></strong></h2></div>
			<h3>Manager(s)</h3>
			<table class="table table-hover">
			<thead class="thead-dark">
				<tr>
					<th class="col-4">ID</th>
					<th class="col-8">Name</th>
				</tr>
			</thead>
			<tbody>
				<%
				List<DepartmentManager> deptMngr = data.getDepartmentManagers();
				for(DepartmentManager Mngr : deptMngr){
					Employee emp = Mngr.getEmployee();
					out.println("<tr>");
					out.println("<td class=\"col-4\">"+emp.getId()+"</td>");
					out.println("<td class=\"col-8\">"+emp.getFirstName()+" "+emp.getLastName()+"</td>");
					out.println("</tr>");
				}
				%>
			</tbody>
			</table>
			<hr>
			<h3>Member(s)
			<%
				if(pages != 0){
					out.println("<span class=\"pageref badge badge-secondary float-right\">");
					out.println(cur_page + " of " + pages);
					out.println("</span>");
				}
			%>
			<span class="badge badge-success float-right mr-1">Member Count: <%=count %></span>
			</h3>
			<table class="table table-hover">
			<thead class="thead-dark">
				<tr>
					<th class="col-4">ID</th>
					<th class="col-8">Name</th>
				</tr>
			</thead>
			<tbody>
				<%
				for(Employee emp : deptEmp){
					out.println("<tr>");
					out.println("<td class=\"col-4\">"+emp.getId()+"</td>");
					out.println("<td class=\"col-8\">"+emp.getFirstName()+" "+emp.getLastName()+"</td>");
					out.println("</tr>");
				}
				%>
			</tbody>
			</table>
			
		</div>
		<div class="card-footer">
			<nav aria-label="Navigation">
			<ul class="pagination justify-content-center">
				<%
				if(cur_page != 1 && pages != 0){
				%>
				<li class="page-item">
				<%
					out.println("<a class=\"page-link\" href=\"" + "Departments?dept="+ deptId +"&cur_page=" + (cur_page - 1) + "\"><span aria-hidden=\"true\">&laquo;</span> Previous</a>");
				%>
				</li>	
				<%
					out.println("<li class=\"page-item\">");
					out.println("<a class=\"page-link\" href=\"" + "Departments?dept="+ deptId +"&cur_page=1" + "\">First</a>");
					out.println("</li>");
				%>
				<%
				}
				%>
				
				<%
				if(cur_page < pages){
					out.println("<li class=\"page-item\">");
					out.println("<a class=\"page-link\" href=\"" + "Departments?dept="+ deptId +"&cur_page=" + pages + "\">Last</a>");
					out.println("</li>");
					out.println("<li class=\"page-item\">");
					out.println("<a class=\"page-link\" href=\"" + "Departments?dept="+ deptId +"&cur_page=" + (cur_page + 1) + "\">Next <span aria-hidden=\"true\">&raquo;</span></a>");
					out.println("</li>");
				}
				%>
			</ul>
		</nav>
		</div>
	</div>
	
	<!-- Visual Scripts -->
	<script 
		src="js/jquery-3.6.0.min.js"></script>
	<script
		src="js/popper.min.js"></script>
	<script
		src="js/bootstrap.js"></script>
		
	<script src="js/clock.js"></script>

</body>
</html>