<?
  $type = PIE::data('PARAMS.1');
  $file = PIE::data('PARAMS.2');
  if (PIE::exists($template = "$type/$file"))
    PIE::display(PIE::get($template), NULL, $type);
  PIE::reroute(PIE::data('home'));
?>