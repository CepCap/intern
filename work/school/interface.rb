require_relative 'school'

class Interface
  attr_reader :school
  def initialize
    @school = School.new
  end

  def start
    puts "Здравствуйте!"
    sleep 1
    puts "1. Найти ученика: "
    puts "2. Оценки ученика по предмету"
    puts "3. Статистика"
    puts "4. Статистика по предмету"
    puts "5. Пять лучших учеников"
    puts "6. Пять худших учеников"
    puts "0. Выход"
    input = gets.to_i
    case input
    when 1
      show_student
    when 2
      marks_by_subject
    when 3
      statistics
    when 4
      statistics_by_subject
    when 5
      five(:top)
    when 6
      five(:low)
    else
      exit
    end
  end

  def get_student_id
    puts "Введите порядковый номер ученика: "
    input = gets.to_i
    if input < 0 || input > school.students.length
      puts "Неверное значение."
      start
    end
    input
  end

  def get_subject
    puts "Введите предмет: \n#{school.subjects.join("\n")}"
    gets.downcase.chomp
  end

  def show_student
    input = get_student_id
    show = school.show_student(input)
    subject_medians = show[:subject_medians].to_a.flatten.join(': ')
    puts "\n\nИмя: #{show[:student][:name]}\n"
    puts "Средняя оценка: #{show[:median]}\n\n"
    puts "Средняя оценка по всем предметам:\n#{subject_medians}"
    puts "Место в рейтинге успеваемости: #{show[:position]}"
    puts "#{show[:student][:name]} - #{show[:status].capitalize}\n\n"
    sleep 3
  end

  def marks_by_subject
    id = get_student_id
    subject = get_subject
    student = school.students[id]
    unless student.include? subject
      puts "Неверный предмет"
      start
    end
    puts "Оценки ученика #{student[:name]} по предмету #{subject}:"
    puts "#{student[subject].join(' ')}"
  end

  def statistics
    stats = school.statistics
    stats.each do |status, value|
      puts "#{status.capitalize}: #{value}"
    end
    sleep 3
  end

  def statistics_by_subject
    subject = get_subject
    stats = school.statistics_by_subject(subject)
    stats.each do |status, value|
      puts "#{status.capitalize}: #{value}"
    end
    sleep 3
  end

  def five(best = false)
    puts "#{best ? "Лучшие" : "Худшие"} пять учеников:"
    puts school.five(best).join(" \n")
    sleep 3
  end
end

interface = Interface.new

loop do
  interface.start
end
