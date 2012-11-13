<?
//  error_reporting(0);
  date_default_timezone_set('UTC');
  require './lib/pie.php';

  PIE::libcfg('include/');
  PIE::autoinclude('autoload/');
  PIE::template(PIE::data('dirs.templates'));

  PIE::route('/\/(home|docs)\.html$/', PIE::data('dirs.modules').'mod_page.php');
  PIE::route('/\/asserts\/([a-z]+)\.(css|js)$/', PIE::data('dirs.modules').'mod_static.php');
  PIE::route('/.*/', Array('init.php', function(){
	PIE::reroute(PIE::data('home'));
  }));

  PIE::run();
?>