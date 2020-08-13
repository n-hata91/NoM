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

// モバイルメニュー
$(function() {
  $(document).on("click", ".Toggle-bar", function() {
    $(this).toggleClass('active');
    $('.mobileMenu').toggleClass('active');
  });
});

// showレーダーチャート
$(function () {
  var ctx = $("#showRaderChart");
  var movie_title = $("#showMovieTitle").text();
  var difficulty = $("#show-difficulty").val();
  var length = $("#show-length").val();
  var practicality = $("#show-practicality").val();
  var speed = $("#show-speed").val();
  var accent = $("#show-accent").val();
  var paramater = ["難易度", "長さ", "実用性", "スピード", "クセ"]
  var data = [difficulty, length, practicality, speed, accent]
  new Chart(ctx, {
    type: 'radar', 
    data: { 
      labels: paramater,
      datasets: [{
        label: movie_title,
        data: data,
        backgroundColor: 'RGBA(45, 117, 255, 0.5)',
        pointBackgroundColor: 'RGB(237,172,38)',
        borderColor: 'RGBA(45, 117, 255, 1)',
        borderWidth: 2
        }]
    },
    options: {
      title: {
        display: true,
        text: "評価"
      },
      scale:{
        ticks:{
          suggestedMin: 0,
          suggestedMax: 5,
          stepSize: 1,
          callback: function(value, index, values){
            return  value
          }
        }
      }
    }
  });
});

// 映画インクリメンタルサーチ
$(function() {
  var search_list = $(".search-list");
  function appendReview(title) {
    var html = `<div class="list-group list-group-flush">
                  <li class="list-group-item list-group-item-action p-1">${title.title}</li>
                </div>`
    search_list.append(html);
  }
  $(document).on("keyup", ".movie-search-field", function() {
    var input = $(".movie-search-field").val();
    $.ajax({
      type: 'GET',
      url: '/learner/movies/search',
      data: { keyword: input },
      dataType: 'json'
    })
    .done(function(titles) {
      $(search_list).empty();
      if (titles.length !== 0) {
        titles.forEach(function(title){
          appendReview(title);
        });
      }
      if ($('input[type="text"]').val() === "") {
        $(search_list).empty();
      }
    })
  })
  $(document).on('click', ".list-group-item-action", function() {
    $(search_list).empty();
    $(this).val();
    $('input[type="text"]').val($(this).text());
  })
});

// 管理者 サイドshow
// ユーザー
$(function () {
  $(document).on("click", ".admin-user-data", function () {
    var user_id = $(this).data("number");
    $.ajax({
      type: "GET",
      url: "/admin/users",
      dataType: "script",
      data: { data: user_id }
    });
  });
});
// 記事
$(function () {
  $(document).on("click", ".admin-article-data", function () {
    var article_id = $(this).data("number");
    $.ajax({
      type: "GET",
      url: "/admin/articles",
      dataType: "script",
      data: { data: article_id }
    });
  });
});
// コメント
$(function () {
  $(document).on("click", ".admin-comment-data", function () {
    var comment_id = $(this).data("number");
    $.ajax({
      type: "GET",
      url: "/admin/comments",
      dataType: "script",
      data: { data: comment_id }
    });
  });
});