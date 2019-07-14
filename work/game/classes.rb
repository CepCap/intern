require_relative 'mechanics'

class Warrior
  extend Mechanics
  has_name
  has_hp
  can_attack
  has_money
  can_be_buffed
  error_rescue

  def initialize
    self.add_damage = 0
    self.total_hp = 100
    self.hp_to_max
    self.attack_damage = 10
    self.money = 50
    self.crit_multiplier = 2
    self.buffed = false
  end
end

class Bard
  extend Mechanics
  has_name
  has_hp
  has_money
  has_mana
  can_attack
  can_buff
  can_be_buffed
  can_sing
  error_rescue

  def initialize
    self.add_damage = 0
    self.total_hp = 80
    self.hp_to_max
    self.attack_damage = 5
    self.money = 200
    self.crit_multiplier = 1
    self.mana = 100
    self.buff_manacost = 30
    self.buffed = false
    self.attack_buff_duration = 3
  end
end

class Priest
  extend Mechanics
  has_name
  has_hp
  has_money
  has_mana
  can_be_buffed
  can_attack
  can_heal
  error_rescue

  def initialize
    self.add_damage = 0
    self.mana = 200
    self.total_hp = 60
    self.hp_to_max
    self.attack_damage = 5
    self.money = 10
    self.heal_power = 20
    self.heal_manacost = 50
    self.crit_multiplier = 1
    self.buffed = false
  end
end

class Thief
  extend Mechanics
  has_name
  has_hp
  has_money
  can_attack
  can_steal
  can_be_buffed
  error_rescue

  def initialize
    self.add_damage = 0
    self.total_hp = 60
    self.hp_to_max
    self.attack_damage = 20
    self.money = 200
    self.crit_multiplier = 4
    self.buffed = false
  end
end
