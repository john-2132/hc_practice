# RubyにInterfaceはないので擬似的に作成
module Interface
  def getName
    raise NotImplementedError, 'Subclass must implement getName method'
  end

  def changeName
    raise NotImplementedError, 'Subclass must implement changeName method'
  end

  def interface
    raise NotImplementedError, 'Subclass must implement interface method'
  end
end

# RubyにAbstractはないので擬似的に作成
class AbstractClass
  def abstract
    raise NotImplementedError, 'Subclass must implement abstract method'
  end
end

class Pokemon < AbstractClass
  include Interface
  private attr_accessor :name, :type1, :type2, :hp, :mp

  def initialize(name, type1, type2, hp)
    @name = name
    @type1 = type1
    @type2 = type2
    @hp = hp
    @mp = 10
  end

  def attack()
    raise NotImplementedError, 'Subclass must implement attack method'
  end

  def changeName(new_name)
    if new_name == '新羅'
      p '不適切な名前です'
      return
    end
    @name = new_name
  end

  def getName
    @name
  end
end
