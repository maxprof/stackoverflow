// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function(){
    $(".show_edit_form").click(function(event){
      button = $(event.target);
      btnclass = button.attr("class").slice(46);
      form = $('.hidden_edit_form_' + btnclass);
      if (form.is(":visible")) {
        form.hide("slow");
      } else {
        form.show("slow");
      }
    });
});
