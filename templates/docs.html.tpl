  <header>
   <div class="container">
    <h1>Документация</h1>
    <p class="lead">Документация такая же простая, как и наш фреймворк.</p>
   </div>
  </header>
  <div class='container'>
   <div class='row'>
    <div class='span3 affix-container'>
     <div id="scrollspy-menu" class="well" data-spy="affix" data-offset-top="115" data-offset-bottom="270">
      <ul class="nav nav-list">
       <li class="nav-header">Ядро</li>
       <li><a href="#requirements"><i class="icon-check"></i> Требования</a></li>
       <li><a href="#using"><i class="icon-home"></i> Подключение</a></li>
       <li><a href="#settings"><i class="icon-wrench"></i> Настройка</a></li>
       <li><a href="#variables"><i class="icon-list"></i> Переменные</a></li>
       <li><a href="#methods"><i class="icon-user"></i> Методы пользователя</a></li>
       <li class="nav-header">Модули</li>
       <li><a href="#mbstring"><i class="icon-font"></i> UTF-8</a></li>
       <li><a href="#autoinclude"><i class="icon-file"></i> Автозагрузка файлов</a></li>
       <li><a href="#route"><i class="icon-random"></i> Маршрутизация</a></li>
       <li><a href="#template"><i class="icon-list-alt"></i> Шаблоны</a></li>
       <li><a href="#connect"><i class="icon-hdd"></i> Базы данных</a></li>
      </ul>
     </div>
    </div>
    <div class='span8 spy-content'>
     <section id='requirements'>
      <h1>Системные требования</h1>
      <p>Данный фреймворк для своей работы требует лишь php версии 5.3+ и больше ничего.</p>
      <p>А, ну да. Еще Вам понадобится большая куча терпения, чтобы переварить мой стиль написания доков. Наверное, это даже самое главное. Писать доки ведь не самое интересное занятие, так что, я надеюсь, Вы меня поймете.</p>
      <hr class="bs-docs-separator">
     </section>
     <section id='using'>
      <h1>Подключение</h1>
      <p>Нет ничего проще, чем подключить PIE к вашему проекту, ведь он состоит всего из одного модуля.</p>
      <pre class="prettyprint linenums">
require 'lib/pie.php';
</pre>
      <p>После этого Вам будет доступен статический класс <code>PIE</code>, который представляет собой микро-ядро фреймворка. По умолчанию данный класс содержит лишь несколько методов, которые реализуют 2 основные функции: управление переменными и, что самое интересное, расширение функционала. Ну, приступим!</p>
      <hr class="bs-docs-separator">
     </section>
     <section id='settings'>
      <h1>Настройка</h1>
      <p>На самом деле, сразу после подключения модуля <code>pie.php</code> фреймворк полностью готов к работе. Тем не менее, как уже было сказано ранее, фреймворк является расширяемым. Все расширения подгружаются автоматически по ленивой стратегии (по мере необходимости) из директории расширений. Путь к этой директории хранится в системной переменной <code>LIB</code> (значение по умолчанию <code>lib/</code>). Также, каждое расширение может иметь свои собственные настройки или требовать некоторой инициализации. Подобные настройки могут быть сохранены в файлах конфигурации, которые также будут подгружены автоматически из директории настроек, хранящейся в переменной <code>LIBCFG</code> (по умолчанию <code>lib/cfg/</code>). Значения этих переменных могут быть изменены стандартными средствами (см. следующий раздел) или через специальные функции-обертки.</p>
      <pre class="prettyprint linenums">
		// устанавливаем значение переменной LIB
PIE::data('LIB', 'plugins/');	// стандартным способом
PIE::lib('plugins/');		// используя метод-обертку
echo PIE::lib();		// вернет "plugins/"
echo PIE::libcfg('configs/');	// аналогично, вернет "configs/"
</pre>
      <div class="alert alert-info">
       <strong>Кстати.</strong> Если что-то не до конца ясно - смотрите следующие разделы.
      </div>
      <hr class="bs-docs-separator">
     </section>
     <section id='variables'>
      <h1>Переменные</h1>
      <p>Основным методом управления переменными в <code>{PIE::*}</code> является метод <code>data</code>. С его помощью можно устанавливать и получать значения переменных.</p>
      <pre class="prettyprint linenums">
