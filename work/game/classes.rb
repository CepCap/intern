require_relative 'mechanics'

class Warrior
  extend Mechanics
  has_name
  has_hp
  can_attack
  has_money
  error_rescue

  def initialize
    self.total_hp = 100
    self.hp_to_max
    self.attack_damage = 10
    self.money = 50
  end
end

class Bard
  extend Mechanics
  has_name
  has_hp
  has_money
  can_attack
  can_buff
  can_sing
  error_rescue

  def initialize
    self.total_hp = 80
    self.hp_to_max
    self.attack_damage = 5
    self.money = 200
  end
end

class Immortal
  extend Mechanics
  has_name
  is_immortal
  can_attack
  error_rescue

  def initialize
    self.attack_damage = 100
  end
end

class Priest
  extend Mechanics
  has_name
  has_hp
  has_money
  can_attack
  can_heal
  error_rescue

  def initialize
    self.total_hp = 60
    self.hp_to_max
    self.attack_damage = 5
    self.money = 10
    self.heal_power = 20
  end
end

class Thief
  extend Mechanics
  has_hp
  has_money
  can_attack
  can_steal
  error_rescue

  def initialize
    self.total_hp = 60
    self.hp_to_max
    self.attack_damage = 20
    self.money = 200
  end
end
