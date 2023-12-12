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

  def judge_score
    if @hole_par.between?(3, 5) == false || @player_score < 1
      '不正な入力です。'
    end
    case @player_score - @hole_par
    when -4
      'コンドル'
    when -3
      case @hole_par
      when Regulation::LONG
        'アルバトロス'
      when Regulation::MIDDLE
        'ホールインワン'
      end
    when -2
      case @hole_par
      when Regulation::LONG, Regulation::MIDDLE
        'イーグル'
      when Regulation::SHORT
        'ホールインワン'
      end
    when -1
      'バーディ'
    when 0
      'パー'
    when 1
      'ボギー'
    else
      "#{@player_score - @hole_par}ボギー"
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
  evaluated_one_round_score << golf_score_counter.judge_score
end

p evaluated_one_round_score.join(',')
