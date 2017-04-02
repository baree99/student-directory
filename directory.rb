@students = []

def default(x)
  if !x.empty?
    x
  else
    "Unknown"
  end
end

def default_cohort(m)
  cohort_defaults = %w(january february march april may june july august september october november december)
  m.downcase
  until cohort_defaults.include?(m)
    puts "Please choose from the following months: january, february, march, april, may, june, july, august, september, october, november, december"
    m = gets.chomp
  end
  m
end

def plural
  if @students.count > 1
     's'
  end
end

def students_array(name, hobby, country_of_birth, height, cohort)
  @students << {
    name: default(name),
    hobby: default(hobby),
    country_of_birth: default(country_of_birth),
    height: default(height),
    cohort: default_cohort(cohort).to_sym
  }
end

def input_students
  puts "Please enter the names of the students"
  # get the first name
  name = STDIN.gets.delete "\n"
  # while the name is not empty, repeat this code
  puts "What is his/her hobby?"
  hobby = STDIN.gets.chomp
  puts "What is his/her country of birth?"
  country_of_birth = STDIN.gets.chomp
  puts "What is his/her height?"
  height = STDIN.gets.chomp
  puts "Which cohort will he/she attending?"
  cohort = STDIN.gets.chomp

  while !name.empty? do
    # add the student hash to the array
    students_array(name, hobby, country_of_birth, height, cohort)
    puts "Now we have #{@students.count} student#{plural}"
    # get another name from the user
    puts "Add another name or hit return to finish"
    name = STDIN.gets.delete "\n"
    if !name.empty?
      puts "Hobby?"
      hobby = STDIN.gets.chomp
      puts "Country of birth?"
      country_of_birth = STDIN.gets.chomp
      puts "Height?"
      height = STDIN.gets.chomp
      puts "Cohort?"
      cohort = STDIN.gets.chomp
    end
  end
  # return the array of students
  @students
  end

def print_header
  header_title = " The students of Villain Academy "
  puts header_title.center(65, '* ')
  puts "-" * header_title.center(65, '* ').length
end

def print_students_list
  i = 0
  while i != @students.length do
      student_to_print = @students[i]
      puts """
      #{i + 1}. #{student_to_print[:name]} is #{student_to_print[:height]} tall, has an odd hobby of #{student_to_print[:hobby]},
      born in #{student_to_print[:country_of_birth]} and going to study in the #{student_to_print[:cohort]} cohort.
      """
      i += 1
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great student#{plural}"
end

def cohort_list
  i = 0
  cohorts = []
  while i != @students.length do
    next_cohort = @students[i]
    if !cohorts.include? next_cohort[:cohort].to_s
      cohorts << next_cohort[:cohort].to_s
    end
    i += 1
  end
  cohorts.uniq
end

def print_by_cohorts(cl)
  i = 0
  while i != cl.length do
    next_cohort = cl[i]
    puts "#{next_cohort.capitalize} cohort:"
  @students.each { |x|
    if x[:cohort] == next_cohort.to_sym
      puts """
      #{i + 1}. #{x[:name]} is #{x[:height]} tall, has an odd hobby of #{x[:hobby]},
      born in #{x[:country_of_birth]}.
      """
    end
    }
    i += 1
  end
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit"
end

def show_students
  print_header
  print_students_list
  print_footer
end

def process(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "3"
    save_students
  when "4"
    load_students
  when "9"
    exit
  else
    puts "I don't know what you meant, try again"
  end
end

def save_students
  # open the file for writing
  file = File.open("students.csv", "w")
  # iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:hobby], student[:country_of_birth], student[:height], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, hobby, country_of_birth, height, cohort = line.chomp.split(',')
    students_array(name, hobby, country_of_birth, height, cohort)
  end
  file.close
end

def try_load_students
  filename = ARGV.first
  if !filename.nil?
    if File.exists?(filename)
      load_students(filename)
      puts "Loaded #{@students.count} from #{filename}"
    else
      puts "Sorry #{filename} doesn't exist."
      exit
    end
  else
    load_students("students.csv")
  end
end

try_load_students
interactive_menu
