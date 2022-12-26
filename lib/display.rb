module Display
  def display(number_of_guesses)
    case number_of_guesses
    when 0
      display0
    when 1
      display1
    when 2
      display2
    when 3
      display3
    when 4
      display4
    when 5
      display5
    when 6
      display6
    end
  end

  def display0
    puts "     ________"
    puts "     |      |"
    puts "            |"
    puts "            |"
    puts "            |"
    puts "            |"
    puts "           _|_\n"
  end

  def display1
    puts "     ________"
    puts "     |      |"
    puts "     O      |"
    puts "            |"
    puts "            |"
    puts "            |"
    puts "           _|_\n"
  end

  
  def display2
    puts "     ________"
    puts "     |      |"
    puts "     O      |"
    puts "     |      |"
    puts "     |      |"
    puts "            |"
    puts "           _|_\n"
  end

  def display3
    puts "     ________"
    puts "     |      |"
    puts "     O      |"
    puts "     |      |"
    puts "     |      |"
    puts "    /       |"
    puts "           _|_\n"
  end

  def display4
    puts "     ________"
    puts "     |      |"
    puts "     O      |"
    puts "     |      |"
    puts "     |      |"
    puts "    / \\     |"
    puts "           _|_\n"
  end

  def display5
    puts "     ________"
    puts "     |      |"
    puts "     O      |"
    puts "    \\|      |"
    puts "     |      |"
    puts "    / \\     |"
    puts "           _|_\n"
  end

  def display6
    puts "     ________"
    puts "     |      |"
    puts "     O      |"
    puts "    \\|/     |"
    puts "     |      |"
    puts "    / \\     |"
    puts "           _|_\n"
  end


end