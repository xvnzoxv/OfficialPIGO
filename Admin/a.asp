<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="UTF-8" />
	<meta name="viewport" content=
		"width=device-width, initial-scale=1.0" />

	<title>
		How to Create Wave Background using CSS ?
	</title>

	<style>
		body {
			padding: 0%;
			margin: 0%;
		}

		.geeks {
			padding: 200px;
			text-align: center;
		}

		section {
			width: 100%;
			min-height: 300px;
		}

		.pattern {
			position: relative;
			background-color: #3bb78f;
			background-image: linear-gradient(315deg,
					#3bb78f 0%, #0bab64 74%);
		}

		.pattern:before {
			content: "";
			position: absolute;
			bottom: 0;
			left: 0;
			width: 100%;
			height: 250px;
			background: url(
https://media.geeksforgeeks.org/wp-content/uploads/20200326181026/wave3.png);
			background-size: cover;
			background-repeat: no-repeat;
		}
	</style>
</head>

<body>
	<section class="pattern">
		<div class="geeks">
			<h1>GEEKS FOR GEEKS</h1>
		</div>
	</section>
</body>

</html>
