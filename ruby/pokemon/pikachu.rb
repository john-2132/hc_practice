require_relative 'pokemon'

class Pikachu < Pokemon
  def initialize(name, type1, type2, hp)
    super
  end

  def attack()
    p "#{@name}の10万ボルト！"
  end
end
