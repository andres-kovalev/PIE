<?
  $page = PIE::data('PARAMS.1');
  $items = Array(
	'home'		=>	'Главная',
	'docs'		=>	'Документация',
	'download'	=>	'Скачать'
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
	'subtitle'	=>	$items[$page],
	'info'		=>	PIE::get("{$page}_info"),
	'data'		=>	PIE::get("{$page}_data")
  );

  PIE::display(PIE::get('main'), $parse);
?>