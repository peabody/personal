<?php 
header("HTTP/1.0 404 Not Found");
include("init.php"); ?>
<!doctype html public "-//W3C//DTD HTML 4.01 Transitional//EN"><html>
<head>
<title>Ah Shit!?</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta name="generator" content="GNU Emacs 21.3.1 (alpha--netbsd, X toolkit)
 of 2004-12-27 on ol">
<meta name="author" content="Sam Peterson">
<meta name="keywords" content="">
<meta name="description" content="">
<?= $_SESSION['css'] ?>
</head>

<body>
<div class="document">
<div name="header" class="titlebox">
	<h1>Ahhh Shit!</h1>

</div>

<p>Congratulations, the page you wanted (<?php echo $_ENV['HTTP_REFERER'] ?>)
totally does not exist.  Thank you for finding nothing, I will now
spam the web master for your effort.  Thank you.  You rock.</p>

<!-- Buttons -->
<a href="http://www.spreadfirefox.com/?q=affiliates&amp;id=0&amp;t=70"><img border="0" alt="Get Firefox!" title="Get Firefox!" src="http://sfx-images.mozilla.org/affiliates/Buttons/88x31/get.gif"/></a>
      <a href="http://validator.w3.org/check?uri=referer"><img border="0"
          src="http://www.w3.org/Icons/valid-html401"
          alt="Valid HTML 4.01!" height="31" width="88"></a>
<a href="http://python.org/">
    <img alt="" border="0"
         src="http://python.org/pics/PythonPoweredSmall.gif" >
</a>
<a href="http://www.gnu.org/software/emacs/emacs.html"><img src="http://www.teksolv.de/~jameson/button_emacs.png" alt="GNU EMACS" ></a>
<!-- Buttons -->
</div>
</body>
</html>