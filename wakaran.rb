require "dxruby"

#マップデータ
@map = [[1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0],
        [1, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0],
        [1, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0],
        [1, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0],
        [1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0],
        [1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0],
        [1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0],
        [1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 0, 1, 1, 0, 1, 1],
        [1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 0, 1, 1, 0, 1, 1]]

#配置パーツ
@map_tile = []
@map_tile[0] = Image.new(32, 32, [0x00,0x99,0xff]) #背景１（空）
@map_tile[1] = Image.new(32, 32, [0x66,0x33,0x00]) #障害物（ブロック）
@map_tile[2] = Image.new(32, 32, [0xff,0xff,0xff]) #背景２（雲）

#キャラ

@char_tile = Image.load('gori.png')
@char_tile.set_color_key(C_WHITE)
#フレーム数設定
Window.fps = 30
#サウンド
#sound_effect = Sound.new('se_jump_001.wav')#ジャンプ
#sound_effect1 = Sound.new('se_powerdown_007.wav')#落下時


#初期値設定
x = 32
y = y_prev = 0
f = 2
jump_ok1 = false
jump_ok2 = false

#対応する配列を返す
def collision_tile(x, y, arr)
    return arr[y/32][x/32] #マップ配列の仕様上、ｘとｙが逆になっているのに注意
end

jump_count = 2  #ジャンプした回数をカウント
font = Font.new(32)  #フォントの設定
life=2  #LIFEの初期化

#ゲームループ
Window.loop do
  
  #Ｙ軸移動増分の設定
  y_move = (y - y_prev) + f
  #座標増分が１ブロックを超えないように補正
  if y_move > 31
    y_move = 31
  end
  y_prev = y
  y += y_move
  f = 1 #f値を初期化し直す

  #穴に落ちたら座標を初期化
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
  
  #床衝突判定
  if collision_tile(x   , y+31, @map) == 1 or 
     collision_tile(x+31, y+31, @map) == 1
    y = y/32*32
    jump_count = 2 #地面に接地したら初期化
    jump_ok1 = true #地面に接地しているのでジャンプを許可する
    jump_ok2 = false#地面に接地していないので、2段ジャンプ
  else
    jump_ok1 = false #地面に接地していないので、ジャンプ不可
    jump_ok2 = true #地面に接地していないので、2段ジャンプ
  end

  #左右移動
  x += Input.x * 2

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
  
  
  

  #マップの表示
  Window.draw_tile(0,0,@map,@map_tile,0,0,17,15)

  #キャラの表示
  if life > 0  #lifeが0になったら非表示
  Window.draw(x, y, @char_tile)
  end

  #LIFEの表示
  Window.draw_font(32,0,"LIFE×#{life}", font)

  #ゲームオーバー画面
  if life==0
    Window.draw_font(100, 100, "GAME OVER! Push space to retry.", font)
    if Input.key_push?(K_SPACE)
      life = 2
      x = 32
      y = y_prev = 0
    end
  end

end