<?
  $page = PIE::append('PARAMS.1', '.html');
  $items = Array(
	'home.html'		=>	'Главная',
	'docs.html'		=>	'Документация',
	'{{download}}'	=>	'Скачать'
  );

  $parse = Array(
	'title'		=>	"Easy As PIE php framework - {$items[$page]}",
	'menu_title'	=>	'{PIE::*}',
	'menu_items'	=>	PIE::parses(PIE::get('menu_item'), array_map(function($link, $title) {
					return Array(
						'class'	=>	$link == PIE::data('PARAMS.1') ? ' class="active"' : '',
						'href'	=>	$link,
						'title'	=>	$title
					);
				}, array_keys($items), array_values($items))),
	'data'		=>	PIE::get("{$page}")
  );

  PIE::display(PIE::get('main'), $parse);
?>