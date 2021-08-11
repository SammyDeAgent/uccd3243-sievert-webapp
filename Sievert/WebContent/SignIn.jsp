<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Sign In</title>

<link rel="icon" type="image/ico" href="favicon.ico" />

<!-- External Files and Plugins -->
	<link rel="stylesheet" href="css/bootstrap.css">
	<link rel="stylesheet" href="css/united.min.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" href="css/default.css">

</head>
<body>
	

	
	<div class="card m-3 p-5">
        <div class="d-flex flex-row align-items-center">
            <h2>Sign In to <strong>Sievert</strong></h2>
        </div>
        <hr class="bg-muted">
        <% 
        	try{
        		int authError = (Integer) request.getAttribute("authError");
        		if(authError == 1){
            		out.println("<span class=\"text-danger pb-2\">*Incorrect matching ID or Last Name!</span>");
            	}
        	}catch(NullPointerException ex){
        		int authError = 0;
        	}finally{
        		
        	}
        %>
        <form action="SignIn" method="POST">
        	<div class="form-group">
                <input class="form-control" type="text" name="empId" placeholder="Enter Employee ID" required/>
            </div>
            <div class="form-group">
                <input class="form-control" type="text" name="lname" placeholder="Enter Last Name" required/>
            </div>
            <div class="form-group">
                <button type="submit" class="btn btn-primary btn-block">Sign In</button>
            </div>
        </form>
        <form action="Main" method="GET">
            <button type="submit" class="btn btn-secondary btn-block">Cancel</button>
        </form>
    </div>
	
	<!-- Visual Scripts -->
	<script 
		src="js/jquery-3.6.0.min.js"></script>
	<script
		src="js/popper.min.js"></script>
	<script
		src="js/bootstrap.js"></script>

</body>
</html>