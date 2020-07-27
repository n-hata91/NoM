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
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
//= require jquery3
//= require popper
//= require bootstrap

// コメント機能
(function() {
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
}());

// お気に入り機能
(function () {
  
}());