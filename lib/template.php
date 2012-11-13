<?
  PIE::addMethods(Array(
	'template'		=>	function($directory = NULL) {
					  if (!PIE::preg_match('/\/$/', $directory))
					    $directory .= "/";
					  PIE::data('TEMPLATE.DIR', $directory);
					},
	'getTemplatePath'	=>	function($templateFileName) {
					  return PIE::data('TEMPLATE.DIR')."{$templateFileName}.tpl";
					},
	'exists'		=>	function($templateFileName) {
					  return file_exists(PIE::getTemplatePath($templateFileName));
					},
	'get'			=>	function($templateFileName) {
					  if (!PIE::exists($templateFileName))
					    return '';
					  $filename = PIE::getTemplatePath($templateFileName);
					  $file = @fopen($filename, 'r');
					  $content = @fread($file, filesize($filename));
					  @fclose($file);
					  return $content;
					},
	'parse'			=>	function($content, $parse = Array()) {
					  if (isset($parse) && is_array($parse))
					    foreach($parse as $key => $value)
					      $content = PIE::str_replace("{{{$key}}}", (string)$value, $content);
					  return $content;
					},
	'parses'		=>	function($block, $parses) {
					  $content = "";
					  foreach ($parses as $parse)
					    $content .= PIE::parse($block, $parse);
					  return $content;
					},
	'display'		=>	function($content, $parse = NULL, $content_type = '') {
					  if (!is_array($parse))
					    $parse = Array();
					  if (PIE::isdata('TEMPLATE.DEFAULTS'))
					    foreach (PIE::data('TEMPLATE.DEFAULTS') as $key => $value)
					      if (!array_key_exists($key, $parse))
					        $parse[$key] = $value;
					  switch ($content_type) {
					    case 'css':
					      $content_type = 'text/css';
					      break;
					    case 'js':
					      $content_type = 'text/javascript';
					      break;
					    case 'html':
					    case '':
					      $content_type = 'text/html';
					      break;
					  }
					  header("Content-type: $content_type; charset=UTF-8;");
					  exit(PIE::parse($content, $parse));
					}
  ));
?>