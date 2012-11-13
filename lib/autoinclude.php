<?
  PIE::data('AUTOINCLUDE.BAD', Array('.', '..'));
  PIE::addMethods(Array(
	'autoinclude'	=>	function($directory, $recursive = TRUE) {
				  if (!PIE::preg_match('/^.*\/$/', $directory))
				    $directory .= "/";
				  $dir = opendir($directory);
				  while ($file = readdir($dir))
				  {
				    if (in_array($file, PIE::data('AUTOINCLUDE.BAD')))
				      continue;
				    $filename = "{$directory}{$file}";
				    if (is_dir($filename) && $recursive)
				      PIE::autoinclude("{$filename}/");
				    else @include_once("$filename");
				  }
				  closedir($dir);
				}
  ));
?>