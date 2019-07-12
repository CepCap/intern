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
    readfile('perfomance') do |f|
      f.readlines.each do |line|
        if line.match?(/#{id}\)/)
          pos_in_rating = line.match(/^\d+/).to_s
          median = line.match(/: (.+)$/)[1].to_f
          break
        end
      end
    end
    subject_medians = {}
    @students[id].each do |subj, med|
      next if subj == :name
      subject_medians[subj]= find_median(med)
    end
    { student: @students[id], median: median, position: pos_in_rating,
      subject_medians: subject_medians, status: check_status(median) }
  end

  def marks_by_subject(id, subject)
    @students[id][subject]
  end

  def statistics
    stat = { two: 0, three: 0, four: 0, five: 0 }
    readfile('perfomance') do |f|
      f.readlines.each do |line|
        median = line.match(/: (\d.\d+)$/)[1].to_f
        stat[check_status(median)] += 1
      end
    end
    stat
  end

  def statistics_by_subject(subject)
    stat = { two: 0, three: 0, four: 0, five: 0 }
    @students.each do |id, student|
      median = find_median(student[subject].map(&:to_i))
      stat[check_status(median)] += 1
    end
    stat
  end

  def five(best)
    result = []
    best ? range = (-5..-1) : range = (0..4)
    readfile('perfomance') do |f|
      f.readlines[range].each do |line|
        result << line.match(/\d. (.+):/)[1]
      end
    end
    result
  end

  private

  def check_status(median)
    if median < 3
      :two
    elsif median > 3 && median < 4
      :three
    elsif median > 4 && median < 4.8
      :four
    elsif median > 4.8
      :five
    end
  end
end
