require 'dxruby'

# マップデータ
@map = [[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ,0 ,0 ,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        [0, 0, 0, 1, 1, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        [0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        [0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        [0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        [0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        [0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        [0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        [0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        [0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        [1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 0, 1, 1, 0, 1, 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
        [1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 0, 1, 1, 0, 1, 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]]


        maphight=16
        mapwideth=31

# スプライトの配列
#空
@map_sprites = []

for map_y in 0..15 do
  for map_x in 0..30 do
    case @map[map_y][map_x]

    when 0
      image = Image.new(32, 32, [0x00, 0x99, 0xff])  # 背景１（空）
    else
        image=nil
    end
    @map_sprites.push(Sprite.new(map_x * 32, map_y * 32, image))
  end
end



#地面
@map_sprites_cloud = []

#キャラ

@char_tile = Image.load('gori.png')
@char_tile.set_color_key(C_WHITE)
#フレーム数設定
Window.fps = 30
#サウンド
sound_effect = Sound.new('se_jump_001.wav')#ジャンプ
sound_effect1 = Sound.new('se_powerdown_007.wav')#落下時


for map_y in 0..15 do
  for map_x in 0..30 do
    case @map[map_y][map_x]
    
    when 1
      image = Image.new(32, 32, [0x66,0x33,0x00])  #地面
    else
        image=nil
    end
    @map_sprites_cloud.push(Sprite.new(map_x * 32, map_y * 32, image))
  end
end

#雲
@map_sprites_ground = []

for map_y in 0..15 do
  for map_x in 0..30 do
    case @map[map_y][map_x]

    when 2
      image = Image.new(32, 32, [0xff, 0xff, 0xff])  #雲
    else
        image=nil
    end
    @map_sprites_ground.push(Sprite.new(map_x * 32, map_y * 32, image))
  end
end


#キャラ
#@char_tile = Image.new(32, 32, C_RED)
#初期値設定

x = 32
y = y_prev = 32
f = 2
jump_ok = false



image_char = Image.new(32, 32, C_GREEN)
char = Sprite.new(x, y, image_char)

font = Font.new(32)  #フォントの設定

Window.loop do
  # マップの表示
  @map_sprites.each { |sprite| sprite.draw }
  @map_sprites_cloud.each { |sprite| sprite.draw }
  @map_sprites_ground.each { |sprite| sprite.draw }


  #左右移動
  #x += Input.x * 2
   #キャラの表示
   #Window.draw(x, y, @char_tile)


   if Input.key_down?(K_LEFT)
        char.x -= 1
   end

   if Input.key_down?(K_RIGHT)
        char.x += 1
   end

   if Input.key_down?(K_UP)
        char.y -= 1
   end
   if Input.key_down?(K_DOWN)
        char.y += 1
   end
  char.draw


 #ジャンプ
  if Input.key_push?(K_SPACE) and jump_ok
    f = -20
  end

  #Ｙ軸移動増分の設定
  y_move = (char.y - y_prev) + f
  #座標増分が１ブロックを超えないように補正
  if y_move > 31
    y_move = 31
  end
  y_prev = char.y
  char.y += y_move
  f = 2 #f値を初期化し直す

  #穴に落ちたら座標を初期化

  if char.y >= 480
    char.x = 32
    char.y = y_prev = 0

  if y >= 480


    life -=1

    sound_effect1.play#サウンド

    x = 32
    y = y_prev = 0
  end
  
  #天井衝突判定
  if (collision_tile(x   , y, @map) == 1 or 
      collision_tile(x+31, y, @map) == 1) 
    y = y/32*32 + 32

  end
  
  #スクロール
    for num in 0..(maphight*mapwideth)-1 do
    
        @map_sprites[num].x -= 1
        @map_sprites_cloud[num].x -= 1
        @map_sprites_ground[num].x -= 1
        
        #クリア時
        if @map_sprites_cloud[num].x <=-900
            #exit
            Window.draw_font(100, 100, "CONGRATULATIONS!!!!!", font)
        end


    end

  #壁衝突判定（左側）
  if collision_tile(x, y   , @map) == 1 or 
     collision_tile(x, y+31, @map) == 1
    x = x/32*32 + 32
  end
  #壁衝突判定（右側）
  if collision_tile(x+31, y   , @map) == 1 or 
     collision_tile(x+31, y+31, @map) == 1 
    x = x/32*32
  end


  #2段ジャンプ
  if Input.key_push?(K_SPACE)
  #ジャンプ1
    if jump_ok1 and jump_count >0
      f = -15
    end
  
  #ジャンプ2
    if jump_ok2 and jump_count >0
      f = -10
    end
    jump_count -=1


  end
  
  
  


end