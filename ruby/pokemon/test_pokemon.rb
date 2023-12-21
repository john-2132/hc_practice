require 'minitest/autorun'
require_relative 'pikachu'


class PokemonTest < Minitest::Test
  def test_attack
    pika = Pikachu.new('ピカチュウ', 'でんき', '', 100)
    assert_equal 'ピカチュウの10万ボルト！', pika.attack
  end
  def test_changeName
    pika = Pikachu.new('ピカチュウ', 'でんき', '', 100)
    assert_equal 'ライチュウ', pika.changeName('ライチュウ')
  end
  def test_getName
    pika = Pikachu.new('ピカチュウ', 'でんき', '', 100)
    assert_equal 'ピカチュウ', pika.getName
  end
  def test_interface_defeat
    pika = pika = Pikachu.new('ピカチュウ', 'でんき', '', 100)
    assert_raises(NotImplementedError) do
      pika.interface
    end
  end
  def test_abstract_test
    pika = pika = Pikachu.new('ピカチュウ', 'でんき', '', 100)
    assert_raises(NotImplementedError) do
      pika.abstract
    end
  end
end
