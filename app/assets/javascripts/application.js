// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require activestorage
//= require jquery3
//= require jquery_ujs
//= require jquery-ui
//= require tag-it
//= require turbolinks
//= require_tree .
//= require popper
//= require bootstrap

$(function() {
  $(window).scroll(function() {
    $('.fade_in').each(function() {
      var offsetTop = $(this).offset().top;
      var scrollTop = $(window).scrollTop();
      var windowHeight = $(window).height();
      if (scrollTop > offsetTop - windowHeight + 400){
        $(this).addClass('afterscroll');
      }
    });
  });
});

// サイドバーメニュー
$(function() {
  $(document).on('click','.drawer-toggle',function(e) {
    e.preventDefault();
    $("html").toggleClass("open-drawer");
    $(".drawer-toggle").toggleClass("active");
  });
});

// 画像プレビュー
$(function() {
  $(document).on('change','#change_image' , function(e) {
    var new_image = new FileReader();
    new_image.onload = function(e) {
      $("#prev_image").attr('src', e.target.result);
    }
    new_image.readAsDataURL(e.target.files[0]);
  });
});

// コメント機能
$(function() {
  // 返信フォーム表示
  $(document).on("click", ".reply-btn", function() {
    var form_id = $(this).attr('id');
    $("#show-" + form_id).slideDown();
    $(".reply_cansel_btn").on("click", function() {
      $("#show-" + form_id).slideUp();
      $(".reply-btn").show();
    });
  });
  // 返信リスト表示
  $(document).on("click", ".show-replies", function() {
    var list_id = $(this).attr('id');
    $("#show-" + list_id).slideToggle();
  });
});

// learner top スプラッシュ
$(function() {
  $(document).on("click", ".splash-container", function () {
    $(this).fadeOut("slow");
  });
});


// スマホバーガー
$(function() {
  $(document).on("click", ".Toggle-bar", function() {
    $(this).toggleClass('active');
    $('.mobileMenu').toggleClass('active');
  });
});