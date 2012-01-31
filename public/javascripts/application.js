$(function() {
  //round corners
  $('#templatemo_menu a,.sidebar_title').corner('5px');
  $('.darkruby').corner('3px');

  //fancy box
  $("a.fancy").fancybox();
  $("a.not_fancy").click(function(){
    $("a.fancy").first().click();
    return false;
  });

  //instant cart
  $('.product').each(function(){
   var cart = $(this).find('a.instant_cart');
    $(this).hover(function(){
      cart.show();
    },function(){
      cart.hide();
    });
  });
  $('ul.alternate').find('li:odd').addClass('odd');
  $('ul.alternate').find('li:even').addClass('even');


  //plus1
  (function() {
    var po = document.createElement('script'); po.type = 'text/javascript'; po.async = true;
    po.src = 'https://apis.google.com/js/plusone.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(po, s);
  })();
});

