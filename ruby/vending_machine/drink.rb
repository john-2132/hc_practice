# インスタンス毎に飲み物の名前、値段の情報を持つ
class Drink
  attr_reader :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end
end