PIE::data('some_var', 10);		// устанавливаем значение переменной
$var1 = PIE::data('some_var');		// считываем значение переменной
$var2 = PIE::data('some_var', 20);	// аналогично обычному присвоению
</pre>
      <p>Метод <code>data</code> также позволяет легко управляться с массивами. Причем, обращаться к элементам массива мы можем не только по имени, но и по индексу.</p>
      <pre class="prettyprint linenums">
PIE::data('some_var', Array(
	'first'		=>	'Monday',
	'second'	=>	'Tuesday'
));
echo PIE::data('some_var.first');	// вернет 'Monday'
...
PIE::data('some_var', Array('apple', 'banana', 'orange'));
echo PIE::data('some_var.1');		// вернет 'banana'
</pre>
      <p>Для проверки существования и уничтожения переменной <code>{PIE::*}</code> содержит методы, аналогичные стандартным <code>isset()</code> и <code>unset()</code>, соответственно.</p>
      <pre class="prettyprint linenums">
PIE::data('some_val', 10);
if (PIE::isdata('some_val')) {
	// условие выполнится
}
PIE::undata('some_val');
if (PIE::isdata('some_val')) {
	// условие не выполнится
}
</pre>
      <p>Для облегчения выполнения некоторых частых операций над переменными <code>{PIE::*}</code> содержит еще несколько приятных методов.</p>
      <table class='table table-bordered table-striped'>
       <thead>
        <tr>
         <th class='col1'>Метод</th>
         <th>Описание</th>
        </tr>
       </thead>
       <tbody>
        <tr>
         <td><code class="prettyprint">PIE::add([имя], [значение])</code></td>
         <td>Увеличивает переменную с заданным именем на заданное значение. Метод возвращает новое значение переменной.</td>
        </tr>
        <tr>
         <td><code class="prettyprint">PIE::sub([имя], [значение])</code></td>
         <td>Уменьшает переменную с заданным именем на заданное значение. Метод возвращает новое значение переменной.</td>
        </tr>
        <tr>
         <td><code class="prettyprint">PIE::append([имя], [значение])</code></td>
         <td>Дописывает заданное значение в конец переменной с заданным именем. Метод возвращает новое значение переменной.</td>
        </tr>
        <tr>
         <td><code class="prettyprint">PIE::prepend([имя], [значение])</code></td>
         <td>Дописывает заданное значение в начало переменной с заданным именем. Метод возвращает новое значение переменной.</td>
        </tr>
        <tr>
         <td><code class="prettyprint">PIE::push([имя], [значение])</code></td>
         <td>Добавляет новый элемент с указанным значением в конец переменной-массива с заданным именем. Если переменная ранее не являлась массивом, она превращается в массив с одним элементом. Метод возвращает новое значение переменной.</td>
        </tr>
        <tr>
         <td><code class="prettyprint">PIE::merge([имя], [массив])</code></td>
         <td>Объединяет переменную-массив с заданным именем с другим массивом. Если переменная ранее не являлась массивом, она превращается в массив с одним элементом. Метод возвращает новое значение переменной.</td>
        </tr>
       </tbody>
      </table>
      <div class="alert alert-info">
       <strong>Кстати.</strong> Напомним, что встроенными переменными <strong>LIB</strong> и <strong>LIBCFG</strong> также можно управлять с помощью этих методов.
      </div>
      <hr class="bs-docs-separator">
     </section>
     <section id='methods'>
      <h1>Методы пользователя</h1>
      <p>Вся соль данного фреймворка заключается в его расширяемости. <code>{PIE::*}</code> позволяет динамически добавлять в себя новые методы, которые вдальнейшем используются, как его собственные. И главное, сделать это проще простого!</p>
      <pre class="prettyprint linenums">
