# 残高不足時の例外
class NotEnoughDeposit < StandardError
  def initialize(msg="残高が足りません。")
    super
  end
end

# 在庫不足時の例外
class NoStock < StandardError
  def initialize(msg="在庫が足りません。")
    super
  end
end

# インスタンス毎に飲み物の名前、値段の情報を持つ
class Drink
  def initialize(name, price)
    @name = name
    @price = price
  end

  def name
    @name
  end

  def price
    @price
  end
end

#　販売する飲み物のリストと、販売額を持つ
class VendingMachine
  def initialize
    @drink_lineup = {}
    @sales_amount = 0
  end

  # 飲み物のラインナップへの追加
  def add_drink(drink, stock)
    @drink_lineup[drink.name] = {price: drink.price, stock: stock}
  end

  # 飲み物の在庫を取得
  def get_stock(drink)
    @drink_lineup[drink.name][:stock]
  end

  # ラインナップの一覧を取得
  def list_drinks
    @drink_lineup.keys()
  end

  #　飲み物の在庫を追加
  def add_stock(drink, param)
    @drink_lineup[drink.name][:stock] += param
  end

  # 購入時のsuica残高が足りているか
  def is_enough_deposit(drink, suica)
    suica.deposit >= @drink_lineup[drink.name][:price]
  end

  # 飲み物の在庫を減らす（商品が売れた時）
  def decrease_stock(drink)
    @drink_lineup[drink.name][:stock] -= 1
  end

  # suica残高を減らす（商品が売れた時）
  def subtract_suica_deposit(drink, suica)
    suica.pay(@drink_lineup[drink.name][:price])
  end

  #　販売額を取得
  def get_sales_amount
    @sales_amount
  end

  # 飲み物の販売
  def sale_drink(drink, suica)
    if is_enough_deposit(drink, suica) == false
      raise NotEnoughDeposit
    end
    if get_stock(drink) <= 0
      raise NoStock
    end
    decrease_stock(drink)
    count_sales_amount(drink)
    subtract_suica_deposit(drink, suica)
  end

  private

  #　販売額の計測
  def count_sales_amount(drink)
    @sales_amount += @drink_lineup[drink.name][:price]
  end
end

# 残高を持つ
class Suica
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

  # 残高の確認
  def deposit
    @deposit
  end

  private

  def deposit=(value)
    @deposit = value
  end

end
