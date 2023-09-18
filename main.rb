require 'dxruby'

require_relative 'player'
require_relative 'enemy'

font = Font.new(32)
player_img = Image.load("image/player.png")
enemy_img = Image.load("image/enemy.png")

player = Player.new(100, 100, player_img)
enemies = []
10.times do
  enemies << Enemy.new(rand(0..(640 - 32 - 1)), rand((480 - 32 - 1)), enemy_img)
end

timer = 600 + 60 # 追加

Window.loop do
  if timer >= 60 # 追加
    timer -= 1 # 追加
    player.update
  end

  player.draw

  Sprite.draw(enemies)
  Window.draw_font(10, 0, "スコア：#{player.score}", font)
  Window.draw_font(10, 32, "残り時間：#{timer / 60}秒", font) # 追加

  Sprite.check(player, enemies)
end