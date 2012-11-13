<!DOCTYPE html>
<html>
 <head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <title>{{title}}</title>
  <link rel='stylesheet' href='{{root_dir}}asserts/bootstrap.css' type='text/css'/>
  <link rel='stylesheet' href='{{root_dir}}asserts/styles.css' type='text/css'/>
  <!--[if lt IE 9]>
   <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
  <![endif]-->
  <script type="text/javascript" src="{{root_dir}}asserts/prettify.js"></script>
  <script type="text/javascript" src="{{root_dir}}asserts/jquery.js"></script>
  <script type="text/javascript" src="{{root_dir}}asserts/bootstrap.js"></script>
  <script type="text/javascript" src="{{root_dir}}asserts/scripts.js"></script>
 </head>
 <body data-spy="scroll" data-target="#scrollspy-menu">
  <a id='top'></a>
  <div class="navbar navbar-fixed-top">
   <div class="navbar-inner">
    <div class="container">
     <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
     </a>
     <a class="brand" href="{{root_dir}}">{{menu_title}}</a>
     <div class="nav-collapse collapse">
      <ul class="nav">
{{menu_items}}      </ul>
     </div>
    </div>
   </div>
  </div>
{{data}}  <footer class="footer">
   <div class="container">
    <p class="pull-right"><a href="#"><i class='icon-arrow-up'></i> Наверх</a></p>
    <p>Фреймворк разработан <a href="https://www.facebook.com/profile.php?id=100003686611895" target="_blank">chuckie</a> под впечатлением от <a href="http://bcosca.github.com/fatfree/" target="_blank">Fat-Free Framework</a>.</p>
    <p>Данный программный продукт распространяется под лицензией <a href="http://www.gnu.org/licenses/gpl-3.0-standalone.html" target="_blank">GNU General Public License (GPLv3)</a>.</p>
    <p>Сайт разработан с использованием технологии <a href="http://twitter.github.com/bootstrap/" target="_blank">Twitter Bootstrap</a>.</p>
    <ul class="footer-links">
     <li><a href="http://chuckie.github.com/PIE/">Эта страница на GitHub</a></li>
     <li class="muted">&middot;</li>
     <li><a href="http://github.com/chuckie/PIE" target="_blank">Исходники</a></li>
     <li class="muted">&middot;</li>
     <li><a href="http://github.com/chuckie/PIE/issues?state=open" target="_blank">Вопросы</a></li>
    </ul>
   </div>
  </footer>
 </body>
</html>