<?
// core file
class PIE {
  private static $data;
  private static $functions;

  public static function isdata($key) {
    $path = explode('.', $key);
    if (count($path) == 1)
      return isset(PIE::$data[$key]);
    $temp = &PIE::$data;
    foreach ($path as $subkey)
      if (!isset($temp[$subkey]))
        return FALSE;
      else $temp = &$temp[$subkey];
    return TRUE;
  }

  private static function getDataValue($key) {
    $path = explode('.', $key);
    if (count($path) == 1)
      return PIE::$data[$key];
    $temp = &PIE::$data;
    foreach ($path as $subkey)
      $temp = &$temp[$subkey];
    return $temp;
  }

  private static function changeValue($old_value, $new_value, $type) {
    switch ($type) {
      case 'set':
        return $new_value;
      case 'add':
        return $old_value + $new_value;
      case 'append':
        return "$old_value$new_value";
      case 'prepend':
        return "$new_value$old_value";
      case 'push':
	if (!is_array($old_value))
	  $old_value = Array($old_value);
        array_push($old_value, $new_value);
	return $old_value;
      case 'merge':
	if (!is_array($old_value))
	  $old_value = Array($old_value);
        return array_merge($old_value, $new_value);
    }
  }

  private static function changeDataValue($key, $value, $type) {
    $path = explode('.', $key);
    $count = count($path);
    if ($count == 1)
      return PIE::$data[$key] = PIE::changeValue(PIE::$data[$key], $value, $type);
    $temp = &PIE::$data;
    for($i=0; $i<$count-1; $i++) {
      $subkey = $path[$i];
      if (!isset($temp[$subkey]) || !is_array($temp[$subkey]))
        $temp[$subkey] = Array();
      $temp = &$temp[$subkey];
    }
    return $temp[$path[$count-1]] = PIE::changeValue($temp[$path[$count-1]], $value, $type);
  }

  public static function data($key, $value = NULL) {
    return ($value === NULL) ? PIE::getDataValue($key) : PIE::changeDataValue($key, $value, 'set');
  }

  public static function undata($key) {
    $path = explode('.', $key);
    $count = count($path);
    if ($count == 1)
      unset(PIE::$data[$key]);
    $temp = &PIE::$data;
    for($i=0; $i<$count-1; $i++) {
      $subkey = $path[$i];
      if (!isset($temp[$subkey]) || !is_array($temp[$subkey]))
        $temp[$subkey] = Array();
      $temp = &$temp[$subkey];
    }
    unset($temp[$path[$count-1]]);
  }

  public static function add($key, $value) {
    return PIE::changeDataValue($key, $value, 'add');
  }

  public static function sub($key, $value) {
    return PIE::changeDataValue($key, $value, 'sub');
  }

  public static function append($key, $value) {
    return PIE::changeDataValue($key, $value, 'append');
  }

  public static function prepend($key, $value) {
    return PIE::changeDataValue($key, $value, 'prepend');
  }

  public static function push($key, $value) {
    return PIE::changeDataValue($key, $value, 'push');
  }

  public static function merge($key, $value) {
    return PIE::changeDataValue($key, $value, 'merge');
  }

  public static function lib($directory = NULL) {
    return PIE::data('LIB', $directory);
  }

  public static function libcfg($directory = NULL) {
    return PIE::data('LIBCFG', $directory);
  }

  private static function initFunctions() {
    if (PIE::$functions === null)
      PIE::$functions = Array();
  }

  public static function hasMethod($method) {
    PIE::initFunctions();
    return array_key_exists($method, PIE::$functions);
  }

  public static function addMethods($methods) {
    PIE::initFunctions();
    foreach ($methods as $name => $method)
      PIE::$functions[$name] = $method;
  }

  public static function addMethod($name, $method) {
    PIE::addMethods(Array(
	$name	=>	$method
    ));
  }

  public static function __callStatic($name, $arguments) {
    PIE::initFunctions();
    if (!isset(PIE::$functions[$name])) {
      $cfg_filename = PIE::libcfg()."$name.php";
      if (file_exists($cfg_filename))
        @include_once($cfg_filename);
      @include_once(PIE::lib()."$name.php");
    }
    return call_user_func_array(PIE::$functions[$name], $arguments);
  }
}

PIE::lib('lib/');
PIE::libcfg('lib/cfg/');
?>