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

  while !name.empty? do
    # add the student hash to the array
    students << {name: name, hobby: hobby, country_of_birth: country_of_birth, height: height, cohort: :november}
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
    end
  end
  # return the array of students
  students
  end

def print_header
  puts "The students of Villain Academy"
  puts "-------------"
end

def print(students)
  i = 0
  while i != students.length do
      student_to_print = students[i]
      puts """
      #{student_to_print[:name]} is #{student_to_print[:height]} tall, has an odd hobby of #{student_to_print[:hobby].downcase},
      born in #{student_to_print[:country_of_birth]} and going to study in the #{student_to_print[:cohort]} cohort.
      """
      i += 1
  end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students"
end
# nothing happens until we call the methods
students = input_students
print_header
print(students)
print_footer(students)
