require 'dxruby'

# ウィンドウのサイズ
WINDOW_WIDTH = 640
WINDOW_HEIGHT = 480

# スプライトの位置座標
sprite_x = 0

# スクロール速度
scroll_speed = 2  # スクロール速度を調整できます

Window.width = WINDOW_WIDTH
Window.height = WINDOW_HEIGHT

# 背景スプライトを作成
background_sprite = Sprite.new(sprite_x, 0, Image.new(WINDOW_WIDTH, WINDOW_HEIGHT, [100, 100, 255]))

Window.loop do
  # スプライトの座標を更新して水平方向のスクロールを実現
  sprite_x += scroll_speed

  # スプライトがウィンドウの幅を超えたらリセット
  if sprite_x >= WINDOW_WIDTH
    sprite_x = 0
  end

  background_sprite.x = -sprite_x  # スプライトの位置を設定してスクロールを表現
  background_sprite.draw

  break if Input.key_push?(K_ESCAPE)
end