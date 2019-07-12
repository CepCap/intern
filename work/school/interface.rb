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
    puts "7. Вывести журнал учеников"
    puts "8. Написать письмо родителю"
    puts "9. Выход"
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
      five(best = true)
    when 6
      five
    when 7
      journal
    when 8
      letter
    else
      exit
    end
  end

  def get_student_id
    puts "Введите порядковый номер ученика: "
    puts "Чтобы посмотреть журнал введите '0'"
    input = gets.to_i
    while input > school.students.length
      puts "Неверное значение. Введите снова:"
      puts "Чтобы посмотреть журнал введите '0'"
      input = gets.to_i
    end
    journal if input == 0
    input
  end

  def get_subject
    puts "Выберите предмет:"
    school.subjects.each.with_index do |subj, index|
      puts "#{index+1}) #{subj.capitalize}"
    end
    subject = gets.to_i
    if subject < 1 || subject > school.subjects.length
      puts "Неверное значение"
      get_subject
    end
    school.subjects[subject-1]
  end

  def show_student
    input = get_student_id
    show = school.show_student(input)
    name = show[:student][:name]
    name[-1] == 'a' ? gender = 'female' : gender = 'male'
    subject_medians = show[:subject_medians].to_a.flatten.join(': ')
    stat = check_status(show[:status], arg = gender)
    puts "\n\nИмя: #{show[:student][:name]}\n"
    puts "Средняя оценка: #{show[:median]}\n\n"
    puts "Средняя оценка по всем предметам:\n#{subject_medians}"
    puts "Место в рейтинге успеваемости: #{show[:position]}"
    puts "#{name} - #{stat}\n\n"
    to_menu
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
    marks = student[subject]
    (marks.length / 35).times { |i| marks.insert(35 * (i + 1), "\n" ) }
    puts "#{student[subject].join(' ')}"
    to_menu
  end

  def statistics
    stats = school.statistics
    stats.each { |status, value| puts "#{check_status(status)}: #{value}" }
    to_menu
  end

  def statistics_by_subject
    subject = get_subject
    stats = school.statistics_by_subject(subject)
    stats.each { |status, value| puts "#{check_status(status)}: #{value}" }
    to_menu
  end

  def five(best = false)
    puts "Сортировать по:"
    puts "1) Возрастанию"
    puts "2) Убыванию"
    input = gets.to_i
    puts "#{best ? "Лучшие" : "Худшие"} пять учеников:"
    five_students = school.five(best)
    if input == 1
      puts five_students.map.with_index { |student, index| "#{index+1}. #{student}" }
    elsif input == 2
      puts five_students.reverse.map.with_index { |student, index| "#{5-index}. #{student}" }
    else
      puts "Неверное значение"
      five(best)
    end
    to_menu
  end

  def to_menu
    puts "\nНажмите любую клавишу чтобы вернуться в меню."
    gets
    start
  end

  def journal
    school.students.each { |id, student| puts "#{id}) #{student[:name]}" }
    to_menu
  end

  def letter
    input = get_student_id
    show = school.show_student(input)
    name = show[:student][:name]
    name[-1] == 'a' ? gender = 'female' : gender = 'male'
    subject_medians = show[:subject_medians]
    stat = check_status(show[:status], arg = gender)
    puts "\nУважаемый родитель!"
    if gender ==('male')
      puts("Ваш сын, #{name} - #{stat}")
    else
      puts("Ваша дочь, #{name} - #{stat}")
    end
    subject_medians.each do |lesson, med|
      puts "Средняя оценка по предмету #{lesson}: #{med}"
    end
    to_menu
  end

  private

  def check_status(status, arg = false)
    stat = ''
    if arg == 'female' || arg == 'male'
      case status
      when :two
        arg == 'female' ? stat = "Двоечница" : stat = "Двоечник"
      when :three
        arg == 'female' ? stat = "Троечница" : stat = "Троечник"
      when :four
        arg == 'female' ? stat = "Хорошистка" : stat = "Хорошист"
      when :five
        arg == 'female' ? stat = "Отличница" : stat = "Отличник"
      end
    else
      case status
      when :two
        stat = "Двоечники"
      when :three
        stat = "Троечники"
      when :four
        stat = "Хорошисты"
      when :five
        stat = "Отличники"
      end
    end
    stat
  end
end

interface = Interface.new

loop do
  interface.start
end
