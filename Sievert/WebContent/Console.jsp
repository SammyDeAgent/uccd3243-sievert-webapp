<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ page import="model.entity.Employee"%>
	<%@ page import="model.entity.Title"%>
	<%@ page import="model.entity.Salary"%>
	<%@ page import="java.util.*"%>
	<%@ page import="java.text.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Console</title>

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
                <a class="nav-link active" href="Console">Profile</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="Departments">Departments</a>
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

	<!-- SignOut Modal -->
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
	
	<div class="d-flex m-3 alert alert-info role="alert" id="clockHeader">
    	<strong class="mr-auto"><i class="fa fa-clock-o" aria-hidden="true"></i> Sievert Server Time</strong>
    	<span class="text-monospace"></span>
	</div>
	
	<%
		String lName = (String) request.getSession().getAttribute("lName");
		String fName = (String) request.getSession().getAttribute("fName");
		String empId = (String) String.valueOf(request.getSession().getAttribute("empId"));
		String gender = (String) request.getSession().getAttribute("gender");
		Date dob = (Date) request.getSession().getAttribute("dob");
		Date hired = (Date) request.getSession().getAttribute("hired");
		List<String> titles = (List<String>) request.getSession().getAttribute("titles");
		List<String> depts = (List<String>) request.getSession().getAttribute("depts");
		List<List<String>> salaries = (List<List<String>>) request.getSession().getAttribute("salaries");
	%>
	
	<div class="m-3 card">
		<div class="card-header">
			<div class="badge badge-secondary float-right">ID: <%= empId %></div>
		</div>
		<div class="container p-5">
			<div class="row">
				<div class="col-5 col-xl-3">
					<img src="img/default_staff.jpg" style="height:15rem; width:auto;">
				</div>
				<div class="col-7 col-xl-9">
					<div class="d-flex flex-column align-items-start"  style="height:15rem;">
						<div>
							<h3>
								<strong><%= fName + " " + lName %></strong>
							</h3>
						</div>
						<div class="mt-auto">
							<h4>
							<% 
								if(titles.size()!=0){
									for(String t : titles){ out.println(t+"<br>"); } 
								}else{
									out.println("<span class='text-danger'>Pending</span>");
								}
							%>
							</h4>
						</div>
					</div>
				</div>
			</div>
		</div>
		<hr class="bg-muted mx-5">
		<div class="container px-5 pt-3 pb-5">
			<div class="row">
				<div class="col-5 col-xl-3">
					<h3><strong>Department</strong></h3>
				</div>
				<div class="col-7 col-xl-3">
					<h3>
						<%	
							if(depts.size()!=0){
								for(String d : depts){ out.println(d+"<br>");}; 
							}else{
								out.println("<span class='text-danger'>Pending</span>");
							}
						%>
					</h3>
				</div>
				<div class="col-3">
					<h3><strong>Hired Date</strong></h3>
				</div>
				<div class="col-3">
				<h3>
					<%
						DateFormat dateFormat = new SimpleDateFormat("dd-MMM-yyyy");  
						String strHired = dateFormat.format(hired);
						out.println(strHired);
					%>
					</h3>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<h3><strong>Gender</strong></h3>
				</div>
				<div class="col">
					<h3><%= gender %></h3>
				</div>
				<div class="col">
					<h3><strong>Date of Birth</strong></h3>
				</div>
				<div class="col">
					<h3>
					<%  
						String strDob = dateFormat.format(dob);  
						out.println(strDob); 
					%>
					</h3>
				</div>
			</div>
			<br>
			<h3><strong>Salary Distribution</strong></h3>
			<table class="table table-hover">
				<%if(salaries.size()!=0){ %>
			<thead class="thead-dark">
			<tr>
				<th>Salary Amount</th>
				<th>Starting Period</th>
				<th>End Period</th>
			</tr>
			</thead>
			<%} %>
			<tbody>
			<%
				if(salaries.size()!=0){
					for(List<String> entry: salaries){
						out.println("<tr>");
						for(String data: entry){
							out.println("<td>"+data+"</td>");
						}
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
		<div class="card-footer px-5 py-3">
			<div class="row">
				<button type="button" class="btn btn-block btn-primary" data-toggle="modal" data-target="#EditPModal">
					<i class="fa fa-pencil-square-o" aria-hidden="true"></i>
					Edit Profile
				</button>
			</div>
		</div>
	</div>
	
	<!-- Edit Profile Modal -->
	<div class="modal" id="EditPModal" tabindex="-1"
		role="dialog" aria-labelledby="EditPModalLabel"
		aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="EditPModalLabel">Edit Profile</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form id="EditPForm" action="EditProfile" method="POST">
						<div class="form-group row">
							<label for="fNameInput" class="col-3 col-form-label">First Name</label>
							<div class="col-9">
								<input id="fNameInput" class="form-control" name="new_fName" type="text" value="<%= fName %>" placeholder="Enter First Name" required>
							</div>
						</div>
						
						<fieldset disabled>
						<div class="form-group row">
							<label for="lNameInput" class="col-3 col-form-label">Last Name</label>
							<div class="col-9">
								<input id="lNameInput" class="form-control" name="new_lName" type="text" value="<%= lName %>" placeholder="Enter Last Name" required>
								<span class="text-danger" style="font-size:0.75rem;">*Please contact the admin to change last name</span>
							</div>
						</div>
						</fieldset>
						
						
						<div class="form-group row">
							<label for="genderInput" class="col-3 col-form-label">Gender</label>
							<div class="col-9">
								<select name="new_gender" class="custom-select">
								<% 
									if(gender.equals("F")) {
										out.println("<option value=\"F\" selected>Female</option>");
										out.println("<option value=\"M\">Male</option>");
									}else if(gender.equals("M")){
										out.println("<option value=\"M\" selected>Male</option>");
										out.println("<option value=\"F\">Female</option>");
									}
								%>
								</select>
							</div>
						</div>
						
						<%
							int yr = dob.getYear()+1900;
							int mm = dob.getMonth()+1;
							int dy = dob.getDate();
						%>
						<div class="form-group row">
							<label for="DOBInput" class="col-3 col-form-label">DOB</label>
								<div class="col-3">
									<input name="new_day" class="form-control" type="number" min=01 max=31 value=<%=dy%>>
								</div>
								<div class="col-3">
									<input name="new_month" class="form-control" type="number" min=01 max=12 value=<%=mm%>>
								</div>
								<div class="col-3">
									<input name="new_year" class="form-control" type="number" min=1000 max=9999 value=<%=yr%>>
								</div>
						</div>
						
						<%
							int yr2 = hired.getYear()+1900;
							int mm2 = hired.getMonth()+1;
							int dy2 = hired.getDate();
						%>
						<div class="form-group row">
							<label for="HiredInput" class="col-3 col-form-label">Hired Date</label>
								<div class="col-3">
									<input name="new_day2" class="form-control" type="number" min=01 max=31 value=<%=dy2%>>
								</div>
								<div class="col-3">
									<input name="new_month2" class="form-control" type="number" min=01 max=12 value=<%=mm2%>>
								</div>
								<div class="col-3">
									<input name="new_year2" class="form-control" type="number" min=1000 max=9999 value=<%=yr2%>>
								</div>
						</div>
						
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
					<button type="button" class="btn btn-danger" form="EditPForm" onclick="this.form.reset();">Reset</button>
					<button type="submit" class="btn btn-dark" form="EditPForm">Confirm</button>
				</div>
			</div>
		</div>
	</div>
	
	<div id="EP_Toast" class="toast fade show m-3" style="position: fixed; right:0; bottom:0;" role="alert" aria-live="assertive" aria-atomic="true">
  		<div class="toast-header">
    		<strong class="mr-auto text-success">Sievert Console</strong>
    		<button type="button" class="ml-2 mb-1 close" data-dismiss="toast" aria-label="Close">
      			<span aria-hidden="true">&times;</span>
    		</button>
  		</div>
  		<div class="toast-body">
    		Profile has been updated.
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
	
	<script>
		$("#EP_Toast").toast();
	</script>
	
	<!-- Notification Toast -->
	<%	
		Integer EP_Flag = null;
		try{
			 EP_Flag = (Integer) session.getAttribute("EditProfile");
		}catch(NullPointerException ex){
			
		}
		
		if(EP_Flag == 1){
			out.println("<script>$(\"#EP_Toast\").show();</script>");
			session.setAttribute("EditProfile", 0);
		}else if(EP_Flag == 0){
			out.println("<script>$(\"#EP_Toast\").hide();</script>");
		}
	%>

</body>
</html>