PIE::addMethod('foo', function(){	// добавляем метод
	echo 'executing foo()';
});
PIE::foo();				// его сразу можно использовать
...
PIE::addMethod('bar', function($name){	// можно использовать параметры
	return "Hello, $name!";		// и возвращать результат
});
echo PIE::bar("Andres");		// вернет "Hello, Andres!"
...
PIE::addMethods(Array(			// добавляем несколько методов
	'foo'		=>	function(){
				  return "foo";
				},
	'foobar'	=>	function(){
				  return PIE::foo()."bar";
				}
));
echo PIE::foobar();			// вернет "foobar"
...
if (PIE::hasMethod('foobar')) {
	// можно также проверить наличие метода
}
</pre>
      <p>Но какой в этом смысл? Почему нельзя сразу создать класс со всеми необходимыми методами? Какая польза от этого?</p>
      <p>Прелесть в том, что данные методы могут быть выделены в отдельные модули, которые далее <code>{PIE::*}</code> подгрузит автоматически!</p>
      <p>Как это работает? Все очень просто - каждый раз, когда Вы пытаетесь вызвать метод <code>{PIE::*}</code>, которого в нем еще нет, он пытается найти соответствующий модуль в директории расширений (помните переменную <code>LIB</code>?). Если такой модуль находится, <code>{PIE::*}</code> автоматически подключает его вместе с настройками (а <code>LIBCFG</code> помните?), после чего метод отправляется на выполнение.</p>
      <pre class="prettyprint linenums">
// файл plugins/bar.php
&lt;?
PIE::data('FOO', 10);	// можно инициализировать переменные
PIE::addMethod(Array(	// и добавить все необходимые методы
	'foo'	=>	function() {
			  return "foo";
			},
	'bar'	=>	function() {
			  return PIE::foo()."bar";
			},
));
?&gt;
...
// файл index.php
&lt;?
require 'pie.php';
PIE::lib('plugins/');
echo PIE::bar();		// вернет "foobar"
?&gt;
</pre>
      <p>Теперь-то Вы видите? <code>{PIE::*}</code> не только автоматически находит и подключает нужный метод, но и делает это не раньше, чем это может понадобиться. Другими словами, если закомментировать 18-ю строку, то файл <code>bar.php</code> не будет подключен и скрипт в итоге выполнится гораздо быстрее. Удобно, не правда ли?</p>
      <p>Более того, мы можем организовать условное подключение модулей. Давайте представим более реальный пример: у нас есть набор скриптов, которые используют базу данных. Очевидно, что для соединения с БД нам нужнен не только механизм но и настройки подключения, такие как логин и пароль. Мы можем объявить эти настройки в некотором глобальном файле настроек. Но что, если у нас есть скрипты, не соединяющиеся с БД? Тогда, конечно, настройки соединяния можно описать в самом модуле работы с БД. Но ведь гораздо удобнее хранить их в каком-то одном отдельном месте. Тут нам на помощь и приходит переменная <code>LIBCFG</code>. Каждый раз при подключении модуля расширений <code>{PIE::*}</code> пытается найти такой же файл в дирктории из <code>LIBCFG</code> и подключить его.</p>
      <pre class="prettyprint linenums">
// файл lib/connect.php
&lt;?
	// набор методов для подключения к БД
?&gt;
...
// файл lib/cfg/connect.php
&lt;?
PIE::data('DB.SETTINGS', Array(
	'SERVER'	=>	'localhost',
	'USER'		=>	'db_user',
	'PASSWORD'	=>	'********',
	'DATABASE'	=>	'db',
	'CHARSET'	=>	'utf8'
));
?&gt;
...
// файл index.php
&lt;?
require 'pie.php';
PIE::connect();		// соединение установлено
?&gt;
</pre>
      <p>Отделять мух от котлет так приятно.</p>
      <hr class="bs-docs-separator">
     </section>
     <section id='mbstring'>
      <h1>UTF-8</h1>
      <p>Первый модуль предназначен для работы со строками в кодировке UTF-8 без подключения библиотеки mbstring. Перед началом его использования требуется инициализация.</p>
      <pre class="prettyprint linenums">
PIE::mbstring();
</pre>
      <p>После этого можно использовать любой из методов этого модуля: <code>strlen</code>, <code>strpos</code>, <code>substr</code>, <code>strtolower</code>, <code>strtoupper</code>, <code>explode</code>, <code>join</code>, <code>str_replace</code>, <code>strtr</code>, <code>quotemeta</code>, <code>preg_replace</code>, <code>preg_match</code>, <code>preg_match_all</code>.</p>
      <p>Все эти методы, кроме двух последних, работают аналогично стандартным функциям.</p>
      <pre class="prettyprint linenums">
