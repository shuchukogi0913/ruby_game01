require "dxruby"

#マップデータ
@map = [[1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 1],
        [1, 0, 0, 1, 1, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 1],
        [1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 1],
        [1, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 1],
        [1, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 1],
        [1, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1],
        [1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1],
        [1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1],
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
sound_effect = Sound.new('se_jump_001.wav')

#初期値設定
x = 32
y = y_prev = 32
f = 2
jump_ok = false

#対応する配列を返す
def collision_tile(x, y, arr)
  return arr[y/32][x/32] #マップ配列の仕様上、ｘとｙが逆になっているのに注意
end

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
  f = 2 #f値を初期化し直す

  #穴に落ちたら座標を初期化
  if y >= 480
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
    jump_ok = true #地面に接地しているのでジャンプを許可する
  else
    jump_ok = false #地面に接地していないので、ジャンプは許可しない
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

  #ジャンプ
  if Input.key_push?(K_SPACE) and jump_ok
    f = -20
    sound_effect.play
  end
  
  
  

  #マップの表示
  Window.draw_tile(0,0,@map,@map_tile,0,0,17,15)

  #キャラの表示
  Window.draw(x, y, @char_tile)

end