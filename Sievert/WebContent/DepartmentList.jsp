<%@ page import="java.util.List"%>
<%@ page import="model.entity.Department"%>
<%@ page import="model.entity.DepartmentManager"%>
<%@ page import="model.entity.Employee"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Departments</title>

<link rel="icon" type="image/ico" href="favicon.ico" />

<!-- External Files and Plugins -->
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/united.min.css">
<link rel="stylesheet" href="css/navbar-fixed-left.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="css/default.css">
<style>
	tbody tr{cursor: pointer;}
</style>

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
		List<Department> rows = (List<Department>) request.getAttribute("data2");
	%>
	
	<div class="card m-3">
		<div class="card-header">
		</div>
		<div class="card-body">
		<div class="card-title">
			<h3>Department List</h3>
		</div>
		<hr class="bg-muted">
		<table class="table table-hover">
			<%if(rows.size()!=0){ %>
			<thead class="thead-dark">
			<tr>
				<th>ID</th>
				<th>Department</th>
				<th>Managers</th>
			</tr>
			</thead>
			<%} %>
			<tbody>
			<%
				if(rows.size()!=0){
					for(Department dept: rows){
						out.println("<tr onclick=\"window.location=\'Departments?dept="+ dept.getId() +"'\">");
						out.println("<td>"+dept.getId()+"</td>");
						out.println("<td>"+dept.getDeptName()+"</td>");
						List<DepartmentManager> deptMngr = dept.getDepartmentManagers();
						out.println("<td>");
						for(DepartmentManager Mngr: deptMngr){
							Employee emp = Mngr.getEmployee();
							out.println("<div class=\"row\">");
							out.println("<div class=\"col\">"+emp.getFirstName()+" "+emp.getLastName()+"</div>");
							out.println("<div class=\"col\">("+emp.getId()+")</div>");
							out.println("</div>");
						}
						out.println("</td>");
						out.println("</tr>");
					}
				}else{
					String status = "No records";
					out.println(status);
				}
			%>
			</tbody>
		</table>		
		</div>
		<div class="card-footer">
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