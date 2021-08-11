<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Sievert</title>

<link rel="icon" type="image/ico" href="favicon.ico" />

<!-- External Files and Plugins -->
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/united.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="css/index.css">
<link rel="stylesheet" href="css/default.css">

</head>
<body>

	<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
		<a class="navbar-brand font-weight-bold" href="Main"
			style="font-size: 2rem"> <img class="mr-1" src="favicon.ico"
			style="width: 50px"> Sievert
		</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active"><a class="nav-link" href="Main">Home
						<span class="sr-only">(current)</span>
				</a></li>
				<%
					try{
						int logged = (Integer) request.getSession().getAttribute("logged");
						if(logged==1){
							out.println("<li class=\"nav-item\"><a class=\"nav-link\" href=\"Console\">Console</a></li>");
						}else if(logged == 0){
						
						}
					}catch(NullPointerException ex){
						request.getSession().setAttribute("logged", 0);
					}
				%>
			</ul>

			<%
				try{
					int logged = (Integer) request.getSession().getAttribute("logged");
					String lName = (String) request.getSession().getAttribute("lName");
					if(logged==1){
						out.println("<span class=\" text-light mr-lg-3\">Welcome, <strong>"+lName+"</strong></span>");
						out.println("<button type=\"button\" class=\"btn btn-dark\" data-toggle=\"modal\" data-target=\"#SignOutModal\">Sign Out</button>");
					}else if(logged == 0){
						out.println("<form action=\"SignIn\" method=\"GET\"><input type=\"submit\" class=\"btn btn-block btn-dark\" value=\"Sign In\"></form>");
					}
				}catch(NullPointerException ex){
					request.getSession().setAttribute("logged", 0);
				}
			%>

		</div>
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

	<div class="jumbotron jumbotron-fluid">
		<div class="container">
			<h1 class="display-4">
				Welcome to <span style="color: yellow">Sievert</span>
			</h1>
			<p>International globally recognized pharamaceutical and
				bio-technology company.</p>
		</div>
	</div>

	<div class="card p-5 mt-n5">
		<h1 class="card-title display-3">Our history and mission</h1>
		<div class="pp1 mt-3 card-text text-justify">
			Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas
			ipsum nisi, porttitor id mi nec, eleifend sagittis lectus. Proin
			aliquet rutrum magna. Donec dictum mi sit amet dolor hendrerit, vel
			ultrices nunc sagittis. Nullam porta velit non mi mattis, eu mattis
			nibh porta. Maecenas accumsan leo sed ligula venenatis auctor. Duis
			augue ante, ultrices vel efficitur eu, mollis a enim. Cras
			scelerisque libero felis, vitae aliquet velit posuere ac. Mauris eget
			purus condimentum, fermentum sem non, cursus purus. Donec placerat
			cursus elit, vel porta odio rhoncus at. Cras suscipit odio turpis,
			vel mollis arcu eleifend ut. Nulla pharetra mollis tempus. Aliquam
			tempus massa nibh, ac auctor tellus fringilla eget. Praesent at urna
			id diam lacinia eleifend. Maecenas sit amet euismod urna. <br>
			Aenean hendrerit efficitur nunc non vestibulum. Nam et urna vel
			tortor aliquet vulputate. Aenean sed augue mauris. Cras eu dolor at
			augue malesuada cursus. Etiam aliquet tempor tristique. Etiam sed
			nisl finibus, lobortis odio ac, convallis nulla. Mauris sollicitudin
			est eu nunc posuere, eget ornare diam maximus. Integer cursus elit ac
			risus venenatis commodo. <br> Proin suscipit magna lorem, vel
			auctor mauris lobortis a. Sed eget placerat sapien. Vivamus accumsan
			lacinia viverra. In ultricies nulla nec augue varius, eget
			pellentesque sapien malesuada. Aliquam tristique sapien eu tortor
			imperdiet, fermentum rutrum enim scelerisque. In hac habitasse platea
			dictumst. Nullam nec risus facilisis, efficitur elit in, varius orci.
			Proin congue ac est non imperdiet. Fusce quis tincidunt augue. Sed ac
			bibendum justo, eu mattis libero. Sed commodo metus vitae dignissim
			tempor. Aliquam consectetur feugiat leo, ac ultrices purus bibendum
			in. In egestas et purus sed porttitor. Sed et rhoncus ipsum. <br>
			Maecenas vestibulum nibh at sodales venenatis. Ut venenatis bibendum
			nibh, eu consequat ante laoreet in. Nulla lorem dui, pulvinar ut
			mattis vel, tempor in sapien. Nunc vitae placerat nibh. Nam fermentum
			faucibus enim, id pellentesque massa pretium sed. In ut tempor lorem,
			tempus vehicula nunc. Sed dignissim interdum ligula, nec gravida
			massa dictum ut. Aliquam vitae dolor ornare, porttitor mi nec,
			tristique nibh. Mauris augue libero, pulvinar at nulla quis, laoreet
			ultrices turpis. Phasellus finibus ultrices arcu, ut maximus mauris
			fringilla egestas. Integer vel magna ullamcorper, imperdiet nibh
			gravida, commodo nunc. Maecenas sagittis posuere sem commodo
			bibendum. Vivamus tempor, massa quis tristique dignissim, lectus
			sapien auctor urna, et ullamcorper diam lectus eu felis. Phasellus
			pharetra malesuada lobortis.
		</div>
	</div>

	<footer class="bg-primary text-light p-2">
		<div class="d-flex justify-content-center align-content-center">
			All rights reserved to Cytokine Corps.</div>
	</footer>


	<!-- Visual Scripts -->
	<script 
		src="js/jquery-3.6.0.min.js"></script>
	<script
		src="js/popper.min.js"></script>
	<script
		src="js/bootstrap.js"></script>

</body>
</html>