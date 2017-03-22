// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$( document ).on('turbolinks:load', function(){
  var $imgs = $('.slideshow img');
  if ($imgs.length > 1){
    console.log('running rotation');
    setInterval(imageRotation, 5000);
  }

});

function imageRotation($imgs, $current) {
    var $imgs = $('.slideshow img');
    var $current = $imgs.parent().find('.show');
    var $next = $current.next();
    console.log({current:$current, next:$next});

    if ($next.length == 0) {
        $next = $imgs.eq(0);
    }
    $current.removeClass('show');
    $next.addClass('show');
    // $current.one('webkitTransitionEnd otransitionend oTransitionEnd msTransitionEnd transitionend', function(e){
    //
    //   $next.addClass('show');
    // })

}
