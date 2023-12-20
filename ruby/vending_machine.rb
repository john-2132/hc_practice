require_relative 'drink'

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

#　販売する飲み物のリストと、販売額を持つ
class VendingMachine
  attr_reader :drink_lineup, :sales_amount

  def initialize(*drinks)
    @drink_lineup = drinks
    @sales_amount = 0
  end

  # 飲み物のラインナップへの追加
  def add_drink(*drinks)
    drinks.each { |drink| @drink_lineup.push(drink) }
  end

  # 飲み物の在庫を取得
  def get_stock(drink_name)
    certain_drinks = @drink_lineup.select do |drink|
      drink.name == drink_name
    end
    certain_drinks.length
  end

  # ラインナップの一覧を取得
  def list_drinks
    drinks_name = @drink_lineup.map(&:name).uniq
  end

  # 購入時のsuica残高が足りているか
  def is_enough_deposit(drink_name, suica)
    drink = @drink_lineup.find { |drink| drink.name == drink_name }
    if drink.nil?
      raise NoStock
    suica.deposit >= drink.price
  end

  # 飲み物の在庫を減らす（商品が売れた時）
  def decrease_stock(drink_name)
    drink_index = @drink_lineup.find_index { |drink| drink.name == drink_name}
    if drink_index.nil?
      raise NoStock
    @drink_lineup.delete_at(drink_index)
  end

  # suica残高を減らす（商品が売れた時）
  def subtract_suica_deposit(drink_name, suica)
    drink = @drink_lineup.find { |drink| drink.name == drink_name }
    if drink.nil?
      raise NoStock
    suica.pay(drink.price)
  end

  # 飲み物の販売
  def sale_drink(drink_name, suica)
    if get_stock(drink_name) <= 0
      raise NoStock
    end
    if is_enough_deposit(drink_name, suica) == false
      raise NotEnoughDeposit
    end
    count_sales_amount(drink_name)
    subtract_suica_deposit(drink_name, suica)
    decrease_stock(drink_name)
  end

  private

  #　販売額の計測
  def count_sales_amount(drink_name)
    drink = @drink_lineup.find { |drink| drink.name == drink_name }
    @sales_amount += drink.price
  end
end