echo PIE::substr("hello", 1);	// вернет "ello"
if ($matches = PIE::preg_match("/love/", "I love oranges!")) {
	// в массив $matches будут записаны все совпадения
}
</pre>
      <hr class="bs-docs-separator">
     </section>
     <section id='autoinclude'>
      <h1>Автозагрузка файлов</h1>
      <p>Сколько конфигурационных файлов и модулей ядра в вашем проекте? Как часто вы пишете что-то вроде этого?</p>
      <pre class="prettyprint linenums">
// кусочек кода LiveStreet CMS
...
require_once("LsObject.class.php");
require_once("Plugin.class.php");
require_once("Block.class.php");
require_once("Hook.class.php");
require_once("Module.class.php");
require_once("Router.class.php");
require_once("Entity.class.php");
require_once("Mapper.class.php");
require_once("ModuleORM.class.php");
require_once("EntityORM.class.php");
require_once("MapperORM.class.php");
require_once("ManyToManyRelation.class.php");
...
</pre>
      <p>Почему бы не загрузить все разом? Для этого мы и добавили модуль автозагрузки. Теперь Вы можете скинуть все необходимые файлы в одну директорию и подключить их одной строкой кода.</p>
      <pre class="prettyprint linenums">
PIE::autoinclude('autoload/');		// кусочек кода этого сайта
</pre>
      <p>По умолчанию данный метод подключает модули из указанного каталога и всех его подкаталогов. Но рекурсивность можно отключить.</p>
      <pre class="prettyprint linenums">
PIE::autoinclude('autoload/', FALSE);	// нерекурсивная загрузка
</pre>
      <p>Теперь все глобальные настройки, а также наборы функций можно просто поместить в каталог автозагрузки и <code>{PIE::*}</code> сделает все остальное за Вас.</p>
      <div class="alert alert-info">
       <strong>Кстати.</strong> Стоит понимать отличие директории автозагрузки от директорий <strong>LIB</strong> и <strong>LIBCFG</strong> - в последних файлы подгружаются по ленивой стратегии (только когда это надо), в то время как <strong>autoinclude</strong> загружает все файлы сразу.
      </div>
      <div class="alert">
       <strong>Внимание.</strong> Модуль автозагрузки требует обязательного наличия метода <strong>mbstring</strong>, описанного в предыдущем разделе.
      </div>
      <hr class="bs-docs-separator">
     </section>
     <section id='route'>
      <h1>Маршрутизация</h1>
      <p>Одной из важных возможностей для любого фреймворка является маршрутизация. В <code>{PIE::*}</code> она реализуется в два этапа: настройка маршрутов и обработка запросов. Для добавления нового маршрута необходимо использовать метод <code>route</code>. Данный метод принимает в качестве параметров регулярное выражение для проверки маршрута и, собственно, обработчик маршрута.</p>
      <pre class="prettyprint linenums">
PIE::route('/\/home/', function() {
	// обработка маршрута "/home"
});
</pre>
      <div class="alert">
       <strong>Внимание.</strong> Чуть не забыл самое главное: чтобы вся эта красота работала, необходима настройка перенаправления apache. Например, файл <strong>.htaccess</strong> следующего вида вполне подойдет:
       <blockquote>
        <pre>RewriteEngine On
RewriteBase /
RewriteCond %{REQUEST_FILENAME} !-l
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule .* index.php [L,QSA]
</pre>
       </blockquote>
      </div>
      <p>В качестве обработчика может быть передано имя функции, анонимная функция (делегат) или подключаемого файла.</p>
      <pre class="prettyprint linenums">
