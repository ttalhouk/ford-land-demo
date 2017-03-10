// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$( document ).on('turbolinks:load', function() {
  // search bar handling
  $(".search-btn").on("click", function(){
    var searchField = $(this).parent().siblings('input');

    var regEx = new RegExp(searchField.val(),'i');
    if (searchField.val() !== '') {
      $('.info-row').each(function(){
        if(!regEx.test($(this).find('.search-field').text())){
          $(this).hide();
        } else {
          $(this).show();
        };
      });
    } else {
      $('.info-row').show();
    }
    searchField.val('');
  });
});
