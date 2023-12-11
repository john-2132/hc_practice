require 'date'
require 'optparse'

# wdayは日曜始まりに対し、作成したいカレンダーは月曜始まりなので対応させる
# cwdayを使えばこの関数は不要になる
def change_for_monday_start(val_sunday_start)
  val_sunday_start.zero? ? 6 : val_sunday_start - 1
end

# -mオプションがある場合、オプションの引数を取得
input_month = ARGV.getopts('m:')

today = Date.today
# カレンダーは当年のみ
year = today.year

# オプションありの場合は指定月、無しの場合は実行月を取得
month = input_month['m'] ? input_month['m'].to_i : today.month

# 月が有効値でない場合は例外を出す
unless month in 1..12
  raise "#{month} is neither a month number (1..12) nor a name"
end

# 指定月または実行月の一ヶ月を作成
one_month = Date.new(year, month)..Date.new(year, month, -1)

# 最終的なカレンダーの入れ物（月〜日を 0~6 として扱う）
calender = [%w[月 火 水 木 金 土 日]]
# 一週間の入れ物
one_week = []
one_month.map do |day|
  # 対応した曜日の位置に日付を入れる
  # 出力を整えるために１桁日でも2桁日として扱う
  val_day_of_the_week = change_for_monday_start(day.wday)
  one_week[val_day_of_the_week] = format('%2d', Date.parse("#{day}").day)
  # 日曜終わりのカレンダーなので、日曜が来るたびにカレンダーに追加する
  next unless val_day_of_the_week == 6

  # 月初や終わりには日付が割り当てられない曜日がありnilが入るので、
  # スペース２文字に直す（出力を整えるために２文字）
  tmp = one_week.map do |day|
    day.nil? ? '  ' : day
  end
  calender.insert(-1, tmp)
end

# 出来上がったカレンダーの出力
printf("%<month>8d月 %<year>d\n", month: month, year: year)
calender.each do |week|
  week.each do |day|
    printf('%s ', day)
  end
  # 週ごとに改行
  puts
end