function foo() {
	...
}
PIE::route('/\/foo/', 'foo');			// обработчик-функция
PIE::route('/\/bar/', 'routes/foo.php');	// подключение модуля
PIE::route('/.*/', function(){			// анонимная функция
	...
});
</pre>
      <div class="alert">
       <strong>Внимание.</strong> После запуска маршруты обрабатываются в порядке создания, по этому в предыдущем примере третий обработчик (/.*/) получит управление, если один из предыдущих двух не закончит работу скрипта функцией <strong>exit</strong>.
      </div>
      <p>Обработчик также может быть комбинированного типа, т.е. возможно назначить несколько обработчиков для одного маршрута. Так следующий код:</p>
      <pre class="prettyprint linenums">
PIE::route('/\/foo/', 'foo');
PIE::route('/\/foo/', 'routes/foo.php');
PIE::route('/\/bar/', 'bar');
PIE::route('/\/bar/', 'routes/bar.php');
PIE::route('/\/bar/', function() {
		...
});
</pre>
      <p>Можно заменить на:</p>
      <pre class="prettyprint linenums">
PIE::route('/\/foo/', 'foo; routes/foo.php');	// в строковом виде
PIE::route('/\/bar/', Array(			// в виде массива
	'bar',
	'routes/bar.php',			// эти два можно объединить
	function() {
		...
	}
));
</pre>
      <p>Также, <code>{PIE::*}</code> позволяет назначить нескольким маршрутам один и тот же обработчик (если такая ситуация может возникнуть). И вместо:</p>
      <pre class="prettyprint linenums">
PIE::route('/\/foo/', 'foobar');
PIE::route('/\/bar/', 'foobar');
</pre>
      <p>Мы получаем:</p>
      <pre class="prettyprint linenums">
PIE::route(Array('/\/foo/', '/\/bar/'), 'foobar');
</pre>
      <p>Результат обраобтки регулярного выражения внутри обработчика можно получить, обратившись к переменной <code>PARAMS</code>. Нулевой элемент этой переменной-массива содержит совпадение с самим регулярным выражением, а каждый следующий - с каждым подвыражением.</p>
      <pre class="prettyprint linenums">
PIE::route('/^\/([a-z]+)\/([0-9]+)\/?$/', function(){
	print_r(PIE::data('PARAMS'));exit;
/*
	при переходе по адресу /articles/123 мы получим:
	Array
	(
	    [0] => /articles/123
	    [1] => articles
	    [2] => 123
	)
*/
});
</pre>
      <p>Функции могут получать результаты через входные параметры, и вместо:</p>
      <pre class="prettyprint linenums">
PIE::route('/^\/([a-z]+)\/([0-9]+)\/?$/', function(){
	$param1 = PIE::data('PARAMS.1');
	$param2 = PIE::data('PARAMS.2');
	...
});
</pre>
      <p>Можно смело писать:</p>
      <pre class="prettyprint linenums">
PIE::route('/^\/([a-z]+)\/([0-9]+)\/?$/', function($url, $param1, $param2){
	...
});
</pre>
      <p>После того, как все маршруты были настроены, необходимо запустить маршрутизатор.</p>
      <pre class="prettyprint linenums">
PIE::run();
</pre>
      <p>Еще одной полезной возможностью маршрутизатора <code>{PIE::*}</code> является перемаршрутизация. Она позволяет выполнить скрипт так, как если бы пользователь обратился к определенному заданному адресу. Например, ее можно использовать для проверки маршрутов.</p>
      <pre class="prettyprint linenums">
PIE::route('/\/foo/', 'pages/foo.php');	// настройка маршрутов
PIE::route('/\/bar/', 'pages/bar.php');
PIE::route('/\/articles\/([0-9+)\/?/', 'pages/articles.php');

PIE::reroute('/foo');			// выполнится первый маршрут
</pre>
      <p>По сути, функция <code>run</code> представляет собой обертку над <code>reroute</code>.</p>
      <pre class="prettyprint linenums">
PIE::reroute($_SERVER['REDIRECT_URL']);
</pre>
      <p>Как мы уже говорили, все маршруты выполняются в порядке создания пока один из них не закончит выполнение скрипта (<code>exit</code>). Эта полезная особенность дает нам такие интересные возможности, как настройка страниц ошибок.</p>
      <pre class="prettyprint linenums">
PIE::route('/\/foo/', 'pages/foo.php');
PIE::route('/\/bar/', 'pages/bar.php');
PIE::route('/\/articles\/([0-9+)\/?/', 'pages/articles.php');
// если ни один из маршрутов не отработал, показываем ошибку 404
PIE::route('/.*/', 'pages/404.php');

