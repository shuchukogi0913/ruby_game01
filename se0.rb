require 'dxruby'
# 効果音を読み込む
sound_effect = Sound.new('se_jump_001.wav')
sound_effect = Sound.new('se_powerdown_007.wav')
# メインループ
Window.loop do
  # キーが押されたとき
  if Input.key_push?(K_SPACE)
    # 効果音を再生する
    sound_effect.play
  end

  # ゲームの処理などをここに書く
end