<?
  PIE::addMethods(Array(
	'mbstring'	=>	function() {},
	's_mb'		=>	function($string) {
				  return iconv("UTF-8", "windows-1251", $string);
				},
	'mb_s'		=>	function($string) {
				  return iconv("windows-1251", "UTF-8", $string);
				},
	'a_mb'		=>	function($array) {
				  foreach ($arr as $key => $value)
				    $array[PIE::s_mb($key)] = PIE::s_mb($value);
				  return $array;
				},
	'mb_a'		=>	function($array) {
				  foreach ($array as $key => $value)
				    $array[PIE::mb_s($key)] = PIE::mb_s($value);
				  return $array;
				},
	'_mb'		=>	function($value) {
				  if (is_array($value))
				    return PIE::a_mb($value);
				  else if (is_string($value))
				    return PIE::s_mb($value);
				  return $value;
				},
	'mb_'		=>	function($value) {
				  if (is_array($value))
				    return PIE::mb_a($value);
				  else if (is_string($value))
				    return PIE::mb_s($value);
				  return $value;
				},
	'strtolower'	=>	function($str) {
				  if (function_exists('mb_strtolower'))
				    return mb_strtolower($str, "UTF-8");
				  return PIE::mb_(strtolower(PIE::_mb($str)));
				},
	'strtoupper'	=>	function($str) {
				  if (function_exists('mb_strtoupper'))
				    return mb_strtoupper($str, "UTF-8");
				  return mbstring::mb_(strtoupper(mbstring::_mb($str)));
				},
	'preg_match'	=>	function($regex, $string)
				{
				  $matches = Array();
				  if (!preg_match(PIE::s_mb($regex), PIE::s_mb($string), $matches))
				    return FALSE;
				  return PIE::mb_a($matches);
				},
	'preg_match_all'=>	function($regex, $string)
				{
				  $matches = Array();
				  if (!preg_match_all(PIE::s_mb($regex), PIE::s_mb($string), $matches))
				    return FALSE;
				  return PIE::mb_a($matches);
				}
  ));

  foreach (Array('strlen', 'strpos', 'substr', 'explode', 'join', 'str_replace', 'strtr', 'preg_replace', 'quotemeta') as $method)
    PIE::addMethod($method, function() {
	$function_name = debug_backtrace();
	$function_name = $function_name[2]['args'][0];

	$arguments = func_get_args();
	$count = count($arguments);
	for($i=0; $i<$count; $i++)
	  $arguments[$i] = PIE::_mb($arguments[$i]);

	return PIE::mb_(call_user_func_array($function_name, $arguments));
    });
?>