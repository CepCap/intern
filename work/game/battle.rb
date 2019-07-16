require_relative 'classes'

class Battle
  attr_reader :party1, :party2

  def initialize(party1, party2)
    @party1, @party2 = party1, party2
    @won = []
    @battle_end = false
  end

  def round
    puts '-' * 40
    party_hp
    if @battle_end
      battle_ending
      :end
    else
      party_turn(party1, party2)
      party_turn(party2, party1)
    end
  end

  def party_turn(party, opponent_party)
    party.each do |member|
      if member.can_heal?
        if member.mana >= member.heal_manacost
          if party.all? { |member| member.full_hp? }
            attack_party(member, opponent_party)
          else
            result = member.check_for_heal(party)
            puts "\n#{member.name} вылечил #{result.first.name} на #{member.heal_power}"
          end
        else
          attack_party(member, opponent_party)
        end
      elsif member.can_buff?
        if member.mana >= member.buff_manacost
          if party.all? { |member| member.buffed? }
            attack_party(member, opponent_party)
          else
          result = member.check_for_buff(party)
            puts "\n#{member.name} увеличил силу атаки #{result.name}"
          end
        else
          attack_party(member, opponent_party)
        end
      else
        attack_party(member, opponent_party)
      end
    end
  end

  def attack_party(member, party)
    if lives_check(party1, party2)
      @battle_end = true
      return
    end
    unless member.dead?
      opponent = party.find { |man| man.dead? == false }
      result = member.attack opponent
      puts "\n#{member.name} атаковал #{opponent.name} на #{result} урона!"
    end
  end

  def party_hp
    puts 'Party1: HP, AD' + (' ' * 10) + 'Party2: HP, AD'
    lines = Array.new([party1.length, party2.length].max, '')
    party1.each.with_index do |member, index|
      line = "#{member.name}: #{member.hp}, #{member.total_damage}"
      lines[index] = line + (' ' * (24 - line.length))
    end
    party2.each.with_index do |member, index|
      line = "#{member.name}: #{member.hp}, #{member.total_damage}"
      lines[index] += line
    end
    puts lines.join("\n")
  end

  def lives_check(first_party, second_party)
    line = ''
    if first_party.all? { |member| member.dead? }
      second_party.each { |member| line += member.name + ' ' }
      @won = second_party
    elsif second_party.all? { |member| member.dead? }
      first_party.each { |member| line += member.name + ' ' }
      @won = first_party
    end
  end

  def battle_ending
    puts '!' * 40
    puts "#{@won.map(&:name).join(' ')} победили в сражении!"
    puts '!' * 40
  end
end
