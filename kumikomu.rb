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