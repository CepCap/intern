module Mechanics
  def has_name
    define_method('name') { instance_variable_get("@name") }
    define_method('name=') { |val| instance_variable_set("@name", val)}
  end

  def has_hp
    define_method('hp_to_max') do
      instance_variable_set("@hp", instance_variable_get("@total_hp"))
    end
    define_method('full_hp?') do
      instance_variable_get("@total_hp") == instance_variable_get("@hp")
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
      instance_variable_get("@hp").zero? ? true : false
    end
  end

  def has_mana
    define_method('mana') { instance_variable_get("@mana") }
    define_method('mana=') { |val| instance_variable_set("@mana", val) }
  end

  def is_immortal
    define_method('mortal?') { false }
  end

  def can_attack
    define_method('can_attack?') { true }
    define_method('add_damage') { instance_variable_get('@add_damage') }
    define_method('add_damage=') do |val|
      instance_variable_set('@add_damage', val)
    end
    define_method('total_damage') do
      instance_variable_get('@attack_damage') + instance_variable_get('@add_damage')
    end
    define_method('attack_damage') { instance_variable_get("@attack_damage") }
    define_method('attack_damage=') { |val| instance_variable_set("@attack_damage", val) }
    define_method('crit_multiplier') { instance_variable_get("@crit_multiplier") }
    define_method('crit_multiplier=') do |val|
      instance_variable_set("@crit_multiplier", val)
    end
    define_method('attack') do |opponent|
      damage = 0
      if opponent.mortal? && !self.dead?
        case rand(1..20)
        when 1
          damage = :miss
        when 2..19
          damage = self.total_damage
          opponent.take_damage damage
        when 20
          damage = self.total_damage * self.crit_multiplier
          opponent.take_damage damage
        end
      end
      damage
    end
  end

  def error_rescue
    define_method('method_missing') do |m, args = nil|
      false
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
    define_method('can_heal?') { true }
    define_method('heal_power') { instance_variable_get("@heal_power") }
    define_method('heal_power=') { |val| instance_variable_set("@heal_power", val) }
    define_method('heal_manacost') { instance_variable_get("@heal_manacost") }
    define_method('heal_manacost=') do |val|
      instance_variable_set("@heal_manacost", val)
    end
    define_method('check_for_heal') do |party|
      low_hp_ally = party.find { |member| member.full_hp? == false }
      self.heal low_hp_ally
      [low_hp_ally, self.heal_power]
    end
    define_method('heal') do |ally|
      if self.mana >= self.heal_manacost
        if (ally.hp + self.heal_power) > ally.total_hp
          ally.hp_to_max unless ally.dead? || ally.immortal?
        else
          ally.hp = ally.hp + self.heal_power unless ally.dead? || ally.immortal?
        end
        self.mana = self.mana - self.heal_manacost
      end
      ally
    end
    define_method('revive') do |ally|
      ally.hp_to_max if ally.dead?
    end
  end

  def can_be_buffed
    define_method('buffed?') { instance_variable_get('@buffed') }
    define_method('buffed=') { |val| instance_variable_set('@buffed', val) }
    define_method('buff_duration') { instance_variable_get('@buff_duration') }
    define_method('buff_duration=') { |val| instance_variable_set('@buff_duration', val) }
    define_method('buff_tick') do
      if self.buff_duration.zero?
        self.buffed = false
      else
        self.buff_duration = (self.buff_duration - 1)
      end
    end
  end

  def can_buff
    define_method('can_buff?') { true }
    define_method('buff_manacost') { instance_variable_get('@buff_manacost') }
    define_method('buff_manacost=') do |val|
      instance_variable_set('@buff_manacost', val)
    end
    define_method('check_for_buff') do |party|
      unbuffed = party.find do |member|
        member.buffed? == false && member.dead? == false
      end
      self.attack_buff(unbuffed)
      unbuffed.buffed = true
      unbuffed.buff_duration = instance_variable_get('@attack_buff_duration')
      unbuffed
    end
    define_method('attack_buff_duration') do
      instance_variable_get('@attack_buff_duration')
    end
    define_method('attack_buff_duration=') do |val|
      instance_variable_set('@attack_buff_duration', val)
    end
    define_method('attack_buff') do |ally|
      if self.mana >= self.buff_manacost && !ally.dead?
        ally.add_damage = (ally.attack_damage / 2)
        self.mana = self.mana - self.buff_manacost
      end
    end
  end
end
