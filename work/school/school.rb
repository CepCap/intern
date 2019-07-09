require_relative 'schooldb'
require_relative 'schoolhelper'

class School
  include SchoolHelper

  attr_accessor :subjects, :students

  def initialize
    school_db = SchoolDB.new
    @subjects = school_db.subjects
    @students = school_db.students
  end

  def show_student(id)
    median = 0
    pos_in_rating = ''
    File.open('perfomance', 'r') do |f|
      begin
        while line = f.readline
          if line.match?(/#{id}\)/)
            pos_in_rating = line.match(/^\d+/).to_s
            median = line.match(/: (.+)$/)[1].to_f
            break
          end
        end
      rescue EOFError
        median = 'not found'
      end
    end
    p median
    subject_medians = {}
    @students[id].each do |subj, med|
      next if subj == :name
      subject_medians[subj]= find_median(med)
    end
    stat = ''
    female = (@students[id][:name][-1] == 'а')
    if median < 3
      female ? stat = 'двоечницы' : stat = 'двоечник'
    elsif median > 3 && median < 4
      female ? stat = 'троечница' : stat = 'троечник'
    elsif median > 4 && median < 4.8
      female ? stat = 'хорошистка' : stat = 'хорошист'
    elsif median > 4.8
      female ? stat = 'отличница' : stat = 'отличник'
    end
    { student: @students[id], median: median, position: pos_in_rating,
      subject_medians: subject_medians, status: stat }
  end

  def marks_by_subject(id, subject)
    @students[id][subject]
  end

  def statistics
    stat = { двоечники: 0, троечники: 0, хорошисты: 0, отличники: 0 }
    File.open('perfomance', 'r') do |f|
      begin
        while line = f.readline
          median = line.match(/: (.+)$/)[1].to_f
          if median < 3
            stat[:двоечники] += 1
          elsif median > 3 && median < 4
            stat[:троечники] += 1
          elsif median > 4 && median < 4.8
            stat[:хорошисты] += 1
          elsif median > 4.8
            stat[:отличники] += 1
          end
        end
      rescue EOFError
      end
    end
    stat
  end

  def statistics_by_subject(subject)
    stat = { двоечники: 0, троечники: 0, хорошисты: 0, отличники: 0 }
    @students.each do |id, student|
      median = find_median(student[subject])
      if median < 3
        stat[:двоечники] += 1
      elsif median > 3 && median < 4
        stat[:троечники] += 1
      elsif median > 4 && median < 4.8
        stat[:хорошисты] += 1
      elsif median > 4.8
        stat[:отличники] += 1
      end
    end
    stat
  end

  def five(best)
    top = []
    best ? range = (-5..-1) : range = (0..4)
    File.open('perfomance', 'r') do |f|
      lines = f.readlines
      lines[range].each do |line|
        top << line.match(/\d. (.+):/)[1]
      end
    end
    top
  end
  #
  # private
  #
  # def find_median(array)
  #   (array.sum.to_f / array.length.to_f).round(2)
  # end
end
