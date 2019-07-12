module Mechanics
  def has_name
    define_method('name') { instance_variable_get("@name") }
    define_method('name=') { |val| instance_variable_set("@name", val)}
  end

  def has_hp
    define_method('hp_to_max') do
      instance_variable_set("@hp", instance_variable_get("@total_hp"))
    end
    define_method('total_hp') { instance_variable_get("@total_hp") }
    define_method('hp') { instance_variable_get("@hp") }
    define_method('total_hp=') { |amount| instance_variable_set("@total_hp", amount) }
    define_method('take_damage') do |damage|
      if damage > instance_variable_get("@hp")
        instance_variable_set("@hp", 0)
      else
        instance_variable_set("@hp", (instance_variable_get("@hp") - damage))
      end
    end
    define_method('mortal?') { true }
    define_method('dead?') do
      instance_variable_get("@hp") == 0 ? true : false
    end
  end

  def is_immortal
    define_method('mortal?') { false }
  end

  def can_attack
    define_method('attack_damage') { instance_variable_get("@attack_damage") }
    define_method('attack_damage=') { |val| instance_variable_set("@attack_damage", val) }
    define_method('attack') do |opponent|
      opponent.take_damage self.attack_damage if opponent.mortal?
    end
  end

  def error_rescue
    define_method('method_missing') do |m, args = nil|
      nil
    end
  end

  def can_sing
    define_method('sing') do
      d20 = rand(1..20)
      case d20
      when 1
        "Все смеются над вашим ужасным пением"
      when 1..7
        "Вы плохо поете"
      when 7..14
        "Вы нормально спели"
      when 14..19
        "Вы хорошо спели!"
      when 20
        self.money = self.money + 100
        "Вы заворожили всю толпу своим пением и получаете 100з"
      end
    end
  end

  def has_money
    define_method('money') { instance_variable_get('@money') }
    define_method('money=') { |val| instance_variable_set('@money', val) }
  end

  def can_steal
    define_method('steal') do |opponent|
      self.money = self.money + opponent.money
      opponent.money = 0
    end
  end

  def can_heal
    define_method('heal_power') { instance_variable_get("@heal_power") }
    define_method('heal_power=') { |val| instance_variable_set("@heal_power", val) }
    define_method('heal') do |ally|
      if (ally.hp + self.heal_power) > ally.total_hp
        ally.hp_to_max unless ally.dead? || ally.immortal?
      else
        ally.hp = ally.hp + self.heal_power unless ally.dead? || ally.immortal?
      end
    end
    define_method('revive') do |ally|
      ally.hp_to_max if ally.dead?
    end
  end

  def can_buff
    define_method('buff_attack') do |ally|
      ally.attack_damage = ally.attack_damage + (ally.attack_damage / 2)
    end
  end
end
