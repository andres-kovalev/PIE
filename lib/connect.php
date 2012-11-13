<?
  class pie_mysqli_stmt extends mysqli_stmt {
    private $values;
    private $binded;

    public function bind($types, $params) {
      call_user_func_array(Array($this, 'bind_param'), array_merge(Array($types), $params));
    }

    public function execute() {
      if (!parent::execute())
        return FALSE;
      $this->values = Array();
      $metadata = $this->result_metadata();
      if (!$metadata)
        return TRUE;
      $link = Array();
      while ($field = $metadata->fetch_field()) {
        $this->values[$field->name] = '';
        $link[] = &$this->values[$field->name];
      }
      if ($this->binded = (count($link) > 0))
        call_user_func_array(Array($this, 'bind_result'), $link);
      return $this;
    }

    private static function array_copy($source) {
      $copy = Array();
      foreach ($source as $key=>$value)
        $copy[$key] = $value;
      return $copy;
    }

    public function fetch() {
      $result = parent::fetch();
      if ($this->binded && $result)
        return pie_mysqli_stmt::array_copy($this->values);
      return $result;
    }

    public function fetch_all() {
      if (!$this->binded)
        return false;
      $rows = Array();
      while ($row = $this->fetch())
        $rows[] = $row;
      return $rows;
    }
  }

  class pie_mysqli extends mysqli {
    public function q($query, $types = null, $params = null) {
      $query = new pie_mysqli_stmt($this, $query);
      if ($query->errno)
        return $query;
      if ($types != null)
        $query->bind($types, $params);
      return $query->execute();
    }
  }

  PIE::addMethods(Array(
	'disconnect'	=>	function() {
				  if (PIE::isdata('DB.CONNECTION') && get_class(PIE::data('DB.CONNECTION')) == 'pie_mysqli')
				    PIE::data('DB.CONNECTION')->close();
				},
	'connect'	=>	function($settings = NULL) {
				  PIE::disconnect();
				  if ($settings === NULL) {
				    if (!PIE::isdata('DB.SETTINGS'))
				      return FALSE;
				    $settings = PIE::data('DB.SETTINGS');
				  }
				  PIE::data('DB.CONNECTION', new pie_mysqli($settings['SERVER'], $settings['USER'], $settings['PASSWORD'], $settings['DATABASE']));
 				  if ($settings['CHARSET'])
 				    PIE::data('DB.CONNECTION')->set_charset($settings['CHARSET']);
				  return TRUE;
				},
	'query'		=>	function($query, $types = null, $params = null) {
				  PIE::undata('DB.ERRORS');
				  return PIE::data('DB.CONNECTION')->q($query, $types, $params);
				},
	'select'	=>	function($query, $types = null, $params = null) {
				  PIE::undata('DB.ERRORS');
				  $q = PIE::query($query, $types, $params);
				  if ($q->errno) {
				    PIE::data('DB.ERRORS', $q->error_list);
				    $q->close();
				    return FALSE;
				  }
				  $rows = $q->fetch_all();
				  $q->close();
				  return $rows;
				}
  ));
?>