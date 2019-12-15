$(function() {
  $("#open").click(function(){
    $("#modal").fadeIn(200);
  });

  $(".modal_bg").click(function(){
    $("#modal").fadeOut(200);
  });
});
