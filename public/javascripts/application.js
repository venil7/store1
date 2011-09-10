$(function() {
  //round corners
  $('#templatemo_menu a,.sidebar_title').corner('5px');
  $('.darkruby').corner('3px');

  //lava lamp style menu
  gooeymenu.setup({id:'menu'});

  //slides
  $("#templatemo_banner").slides({
    play: 4000,
    generateNextPrev:true,
    generatePagination:false
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

