<%@ page import="java.util.List"%>
<%@ page import="model.entity.Department"%>
<%@ page import="model.entity.DepartmentManager"%>
<%@ page import="model.entity.Employee"%>
<%@ page import="model.entity.Title"%>
<%@ page import="model.entity.Salary"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">

<title>Registration</title>

<link rel="icon" type="image/ico" href="favicon.ico" />

<!-- External Files and Plugins -->
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/united.min.css">
<link rel="stylesheet" href="css/navbar-fixed-left.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="css/default.css">

</head>
<body>

	<nav class="navbar navbar-expand-md navbar-dark bg-primary fixed-left">
		<a class="navbar-brand" href="Console"> <img class="mr-2"
			src="favicon.ico" style="width: 50px"><strong>Console</strong></a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarsExampleDefault"
			aria-controls="navbarsExampleDefault" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarsExampleDefault">
			<ul class="navbar-nav">
				<li class="nav-item"><a class="nav-link" href="Main">Home</a></li>
				<li class="nav-item"><a class="nav-link" href="Console">Profile</a>
				</li>
				<li class="nav-item"><a class="nav-link" href="Departments">Departments</a>
				</li>

				<li><hr class="bg-light"></li>
				<li><h4 class="text-light font-weight-bold ml-2">Admin
						Access</h4></li>
				<li class="nav-item"><a class="nav-link" href="Employees">Employees</a></li>
				<li class="nav-item"><a class="nav-link active"
					href="Register.jsp">Registration</a></li>
			</ul>
		</div>
		<button type="button" class="btn btn-block btn-dark mt-auto"
			data-toggle="modal" data-target="#SignOutModal">Sign Out</button>
	</nav>

	<!-- Modal -->
	<div class="modal" id="SignOutModal" tabindex="-1" role="dialog"
		aria-labelledby="SignOutModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="SignOutModalLabel">Confirm Sign
						Out?</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
					<form action="SignOut" method="GET">
						<input type="submit" class="btn btn-block btn-dark"
							value="Confirm">
					</form>
				</div>
			</div>
		</div>
	</div>

	<div class="d-flex m-3 alert alert-info" role="alert" id="clockHeader">
		<strong class="mr-auto"><i class="fa fa-clock-o"
			aria-hidden="true"></i> Sievert Server Time</strong> <span
			class="text-monospace"></span>
	</div>
	
	<%
		List<List<String>> deptInfo = (List<List<String>>) request.getAttribute("deptInfo");
	%>
	
	<div class="card m-3">
		<div class="card-header"></div>
		<div class="card-body">
			<h3>
				<strong>Register new Employee Profile</strong>
			</h3>
			<hr class="bg-muted">
			<form id="RegForm" class="form-group" method="POST"
				action="RegProfileAdmin">

				<div class="form-inline my-3 row">
					<h4 class="col-2">Employee Name</h4>
					<input name="RegFName" type="text" class="form-control mx-3 col"
						placeholder="Enter First Name" required> <input
						name="RegLName" type="text" class="form-control mx-3 col"
						placeholder="Enter Last Name" required>
				</div>

				<div class="form-inline my-3 row">
					<h4 class="col-2">Gender</h4>
					<select name="RegGender" class="custom-select mx-3 col">
						<option value="M">Male</option>
						<option value="F">Female</option>
					</select>
				</div>

				<div class="form-inline my-3 row">
					<h4 class="col-2">DOB</h4>
					<input name="RegDOBDay" class="form-control mx-3 col" type="number" min=01	max=31 placeholder="Day" required> 
					<input name="RegDOBMonth" class="form-control mx-3 col" type="number" min=01 max=12 placeholder="Month" required> 
					<input name="RegDOBYear" class="form-control mx-3 col" type="number" min=1000 max=9999 placeholder="Year" required>
				</div>
				
				<div class="form-inline my-3 row">
					<h4 class="col-2">Hired Date</h4>
					<input name="RegHiredDay" class="form-control mx-3 col" type="number" min=01	max=31 placeholder="Day" required> 
					<input name="RegHiredMonth" class="form-control mx-3 col" type="number" min=01 max=12 placeholder="Month" required> 
					<input name="RegHiredYear" class="form-control mx-3 col" type="number" min=1000 max=9999 placeholder="Year" required>
				</div>
				
				<div class="form-inline my-3 row">
					<h4 class="col-2">Department</h4>
					<select name="RegDeptId" class="custom-select mx-3 col">
						<%
							for(List<String> data : deptInfo){
								out.println("<option value=\""+data.get(0)+"\">"+data.get(1)+"</option>");
							}
							
						%>
						<option value="null">Pending</option>
					</select>
				</div>
			</form>
		</div>
		<div class="card-footer">
			<button class="btn btn-primary float-right" type="submit"
				form="RegForm">Add Profile</button>
			<button class="btn btn-danger float-right mr-2" type="reset"
				form="RegForm">Reset</button>
		</div>
	</div>

	<div id="ADD_Toast" class="toast fade show m-3"
		style="position: fixed; right: 0; bottom: 0;" role="alert"
		aria-live="assertive" aria-atomic="true">
		<div class="toast-header">
			<strong class="mr-auto text-success">Sievert Console Admin</strong>
			<button type="button" class="ml-2 mb-1 close" data-dismiss="toast"
				aria-label="Close">
				<span aria-hidden="true">&times;</span>
			</button>
		</div>
		<div class="toast-body">Profile has been added to database.</div>
	</div>

	<!-- Visual Scripts -->
	<script src="js/jquery-3.6.0.min.js"></script>
	<script src="js/popper.min.js"></script>
	<script src="js/bootstrap.js"></script>

	<script src="js/clock.js"></script>

	<script>
		$("#ADD_Toast").toast();
	</script>

	<!-- Notification Toast -->
	<%
		Integer ADD_Flag = null;
		try {
			ADD_Flag = (Integer) session.getAttribute("AddProfileAdmin");
		} catch (NullPointerException ex) {

		}

		if (ADD_Flag == 1) {
			out.println("<script>$(\"#ADD_Toast\").show();</script>");
			session.setAttribute("AddProfileAdmin", 0);
		} else if (ADD_Flag == 0) {
			out.println("<script>$(\"#ADD_Toast\").hide();</script>");
		}
	%>

</body>
</html>