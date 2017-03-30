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


def input_students
  puts "Please enter the names of the students"
  # create an empty array
  students = []
  # get the first name
  name = gets.chomp
  # while the name is not empty, repeat this code
  puts "What is his/her hobby?"
  hobby = gets.chomp
  puts "What is his/her country of birth?"
  country_of_birth = gets.chomp
  puts "What is his/her height?"
  height = gets.chomp
  puts "Which cohort will he/she attending?"
  cohort = gets.chomp

  while !name.empty? do
    # add the student hash to the array
    students << {
      name: default(name),
      hobby: default(hobby),
      country_of_birth: default(country_of_birth),
      height: default(height),
      cohort: default_cohort(cohort).to_sym
    }

    puts "Now we have #{students.count} students"
    # get another name from the user
    puts "Add another name or hit return to finish"
    name = gets.chomp
    if !name.empty?
      puts "Hobby?"
      hobby = gets.chomp
      puts "Country of birth?"
      country_of_birth = gets.chomp
      puts "Height?"
      height = gets.chomp
      puts "Cohort?"
      cohort = gets.chomp
    end
  end
  # return the array of students
  students
  end

def print_header
  header_title = " The students of Villain Academy "
  puts header_title.center(65, '* ')
  puts "-" * header_title.center(65, '* ').length
end

def print(students)
  i = 0
  while i != students.length do
      student_to_print = students[i]
      puts """
      #{i + 1}. #{student_to_print[:name]} is #{student_to_print[:height]} tall, has an odd hobby of #{student_to_print[:hobby].downcase},
      born in #{student_to_print[:country_of_birth]} and going to study in the #{student_to_print[:cohort]} cohort.
      """
      i += 1
  end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students"
end

def cohort_list(students)
  i = 0
  cohorts = []
  while i != students.length do
    next_cohort = students[i]
    if !cohorts.include? next_cohort[:cohort].to_s
      cohorts << next_cohort[:cohort].to_s
    end
    i += 1
  end
  cohorts.uniq
end

def print_by_cohorts(cl,students)
  i = 0
  while i != cl.length do
    next_cohort = cl[i]
    puts "#{next_cohort.capitalize} cohort:"
  students.each { |x|
    if x[:cohort] == next_cohort.to_sym
      puts """
      #{i + 1}. #{x[:name]} is #{x[:height]} tall, has an odd hobby of #{x[:hobby].downcase},
      born in #{x[:country_of_birth]}.
      """
    end
    }
    i += 1
  end
end

# nothing happens until we call the methods
students = input_students
print_header
print_by_cohorts(cohort_list(students),students)
print_footer(students)
