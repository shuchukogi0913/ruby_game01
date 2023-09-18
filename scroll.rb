
require 'dxruby'
#ゲームのウィンドウを作成します。
Window.width = 800
Window.height = 600

#背景画像を読み込みます。
background = Image.load('syuchukogi_picture.png')

#背景の座標を設定します。スクロールを管理するために、背景画像のx座標を変数として持ちます。
background_x = 0

#ゲームループを作成し、ゲームを実行します。このループ内で背景をスクロールさせます。
Window.loop do
    # 画面をクリア
    Window.draw(0, 0, background)
  
    # 背景をスクロール
    background_x -= 1  # ここでは1ピクセルずつ左にスクロールさせています
    background_x %= background.width  # 背景画像の幅で割った余りを取得してループ
  
    # スクロールした背景を描画
    Window.draw(background_x, 0, background)
    Window.draw(background_x - background.width, 0, background)  # ループするために2回描画
  end
 