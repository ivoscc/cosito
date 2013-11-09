$(document).ready(function() {
  $('#fact a.button').on('click', function(e) {
    $fact = $('#fact');
    $fact.hide(500);
    $fact.show(500);
  });
});