require 'dxruby'

# タイルサイズ、マップのサイズ、スクロール速度を設定
TILE_SIZE = 32
MAP_WIDTH = 20  # マップの幅（タイル単位）
MAP_HEIGHT = 15  # マップの高さ（タイル単位）
SCROLL_SPEED = 4  # スクロール速度
# 例: 画像を読み込む
image = Image.load('data.png')  # 'image.png' は実際の画像ファイルのパスです


# マップデータ（0: 空、1: 壁などの障害物）
@map = [
  [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
  [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
  [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
  # 他の行も同様に設定
]

# カメラの座標（マップのスクロール位置）
camera_x = 0
camera_y = 0

Window.width = TILE_SIZE * 10  # ウィンドウの幅
Window.height = TILE_SIZE * 7  # ウィンドウの高さ

Window.loop do
  # カメラの座標を更新してスクロールを実現
  camera_x += SCROLL_SPEED

  # カメラがマップの端に達したらリセット
  if camera_x >= (MAP_WIDTH - 10) * TILE_SIZE
    camera_x = 0
  end

  # ウィンドウ内に表示するマップの一部を描画
  Window.drawTile(0, 0, @map, [Image.new(TILE_SIZE, TILE_SIZE, [255, 0, 0])], camera_x, camera_y, 10, 7)

  break if Input.key_push?(K_ESCAPE)
end