PIE::run();
</pre>
      <p>Или, с использованием перемаршрутизации, установка страниц по умолчанию.</p>
      <pre class="prettyprint linenums">
...
PIE::route('/.*/', function(){
	PIE::reroute('/home');
});
</pre>
      <div class="alert">
       <strong>Внимание.</strong> Модуль маршрутизации требует обязательного наличия метода <strong>mbstring</strong>, описанного в <a href="#mbstring">соответствующем разделе</a>.
      </div>
      <hr class="bs-docs-separator">
     </section>
     <section id='template'>
      <h1>Шаблоны</h1>
      <p>Всем известно, что логику необходимо отделять от представления. И <code>{PIE::*}</code> с этим согласен, по этому у него есть простенький и быстрый <code>template</code>. Для его использования сначала следует шаблонизатор, указав каталог, в котором будут расположены файлы шаблонов.</p>
      <pre class="prettyprint linenums">
PIE::template('templates/');
</pre>
      <p>Шаблоны в <code>{PIE::*}</code>, это файлы с расширением *.tpl, в которых могут содержаться особые теги формата <code>{{имя}}</code>. Вдальнейшем эти теги будут заменены на значения.</p>
      <p>Для примера рассмотрим простой шаблон <code>simple.tpl</code>.</p>
      <pre class="prettyprint linenums">
&lt;b&gt;{{key}}:&lt;/b&gt; {{value}}&lt;br&gt;
</pre>
      <p>Теперь мы очень просто можем оформить с его помощью некоторые данные.</p>
      <pre class="prettyprint linenums">
$data = Array(
	'key'	=>	'name',
	'value'	=>	'Andres'
);
$template = PIE::get('simple');		// считываем шаблон
echo PIE::parse($template, $data);	// выведет &lt;b&gt;name:&lt;/b&gt; Andres&lt;br&gt;
</pre>
      <p>Шаблонизатор также умеет обрабатывать наборы данных. Например, для массива:</p>
      <pre class="prettyprint linenums">
$data = Array(
	Array(
		'key'	=>	'name',
		'value'	=>	'Andres'
	),
	Array(
		'key'	=>	'family',
		'value'	=>	'Kovalev'
	)
);
$template = PIE::get('simple');		// считываем шаблон
</pre>
      <p>Вместо:</p>
      <pre class="prettyprint linenums">
foreach($data as $value)
  echo PIE::parse($template, $value);
/*
	выведет:
		&lt;b&gt;name:&lt;/b&gt; Andres&lt;br&gt;
		&lt;b&gt;family:&lt;/b&gt; Kovalev&lt;br&gt;
*/
</pre>
      <p>Мы можем писать:</p>
      <pre class="prettyprint linenums">
echo PIE::parses($template, $data);
</pre>
      <p>Последний метод шаблонизатора - это <code>display</code>. Он является оберткой над <code>parse</code>. Его задача вывести обработанный шаблон и завершить выполнение сценария (<code>exit</code>). Он также принимает дополнительный входной параметр <code>$content_type</code>, который будет автоматически подставлен в соответствующий заголовок ответа сервера.</p>
      <pre class="prettyprint linenums">
// так, например, может выглядеть сценарий вывода статических страниц
// для маршрута PIE::route('/\/asserts\/([a-z]+)\.(css|js)/', 'static.php');
$type = PIE::data('PARAMS.2');
$file = PIE::data('PARAMS.1');
if (PIE::exists($template = "$type/$file"))
  PIE::display(PIE::get($template), NULL, $type);
