
// Swiperのオプションを定数化
const opt = {
  loop: true,
  pagination: {
    el: '.swiper-pagination',
  },
  navigation: {
    nextEl: '.swiper-button-next',
    prevEl: '.swiper-button-prev',
  }
}

// Swiperを実行(初期化)
$(document).on('turbolinks:load', function() {
    let swiper = new Swiper('.swiper',opt);
});

// ハンバーガーメニュー
$('.nav_toggle').on('click', function () {
  $('.nav_toggle, .nav').toggleClass('show');
});

// 文字が動くアニメーション
　function slideAnime(){
    $('.leftAnime').each(function(){ 
      var elemPos = $(this).offset().top-50;
      var scroll = $(window).scrollTop();
      var windowHeight = $(window).height();
      if (scroll >= elemPos - windowHeight){
        $(this).addClass("slideAnimeLeftRight"); 
        $(this).children(".leftAnimeInner").addClass("slideAnimeRightLeft");
      }else{
        $(this).removeClass("slideAnimeLeftRight");
        $(this).children(".leftAnimeInner").removeClass("slideAnimeRightLeft");
      }
    });
  }
 
  $(window).scroll(function (){
    slideAnime();
  });
   $(window).on('load', function(){
    slideAnime();/* アニメーション用の関数を呼ぶ*/
  });
  
