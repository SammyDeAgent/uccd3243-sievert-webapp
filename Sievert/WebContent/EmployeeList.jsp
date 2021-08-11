<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ page import="model.entity.Employee"%>
	<%@ page import="model.entity.Title"%>
	<%@ page import="java.util.*"%>
	<%@ page import="java.text.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Employees</title>

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
                <a class="nav-link" href="Departments">Departments</a>
            </li>
			
			<li><hr class="bg-light"></li>
            <li><h4 class="text-light font-weight-bold ml-2">Admin Access</h4></li>
            <li class="nav-item">
                <a class="nav-link active" href="Employees">Employees</a>
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
	int cur_page = (int) request.getAttribute("cur_page");
	int recordsPerPage = (int) request.getAttribute("recordsPerPage");
	int pages = (int) request.getAttribute("pages");
	String keyword = (String) request.getAttribute("keyword");
	String order = (String) request.getAttribute("order");
	List<Employee> rows = (List<Employee>) request.getAttribute("data");
	%>
	
	
	<div class="m-3 card">
	<div class="card-header">
	<div class="row">
		<div class="col">
			<form id="searchForm" class="form-inline" method="GET" action="Employees">
			<input type="hidden" name="cur_page" value="1" /> 
			<div class="input-group input-group-sm" >
				<div class="input-group-prepend">
    				<button class="btn btn-success" type="submit" ><i class='fa fa-search'></i></button>
  				</div>
				<input class="form-control" name="keyword" type="text" placeholder="Search for Employee" value="<%=keyword%>">
				<div class="input-group-append ml-n1">
				<span>
    				<select class="custom-select custom-select-sm" name="order">
    				<%
    					if(order.equals("ASC")){
    						out.println("<option value=\"ASC\" selected>Ascending</option>");
    						out.println("<option value=\"DESC\">Descending</option>");
    					}else if(order.equals("DESC")){
    						out.println("<option value=\"DESC\" selected>Descending</option>");
    						out.println("<option value=\"ASC\">Ascending</option>");
    					}
    				%>
					</select>
				</span>
  				</div>
			</div>
			<a href="Employees" class="btn btn-danger btn-sm ml-2" >Reset</a>
		</form>
		</div>
		<div class="col">
			<%
				if(pages != 0){
					out.println("<span class=\"pageref badge badge-secondary float-right\">");
					out.println(cur_page + " of " + pages);
					out.println("</span>");
				}
			%>
		</div>
	</div>
	</div>
	<div class="card-body">
	<div class="card-title">
		<h3>Employee List</h3>
	</div>
	<hr class="bg-muted">
	<table class="table table-hover">
		<%if(rows.size()!=0){ %>
		<thead class="thead-dark">
			<tr>
				<th>ID</th>
				<th>Name</th>
				<th>Gender</th>
				<th>DOB</th>
			</tr>
		</thead>
		<%} %>
		<tbody>
		<%
		if(rows.size()!=0){
			for(Employee emp: rows){
				Date dob = emp.getBirthDate();
				DateFormat dateFormat = new SimpleDateFormat("dd-MMM-yyyy");  
				String strDob = dateFormat.format(dob);  
				
				out.println("<tr onclick=\"window.location=\'Profile?id="+String.valueOf(emp.getId())+"\'\">");
				out.println("<td>"+String.valueOf(emp.getId())+"</td>");
				out.println("<td> "+emp.getFirstName()+" "+emp.getLastName()+"</td>");
				out.println("<td>"+emp.getGender()+"</td>");
				out.println("<td>"+strDob+"</td>");
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
		<nav aria-label="Navigation">
			<ul class="pagination justify-content-center">
				<%
				if(cur_page != 1 && pages != 0){
				%>
				<li class="page-item">
				<%
					out.println("<a class=\"page-link\" href=\"" + "Employees?&cur_page=" + (cur_page - 1) + "&keyword=" + keyword  + "&order=" + order + "\"><span aria-hidden=\"true\">&laquo;</span> Previous</a>");
				%>
				</li>	
				<%
					out.println("<li class=\"page-item\">");
					out.println("<a class=\"page-link\" href=\"" + "Employees?cur_page=1" + "&keyword=" + keyword + "&order=" + order + "\">First</a>");
					out.println("</li>");
				%>
				<%
				}
				%>
				
				<%
				if(cur_page < pages){
					out.println("<li class=\"page-item\">");
					out.println("<a class=\"page-link\" href=\"" + "Employees?cur_page=" + pages + "&keyword=" + keyword + "&order=" + order + "\">Last</a>");
					out.println("</li>");
					out.println("<li class=\"page-item\">");
					out.println("<a class=\"page-link\" href=\"" + "Employees?cur_page=" + (cur_page + 1) + "&keyword=" +  keyword + "&order=" + order + "\">Next <span aria-hidden=\"true\">&raquo;</span></a>");
					out.println("</li>");
				}
				%>
			</ul>
		</nav>
		</div>
	</div>
	
	<div id="RP_Toast" class="toast fade show m-3" style="position: fixed; right:0; bottom:0;" role="alert" aria-live="assertive" aria-atomic="true">
  		<div class="toast-header">
    		<strong class="mr-auto text-success">Sievert Console Admin</strong>
    		<button type="button" class="ml-2 mb-1 close" data-dismiss="toast" aria-label="Close">
      			<span aria-hidden="true">&times;</span>
    		</button>
  		</div>
  		<div class="toast-body">
    		Profile has been deleted.
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
		$("#RP_Toast").toast();
	</script>
	
	<!-- Notification Toast -->
	<%	
		Integer RP_Flag = null;
		try{
			 RP_Flag = (Integer) session.getAttribute("RemoveProfileAdmin");
		}catch(NullPointerException ex){
			
		}
		
		if(RP_Flag == 1){
			out.println("<script>$(\"#RP_Toast\").show();</script>");
			session.setAttribute("RemoveProfileAdmin", 0);
		}else if(RP_Flag == 0){
			out.println("<script>$(\"#RP_Toast\").hide();</script>");
		}
	%>

</body>
</html>