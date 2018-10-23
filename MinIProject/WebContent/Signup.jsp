<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="utf-8"%>
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<!-- width=device-width:브라우저 너비를 장치 너비에 맞추어 표시함 -->
<!-- shrink-to-fit=no: ios 사파리 기준의  -->
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="러브다이어리">
<meta name="author" content="찌누">
<!-- 상단 아이콘 -->
<link rel="icon" href="image/book.png">

<title>Signup</title>

<!-- 부트트랩 연결 -->
<link href="css/bootstrap.min.css" rel="stylesheet">
<style>

.bg-light {
	background: url(image/akfajflqorud.jpg) no-repeat center center fixed; 
	-webkit-background-size: cover;
	-moz-background-size: cover;
	-o-background-size: cover;
	background-size: cover;
	margin-top: 100px;
	color: #ffffff;
}

.row {
	margin-right: 15%;
	margin-left: 15%;
}

</style>
<script type="text/javascript">
function page_href() {

location.href = "Login.jsp";

}
</script>
</head>
<body class="bg-light">
	<div class="container">
		<div class="py-5 text-center">
			<h2>Violet Love 회원가입</h2>
			<p class="lead">Violet Love에 오신걸 환영합니다. Violet Love의 뜻은 뒤질때까지 사랑하라는 뜻입니다 ༼ つ ◕_◕ ༽つ </p>
		</div>
		<h2 align="center" class="mb-3">회원가입 정보</h2>
		<hr>
		<form class="needs-validation" novalidate>
			<div class="row">
				<label for="firstName">성명</label><input type="text" class="form-control" id="firstName" placeholder="" value="" required>
				<br>
				<label for="address2">비밀번호</label><input type="password" class="form-control" id="password">
				<br>
				<label for="username">닉네임</label> <input type="text" class="form-control" id="username" placeholder="닉네임" required>
				<br>
				<label for="email">이메일</label> <input type="email" class="form-control" id="email" placeholder="아이디@도메인.com">
				<br>
				<label for="address">주소</label> <input type="text" class="form-control" id="address" placeholder="주소" required>
				<br>
				<hr class="mb-4">
				<table style="width: 90%;" align="center">
					<tr>
						<td align="center">
							<button style="width: 90%;"class="btn btn-primary btn-lg btn-block" type="submit">회원가입 완료</button>
						</td>
						<td align="center">
							<button onclick="page_href()" style="width: 90%;"class="btn btn-primary btn-lg btn-block" type="button">로그인 창으로</button>
						</td>
					</tr>
				</table>
			</div>
		</form>
	</div>
	<footer class="my-5 pt-5 text-muted text-center text-small">
	<br>
		<p class="mb-1">&copy; 홍일 소라 유진 준수</p>
		<ul class="list-inline">
			<li class="list-inline-item"><a href="#">Privacy</a></li>
			<li class="list-inline-item"><a href="#">Terms</a></li>
			<li class="list-inline-item"><a href="#">Support</a></li>
		</ul>
	</footer>

	<!-- Bootstrap core JavaScript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
		integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
		crossorigin="anonymous"></script>
	<script>
		window.jQuery|| document.write('<script src="../../assets/js/vendor/jquery-slim.min.js"><\/script>')
	</script>
	<script src="js/vendor/popper.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/vendor/holder.min.js"></script>
	<script>
		// Example starter JavaScript for disabling form submissions if there are invalid fields
	function() {
		'use strict';
		window.addEventListener('load',function() {
		// Fetch all the forms we want to apply custom Bootstrap validation styles to
		var forms = document.getElementsByClassName('needs-validation');
		// Loop over them and prevent submission
		var validation = Array.prototype.filter.call(forms,function(form) {
		form.addEventListener('submit',function(event) {
		if (form.checkValidity() === false) {event.preventDefault();
		event.stopPropagation();}
		form.classList.add('was-validated');},false);});}, false);})();
	</script>
</body>
</html>