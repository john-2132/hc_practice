# 規定打数の種類
module Regulation
  SHORT = 3  # ショートホール
  MIDDLE = 4 # ミドルホール
  LONG = 5   # ロングホール
end

# ゴルフスコアの評価を行う
class GolfScoreCounter
  def initialize(hole_par, player_score)
    @hole_par = hole_par.to_i
    @player_score = player_score.to_i
  end

  # 規定打数によって評価方法を振り分ける
  def judge_hole
    case @hole_par
    when Regulation::LONG
      long_hole_counter
    when Regulation::MIDDLE
      middle_hole_counter
    when Regulation::SHORT
      short_hole_counter
    else
      '不正な規定打数'
    end
  end

  # ロングホールのスコア評価
  def long_hole_counter
    case @player_score - @hole_par
    when -4
      'コンドル'
    when -3
      'アルバトロス'
    when -2
      'イーグル'
    when -1
      'バーディ'
    when 0
      'パー'
    else
      bogey = @player_score - @hole_par == 1 ? '' : @player_score - @hole_par
      "#{bogey}ボギー"
    end
  end

  # ミドルホールのスコア評価
  def middle_hole_counter
    case @player_score - @hole_par
    when -3
      'ホールインワン'
    when -2
      'イーグル'
    when -1
      'バーディ'
    when 0
      'パー'
    else
      bogey = @player_score - @hole_par == 1 ? '' : @player_score - @hole_par
      "#{bogey}ボギー"
    end
  end

  # ショートホールのスコア評価
  def short_hole_counter
    case @player_score - @hole_par
    when -2
      'ホールインワン'
    when -1
      'バーディ'
    when 0
      'パー'
    else
      bogey = @player_score - @hole_par == 1 ? '' : @player_score - @hole_par
      "#{bogey}ボギー"
    end
  end
end

# [[１８ホールの規定打数], [１８ホールのプレイヤーの打数]]に変換
one_round_score = []
while str = gets
  one_round_score << str.chomp.split(',').map(&:to_i)
end

# 行列を入れ替え、[[1ホールの規定打数], [1ホールのプレイヤーの打数]...]へ変換
every_one_hole_score = one_round_score.transpose

# 1ラウンドのスコア評価後の格納先
evaluated_one_round_score = []

# １ホール毎に規定打数に対してのプレイヤーの打数を評価する
every_one_hole_score.each do |hole_par, player_score|
  golf_score_counter = GolfScoreCounter.new(hole_par, player_score)
  evaluated_one_round_score << golf_score_counter.judge_hole
end

p evaluated_one_round_score.join(',')
