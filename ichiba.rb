require 'dxruby'

# マップデータ
@map = [[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0,0,0,0,0,0,0,0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0,0,0,0,0,0,0,0,0],
        [0, 0, 0, 1, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0,0,0,0,0,0,0,0,0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0,0,0,0,0,0,0,0],
        [0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0,0,0,0,0,0,0,0,0],
        [0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0,0,0,0,0,0,0,0,0],
        [0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0,0,0,0,0,0,0,0,0],
        [0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0,0,0,0,0,0,0,0,0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0,0,0,0,0,1,0,0,0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0,1,0,0,0,0,0,0,0],
        [0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0,0,0,0,0,0,0,0,0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0,0,0,0,0,0,0,0,0],
        [0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0,0,0,0,0,0,0,0,0],
        [0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0,0,0,0,0,0,0,0,0],
        [1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0,0,0,1,0,0,1,1,1],
        [1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0,0,0,1,0,0,1,1,1]]

        maphight=26
        mapwideth=16

# スプライトの配列
#空
@map_sprites = []

for map_y in 0..15 do
  for map_x in 0..25 do
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
@map_sprites_ground = []

for map_y in 0..15 do
  for map_x in 0..25 do
    case @map[map_y][map_x]
    
    when 1
      image = Image.new(32, 32, [0x66,0x33,0x00])  #地面
    else
        image=nil
    end
    @map_sprites_ground.push(Sprite.new(map_x * 32, map_y * 32, image))
  end
end

#雲
@map_sprites_cloud = []

for map_y in 0..15 do
  for map_x in 0..25 do
    case @map[map_y][map_x]

    when 2
      image = Image.new(32, 32, [0xff, 0xff, 0xff])  #雲
    else
        image=nil
    end
    @map_sprites_cloud.push(ground=Sprite.new(map_x * 32, map_y * 32, image))
  end
end


#キャラ
#@char_tile = Image.new(32, 32, C_RED)
#初期値設定

x = 32
y = y_prev = 32
f = 2
jump_ok = false
speed=2
last_char_x=x
last_char_y=y




image_char = Image.new(32, 32, C_GREEN)
char = Sprite.new(x, y, image_char)



Window.loop do
  
  # マップの表示
  @map_sprites.each { |sprite| sprite.draw }
  @map_sprites_cloud.each { |sprite| sprite.draw }
  @map_sprites_ground.each { |sprite| sprite.draw }

  #操作
  if Input.key_down?(K_LEFT)
    char.x -= 1*speed
    for num in 0..(maphight*mapwideth)-1 do
      if char === @map_sprites_ground[num]
        char.x = last_char_x
      end
    end
    
  end

 if Input.key_down?(K_RIGHT)
    char.x += 1*speed
    for num in 0..(maphight*mapwideth)-1 do
      if char === @map_sprites_ground[num]
        char.x = last_char_x
      end
    end

 end

   /if Input.key_down?(K_UP)
       char.y -= 1
      end
   if Input.key_down?(K_DOWN)
     char.y += 1
   end/


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



 #地面判定
  for num in 0..(maphight*mapwideth)-1 do
    if char === @map_sprites_ground[num]
      
          char.y = last_char_y
          
          jump_ok = true #地面に接地しているのでジャンプを許可する
          dx= char.x-last_char_x   
          dy= char.y-last_char_y
          
    else
     　　jump_ok = false #地面に接地していないので、ジャンプは許可しない
    end
   end



          for num in 0..(maphight*mapwideth)-1 do

            

              #左から衝突

              /if char.x < @map_sprites_ground[num].x and char.y == @map_sprites_ground[num].y and  char === @map_sprites_ground[num]
                char.x = @map_sprites_ground[num].x-16
              end
            
             #右から衝突
            
              if char.x > @map_sprites_ground[num].x and char.y == @map_sprites_ground[num].y and  char === @map_sprites_ground[num]
                char.x = @map_sprites_ground[num].x+16
              end/
    
             /#地面
            
             if char.x == @map_sprites_ground[num].x

              #if char.y < @map_sprites_ground[num].y   
              if char === @map_sprites_ground[num]
                char.y = @map_sprites_ground[num].y-16
              end
            
             #天井
            
              if char.y > @map_sprites_ground[num].y 
                char.y = @map_sprites_ground[num].y+16
              end
             end/

            end
          

    
      
   
   #スクロール
    for num in 0..(maphight*mapwideth)-1 do
    
     @map_sprites[num].x -= 0.5
     @map_sprites_cloud[num].x -= 0.5
     @map_sprites_ground[num].x -= 0.5
    
      #穴に落ちたら座標を初期化
      if char.y >= 480
        char.x = 32
        char.y = y_prev = 32
       
        exit
        
      end
           #クリア時
           if @map_sprites_cloud[num].x <=-700
            font = Font.new(32)
            Window.draw_font(100, 100, "CONGRATULATIONS!!!!!", font)

            if @map_sprites_cloud[num].x <=-750
             # exit
            end
        end

    
   end

   char.draw

   last_char_x=char.x
   last_char_y=char.y
   end