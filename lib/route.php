<?
  PIE::data("ROUTES", Array());
  PIE::addMethods(Array(
	'route'				=>	function($route, $callback) {
						  PIE::push("ROUTES", Array(
							'route'		=>	$route,
							'callback'	=>	$callback
						  ));
						},
	'executeRouteSubscriber'	=>	function($subscriber, $matches) {
						  if (function_exists($subscriber))
						    call_user_func_array($subscriber, $matches);
						  else if (file_exists($subscriber))
						    @include_once($subscriber);
						},
	'executeRouteSubscribers'	=>	function($subscribers, $matches) {
						  if (is_callable($subscribers))
						    call_user_func_array($subscribers, $matches);
						  else if (is_array($subscribers)) {
						    foreach ($subscribers as $subscriber)
						      PIE::executeRouteSubscribers($subscriber, $matches);
						  } else if (is_string($subscribers)) {
						    $subscribers = explode(';', $subscribers);
						    foreach ($subscribers as $subscriber)
						      PIE::executeRouteSubscriber(trim($subscriber), $matches);
						  }
						},
	'callRoute'			=>	function($url, $regex, $callback) {
						  if ($matches = PIE::preg_match($regex, $url)) {
						    PIE::data('PARAMS', $matches);
						    PIE::executeRouteSubscribers($callback, $matches);
						  }
						},
	'reroute'			=>	function($url) {
						  foreach (PIE::data('ROUTES') as $route) {
						    if (is_array($route['route']))
						      foreach ($route['route'] as $regex)
						        PIE::callRoute($url, $regex, $route['callback']);
						    else PIE::callRoute($url, $route['route'], $route['callback']);
						  }
						},
	'run'				=>	function() {
						  PIE::reroute($_SERVER['REDIRECT_URL']);
						}
  ));
?>