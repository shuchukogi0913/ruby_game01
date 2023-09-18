require 'dxruby'

# ウィンドウのサイズ
WINDOW_WIDTH = 600
WINDOW_HEIGHT = 600
#初期値設定
x = 32
y = y_prev = 32
f = 2
jump_ok = false



# マップデータ
@map = [[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0,0,0,0,0,0,0,0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0,0,0,0,0,0,0,0,0],
        [0, 0, 0, 1, 1, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0,0,0,0,0,0,0,0,0],
        [0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0,0,0,0,0,0,0,0],
        [0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0,0,0,0,0,0,0,0,0],
        [0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0,0,0,0,0,0,0,0,0],
        [0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0,0,0,0,0,0,0,0,0],
        [0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0,0,0,0,0,0,0,0,0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0,0,0,0,0,0,0,0,0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0,0,0,0,0,0,0,0,0],
        [0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0,0,0,0,0,0,0,0,0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0,0,0,0,0,0,0,0,0],
        [0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0,0,0,0,0,0,0,0,0],
        [0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0,0,0,0,0,0,0,0,0],
        [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1,1,1,1,1,1,1,1,1],
        [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1,1,1,1,1,1,1,1,1]]

# スプライトの配列
@map_sprites = []

for map_y in 0..15 do
    for map_x in 0..17 do
      case @map[map_y][map_x]
  
      when 0
        image = Image.new(32, 32, [0x00, 0x99, 0xff])  # 背景１（空）
      else
          image=nil
      end
      @map_sprites.push(Sprite.new(map_x * 32, map_y * 32, image))
    end
  end
  
  
  
  @map_sprites_cloud = []
  
  for map_y in 0..15 do
    for map_x in 0..17 do
      case @map[map_y][map_x]
      
      when 1
        image = Image.new(32, 32, [0x66,0x33,0x00])  #地面
      else
          image=nil
      end
      @map_sprites_cloud.push(Sprite.new(map_x * 32, map_y * 32, image))
    end
  end
  
  
  @map_sprites_ground = []
  
  for map_y in 0..15 do
    for map_x in 0..17 do
      case @map[map_y][map_x]
  
      when 2
        image = Image.new(32, 32, [0xff, 0xff, 0xff])  #雲
      else
          image=nil
      end
      @map_sprites_ground.push(Sprite.new(map_x * 32, map_y * 32, image))
    end
  end

Window.loop do



    for num in 0..100 do
    
        @map_sprites_ground[num].x -= 1
        @map_sprites[num].x -= 1
        @map_sprites_cloud[num].x -= 1
      
    end
    if @map_sprites_ground[num].x >= WINDOW_WIDTH
        @map_sprites_ground[num].x = 0
    end

 #@map_sprite.draw
  # マップの表示
 @map_sprites_ground.each { |sprite| sprite.draw }

  #左右移動
  x += Input.x * 2

   #キャラの表示
   #Window.draw(x, y, @char_tile)
 

 #ジャンプ
  if Input.key_push?(K_SPACE) and jump_ok
    f = -20
  end

  #Ｙ軸移動増分の設定
  y_move = (y - y_prev) + f
  #座標増分が１ブロックを超えないように補正
  if y_move > 31
    y_move = 31
  end
  y_prev = y
  y += y_move
  f = 2 #f値を初期化し直す

  #穴に落ちたら座標を初期化
  if y >= 480
    x = 32
    y = y_prev = 0
  end
  
  
  
  
  
end
