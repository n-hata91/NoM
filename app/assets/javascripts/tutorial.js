$(window).on("load", function () {
  if ( $("#first-visitor").text() == "true") {
    console.log('ok')
  introJs()
    .setOptions({
      nextLabel: '<i class="far fa-hand-point-right btn btn-outline-primary"></i>',
      prevLabel: '<i class="far fa-hand-point-left btn btn-outline-warning"></i>',
      skipLabel: '<i class="far fa-window-close btn btn-outline-danger"></i>',
      doneLabel: '<i class="far fa-check-square btn btn-outline-success"></i>',
      exitOnOverlayClick: true,
      keyboardNavigation: true,
      showStepNumbers: false,
      steps: [
        {
          intro: '<h5>NoMへようこそ！</h5><br><p>使い方の説明です。<br>不要な方はスキップできます。</p>'
        },
        {
          element: '#intro1',
          intro:"<p>みなさまの投稿記事です。選択することで詳細をご確認いただけます。</p>"
        },
        {
          element: '#intro2',
          intro:"<p>キーワードや言語名などで記事を検索することも可能です。</p>"
        },
        {
          element: '#intro3',
          intro:"<p>あなたに合った、人気の記事等をご確認ください。</p>"
        },
        {
          element: '#intro4',
          intro:"<p>こちらにカーソルを合わせるとメニューが表示されます。</p>"
        }
        ]
    }).start();
  }  
});
