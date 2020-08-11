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

// newページチャート
$(function() {
  var params = document.getElementsByClassName('rate-range'); // ★の増減
  var rate = function (params, stars) {
    return function(evt) {
      apple = "★"
      stars.innerHTML = apple.repeat( params.value );
      var ctx = document.getElementById("myRaderChart");
      var movie_title = document.getElementById("MovieTitle");
      var difficulty = document.getElementById("difficulty").value;
      var length = document.getElementById("length").value;
      var practicality = document.getElementById("practicality").value;
      var speed = document.getElementById("speed").value;
      var accent = document.getElementById("accent").value;
      var paramater = ["難易度", "長さ", "実用性", "スピード", "クセ"]
      var data = [difficulty, length, practicality, speed, accent]
      var myRadarChart = new Chart(ctx, {
        type: 'radar', 
          data: { 
            labels: paramater,
            datasets: [{
              label: movie_title.textContent,
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
    }
  }
  for(var i = 0, max = params.length; i < max; i++){
    range_bar = params[i].getElementsByTagName('input')[0];
    stars = params[i].getElementsByTagName('span')[0];
    range_bar.addEventListener('input', rate(range_bar , stars));
  }
});

// showページチャート
$(function () {
  var ctx = document.getElementById("showRaderChart");
  var movie_title = document.getElementById("showMovieTitle");
  var difficulty = document.getElementById("show-difficulty").value;
  var length = document.getElementById("show-length").value;
  var practicality = document.getElementById("show-practicality").value;
  var speed = document.getElementById("show-speed").value;
  var accent = document.getElementById("show-accent").value;
  var paramater = ["難易度", "長さ", "実用性", "スピード", "クセ"]
  var data = [difficulty, length, practicality, speed, accent]
  var myRadarChart = new Chart(ctx, {
    type: 'radar', 
      data: { 
        labels: paramater,
        datasets: [{
          label: movie_title.textContent,
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