PIE::reroute(PIE::data('home'));
</pre>
      <p>Для самых распространенных типов (<code>html</code>, <code>css</code> и <code>js</code>) содержимого можно передавать сокращение (как это сделано в примере). По умолчанию передается тип <code>html</code></p>
      <div class="alert">
       <strong>Внимание.</strong> Модуль шаблонизатора требует обязательного наличия метода <strong>mbstring</strong>, описанного в <a href="#mbstring">соответствующем разделе</a>.
      </div>
      <hr class="bs-docs-separator">
     </section>
     <section id='connect'>
      <h1>Базы данных</h1>
      <p><code>{PIE::*}</code> содержит несколько простых методов для работы с БД. Все эти методы являются лишь оберткой над стандартным классом <code><a href="http://php.net/manual/ru/book.mysqli.php" target="_blank">Mysqli</a></code>.</p>
      <p>Для установки соединения с БД используется метод <code>connect</code>. Настройки соединения могут быть переданы в качестве параметра, либо через переменную <code>DB.SETTINGS</code>.</p>
      <pre class="prettyprint linenums">
$mysql_config = Array(
	'SERVER'	=>	'server',
	'USER'		=>	'user',
	'PASSWORD'	=>	'********',
	'DATABASE'	=>	'db',
	'CHARSET'	=>	'utf8'
);
// передача настроек через системную переменную
PIE::data('DB.SETTINGS', $mysql_config);
PIE::connect();
// передача настроек через параметр
PIE::connect($mysql_config);
</pre>
      <p>При передаче настроек через параматр они все равно записываются в системную переменную <code>DB.SETTINGS</code>.</p>
      <p>Для разрыва соединения предназначен метод <code>disconnect</code>.</p>
      <pre class="prettyprint linenums">
PIE::disconnect();
</pre>
      <p>После того, как соединение установлено, можно смело выполнять запросы. Для этого есть два метода: <code>query</code> и <code>select</code>. Оба они принимают три параметра: параметризованный запрос, строку типов параметров и массив параметров (по аналогии с методом <code><a href="http://php.net/manual/ru/mysqli-stmt.bind-param.php" target="_blank">mysqli_stmt->bind_param</a></code>).</p>
      <p>Метод <code>query</code> возвращает объект класса <code>pie_mysqli_stmt</code>. Последний наследует <code><a href="http://php.net/manual/ru/class.mysqli-stmt.php" target="_blank">mysqli_stmt</a></code>, дополняя его методами <code>fetch</code> и <code>fetch_all</code>. Как следует из названия, метод <code>fetch</code> возвращает одну строку результата, а <code>fetch_all</code> - массив строк. Каждая строка результата представляет собой ассоциативный массив значений полей результата.</p>
      <p>Метод <code>select</code> является оберткой для метода <code>query->fetch_all</code> и, соответственно, предназначен только для выполнения выборки.</p>
      <pre class="prettyprint linenums">
$query = "SELECT *
	    FROM `message`
	    LIMIT ?, ?";
$from = 1;
$length = 10;

// выборка с помощью fetch()
$q = PIE::query($query, "ii", Array($from, $length));
$rows = Array();
while ($rows[] = $q->fetch());
$q->close();

// выборка с помощью fetch_all()
$q = PIE::query($query, "ii", Array($from, $length));
$rows = $q->fetch_all();
$q->close();

// выборка с помощью select()
$rows = PIE::select($query, "ii", Array($from, $length));
</pre>
      <p>В случае ошибки запроса метод <code>select</code> возвращает значение <code>FALSE</code>, а само содержание ошибки записывается в системную переменную <code>DB.ERRORS</code>.</p>
      <p>В случае метода <code>query</code> этот же массив ошибок доступен из <code>pie_mysqli_stmt->error_list</code>.</p>
      <pre class="prettyprint linenums">
// проверка ошибки в select()
if (!PIE::select("BAD QUERY"))
  print_r(PIE::data('DB.ERRORS'));

// проверка ошибки в query()
$q = PIE::query("BAD QUERY");
if ($q->errno)
  print_r($q->error_list);

/*
	// в обоих случаях на экране будет
	Array
	(
	    [0] => Array
	        (
	            [errno] => 1064
	            [sqlstate] => 42000
	            [error] => You have an error in your SQL syntax; check
				the manual that corresponds to your MySQL
				server version for the right syntax to use
				near 'BAD QUERY' at line 1
	        )
	)
*/
}
</pre>
      <p>Остальные детали можно почитать в документации <code><a href="http://php.net/manual/ru/class.mysqli-stmt.php" target="_blank">mysqli_stmt</a></code>.</p>
     </section>
    </div>
   </div>
  </div>
