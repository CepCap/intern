require_relative 'schoolhelper'

class SchoolDB
  include SchoolHelper

  attr_reader :subjects, :students
  attr_accessor :students_file

  def initialize
    @subjects = ['русский', 'математика', 'английский', 'программирование', 'естествознание']
    @students_file = 'students'
    @students = {}
    generate
  end

  def perfomance_rating
    rating = {}
    @students.each do |id, student|
      total_median = []
      student.each do |lesson, marks|
        next if lesson == :name
        total_median << find_median(marks)
      end
      total_median = find_median(total_median)
      rating[id]= {name: student[:name], median: total_median}
    end
    p rating
    rating = rating.sort_by { |name, median| median[:median] }.to_h
    iterator = 1
    File.open('perfomance', 'wb') do |f|
      rating.each do |id, hash|
        line = "#{iterator}. #{id}) #{hash[:name]}: #{hash[:median]}"
        f.puts line
        iterator += 1
      end
    end
  end

  def load_students
    @subjects.each do |subj|
      File.open(subj, 'r') do |f|
        begin
          while line = f.readline
            id_and_name = line.split(':  ').first
            id, name = id_and_name.split(') ').first.to_i, id_and_name.split(') ').last
            marks = line.split(':  ').last
            @students[id] ||= {}
            @students[id][:name] ||= name
            @students[id][subj] = marks.split(' ').map(&:to_i)
          end
        rescue EOFError
        end
      end
    end
    @students
  end

  def generate_students
    male_names = [ 'Иван', 'Сергей', 'Михаил', 'Валентин' ]
    female_names = [ 'Мария', 'Елена', 'Екатерина', 'Юлия' ]
    surnames = ['Иванов', 'Петров', 'Сидоров', 'Кузнецов']
    index = 1
    File.open(@students_file, 'wb') do |f|
      f.puts "Школа номер #{rand(1000..2000)}"
      f.puts "Учитель #{male_names.sample} Петрович #{surnames.sample}\n\n\n"
      15.times do |i|
        f.puts "#{index}) " + male_names.sample + ' ' + surnames.sample
        index += 1
        f.puts "#{index}) " + female_names.sample + ' ' + surnames.sample + 'а'
        index += 1
      end
      same_surname = surnames.sample
      same_female_surname = surnames.sample + 'а'
      2.times do |i|
        f.puts "#{index}) " + male_names.sample + ' ' + same_surname
        index += 1
        f.puts "#{index}) " + female_names.sample + ' ' + same_female_surname
        index += 1
      end
      f.puts "#{index}) " + male_names.sample + ' ' + surnames.sample
    end
  end

  def generate_marks
    students = []
    File.open(@students_file, 'r') do |f|
      students = f.readlines("\n").drop(4)
    end

    subjects.each do |subj|
      File.open(subj, 'wb') do |f|
        students.each do |student|
          f.puts student.chomp + ': ' + rand_marks
        end
      end
    end
  end

  def rand_marks
    marks = ''
    generator = [(2..3), (2..5), (4..5)]
    80.times { marks += " #{rand(generator.sample)}" }
    marks
  end

  def generate
    generate_students
    generate_marks
    load_students
    perfomance_rating
  end
end
