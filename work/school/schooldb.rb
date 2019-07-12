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
      student.drop(1).to_h.each { |lesson, marks| total_median << find_median(marks) }
      rating[id]= { name: student[:name], median: find_median(total_median) }
    end
    rating = rating.sort_by { |name, median| median[:median] }.to_h
    iterator = 0
    writefile('perfomance') do |f|
      rating.each do |id, hash|
        f.puts "#{iterator += 1}. #{id}) #{hash[:name]}: #{hash[:median]}"
      end
    end
  end

  def load_students
    @subjects.each do |subj|
      readfile(subj) do |f|
        f.readlines.each do |line|
          id = line.match(/^(\d+)\)/)[1].to_i
          name = line.match(/\) (.+):/)[1]
          marks = line.match(/(\d )+/).to_s.split(' ').map(&:to_i)
          @students[id] ||= {}
          @students[id][:name] ||= name
          @students[id][subj] = marks
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
    writefile(@students_file) do |f|
      f.puts "Школа номер #{rand(1000..2000)}"
      f.puts "Учитель #{male_names.sample} Петрович #{surnames.sample}\n\n\n"
      35.times do |i|
        i += 1
        if i == 1 || i == 2
          f.puts "#{i}) " + male_names.sample + ' ' + surnames[0]
        elsif i.even?
          f.puts "#{i}) " + male_names.sample + ' ' + surnames.sample
        else
          f.puts "#{i}) " + female_names.sample + ' ' + surnames.sample + 'а'
        end
      end
    end
  end

  def generate_marks
    students = []
    readfile(@students_file) { |f| students = f.readlines.drop(4) }
    subjects.each do |subj|
      writefile(subj) do |f|
        students.each { |student| f.puts student.chomp + ': ' + rand_marks }
      end
    end
  end

  def rand_marks
    generator = [(2..3), (2..5), (4..5)].sample
    Array.new(80).map { |el| el = rand(generator) }.join(' ')
  end

  def generate
    generate_students
    generate_marks
    load_students
    perfomance_rating
  end
end
