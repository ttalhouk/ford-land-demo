// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function(){


// $(document).on('turbolinks:load', function(){

  console.log('fancybox active');
  $('a.gallery').fancybox({
    'transitionIn'	:	'elastic',
    'transitionOut'	:	'elastic',
    'speedIn'		:	250,
    'speedOut'		:	250,
    'overlayShow'	:	true,
    'padding':10,
    'margin':0,
    'titlePosition':'over',
  });

});
