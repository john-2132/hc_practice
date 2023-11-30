# グループのメンバー
members = ['A', 'B', 'C', 'D', 'E', 'F']

# 第一グループをランダムに２〜４人で作る
first_group = members.sample(rand(2..4)).sort

# 第一グループ、第二グループ（全体から第一グループを抜く）を出力
p first_group, members - first_group
