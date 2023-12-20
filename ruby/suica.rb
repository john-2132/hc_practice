# 残高を持つ
class Suica
  attr_reader :deposit
  private attr_writer :deposit

  def initialize
    @deposit = 500
  end

  # 残高チャージ
  def charge(price)
    if price < 100
      raise '最小チャージ額は100円です。'
    end
    self.deposit += price
  end

  # 支払い
  def pay(price)
    self.deposit -= price
  end
  
end
