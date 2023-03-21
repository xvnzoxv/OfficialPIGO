<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content=
		"width=device-width, initial-scale=1.0">
	<title>Section links</title>

	<style>
		* {
			margin: 0;
			padding: 0;
		}
		
		body {
			width: 100vw;
			height: 100vh;
		}
		
		.section {
			width: 100vw;
			height: 40vh;
			background-color: #EF5354;
			font-size: 50px;
			color: white;
			text-align: center;
			margin: 10px 5px;
		}
		
		.one,
		.three {
			background-color: #E03B8B;
		}
		
		.nav {
			width: 100vw;
			height: 40vh;
			background-color: #3944F7;
			font-size: x-large;
			color: white;
			text-align: center;
			margin: 10px 5px;
			display: flex;
			flex-direction: row;
			justify-content: space-around;
			place-items: center;
		}
		
		.btn {
			color: white;
			background-color: #38CC77;
			height: 40px;
			width: 90px;
			padding: 2px;
			border: 2px solid black;
			text-decoration: none;
		}
	</style>
</head>

<body>
	<div class="nav">
		<a href="#section1" class="btn">1</a>
		<a href="#section2" class="btn">2</a>
		<a href="#section3" class="btn">3</a>
		<a href="#section4" class="btn">4</a>
	</div>
	<div class="section one" id="section1" lang="eng">
		section one
	</div>
	<div class="section two" id="section2">
		section 2
	</div>
	<div class="section three" id="section3">
		section 3
	</div>
	<div class="section four" id="section4">
		section 4
	</div>
</body>

</html>
