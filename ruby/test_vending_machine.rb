require 'minitest/autorun'
require_relative 'vending_machine'

class SuicaTest < Minitest::Test
  def test_suica_default_deposit
    suica = Suica.new
    assert_equal 500, suica.deposit
  end
  def test_suica_charge_success
    suica = Suica.new
    assert_equal 700, suica.charge(200)
  end
  def test_suica_charge_fail
    suica = Suica.new
    assert_raises(RuntimeError) do
      suica.charge(80)
    end
  end
  def test_suica_deposit
    suica = Suica.new
    suica.charge(400)
    assert_equal 900, suica.deposit
  end
end

class VendingMachineTest < Minitest::Test

  def test_get_stock
    pepsi = Drink.new('pepsi', 150)
    vending_machine = VendingMachine.new
    vending_machine.add_drink(pepsi, 5)
    assert_equal 5, vending_machine.get_stock(pepsi)
  end

  def test_drink_list
    pepsi = Drink.new('pepsi', 150)
    monster = Drink.new('monster', 230)
    vending_machine = VendingMachine.new
    vending_machine.add_drink(pepsi, 5)
    vending_machine.add_drink(monster, 10)
    assert_equal true, vending_machine.list_drinks.include?('pepsi') && vending_machine.list_drinks.include?('monster')
  end

  def test_add_stock
    pepsi = Drink.new('pepsi', 150)
    vending_machine = VendingMachine.new
    vending_machine.add_drink(pepsi, 5)
    vending_machine.add_stock(pepsi, 2)
    assert_equal 7, vending_machine.get_stock(pepsi)
  end

  def test_enough_deposit
    suica = Suica.new
    pepsi = Drink.new('pepsi', 150)
    vending_machine = VendingMachine.new
    vending_machine.add_drink(pepsi, 5)

    assert_equal true, vending_machine.is_enough_deposit(pepsi, suica)
  end

  def test_decrease_stock
    pepsi = Drink.new('pepsi', 150)
    vending_machine = VendingMachine.new
    vending_machine.add_drink(pepsi, 5)
    assert_equal 4, vending_machine.decrease_stock(pepsi)
  end

  def test_subtract_deposit
    suica = Suica.new
    pepsi = Drink.new('pepsi', 150)
    vending_machine = VendingMachine.new
    vending_machine.add_drink(pepsi, 5)
    assert_equal 350, vending_machine.subtract_suica_deposit(pepsi, suica)
  end

  def test_sale_drink
    suica = Suica.new
    pepsi = Drink.new('pepsi', 150)
    monster = Drink.new('monster', 230)
    irohas = Drink.new('irohas', 120)
    vending_machine = VendingMachine.new
    vending_machine.add_drink(pepsi, 5)
    vending_machine.add_drink(monster, 5)
    vending_machine.add_drink(irohas, 5)
    vending_machine.sale_drink(pepsi, suica)
    vending_machine.sale_drink(monster, suica)
    vending_machine.sale_drink(irohas, suica)
    assert_equal 0, suica.deposit
    assert_equal 500, vending_machine.get_sales_amount
  end

  def test_no_stock_sale_drink
    suica = Suica.new
    pepsi = Drink.new('pepsi', 100)
    vending_machine = VendingMachine.new
    vending_machine.add_drink(pepsi, 3)
    vending_machine.sale_drink(pepsi, suica)
    vending_machine.sale_drink(pepsi, suica)
    vending_machine.sale_drink(pepsi, suica)
    assert_raises(NoStock) do
      vending_machine.sale_drink(pepsi, suica)
    end
  end

  def test_no_deposit_sale_drink
    suica = Suica.new
    pepsi = Drink.new('pepsi', 200)
    vending_machine = VendingMachine.new
    vending_machine.add_drink(pepsi, 5)
    vending_machine.sale_drink(pepsi, suica)
    vending_machine.sale_drink(pepsi, suica)
    assert_raises(NotEnoughDeposit) do
      vending_machine.sale_drink(pepsi, suica)
    end
  end

end
