require_relative 'sql_object'
require_relative 'quote'
require_relative 'philosopher'
require_relative 'school'
require_relative 'db_connection'
require 'colorize'
require 'byebug'

class Quiz

  def initialize
    @points = 0
    @questions_asked = 0
    @current_answer = nil
  end

  def run
    puts "Welcome to wORMhole!".colorize(:blue)
    puts "Answer 3 out of 5 questions correctly and you win!".colorize(:blue)
    take_turn until game_over?
    ending_sequence
  end

  def game_over?
    @points >= 3 || @questions_asked >= 5
  end

  def ending_sequence
    if @points >= 3
      puts "Congratulations! You know your stuff.".colorize(:green)
    else
      puts "I do not congratulate you. You do not know your stuff.".colorize(:red)
    end
    sleep(2)
    puts "Play again? Type 'yes' to play again, or literally anything else if you are a quitter.".colorize(:blue)
    response = gets.chomp
    response.downcase == 'yes' ? reset : nil
  end

  def reset
    @points, @questions_asked, @current_answer = 0, 0, nil
    run
  end

  def take_turn
    @current_answer = nil
    render_load_screen
    display_quote
    guess = prompt_user
    if guess == @current_answer
      @points += 1
      puts "Yes that is good well done yes!".colorize(:green)
    else
      puts "No. This is very disappointing. You are wasting wORMhole's time and technology.".colorize(:red)
    end
    @questions_asked += 1
    puts "Score: #{@points} / #{@questions_asked}".colorize(:blue)
    sleep(4)
  end

  def prompt_user
    puts ""
    puts "-----------------------------"
    puts "To which 'school' of philosophy does the quote belong?"
    puts "Please type:"
    puts "'an' for Analytic"
    puts "'co' for Continental"
    puts "'ch' for Chinese"
    puts "'ar' for Arctic"
    puts "'up' for Upside-down Philosophy"
    puts "'wo' for Wonderful Philosophical Musings of Woodland Creatures"
    puts "**(Please do not question our terrifically precise definition of a philosophical 'school.' It is correct.)".colorize(:light_blue)
    puts ""

    response = gets.chomp.downcase
    until valid_response?(response)
      puts "Please do better and type in one of the four choices: an, co, ch, ar, up, wo".colorize(:red)
      response = gets.chomp.downcase
    end

    response
  end

  def valid_response?(response)
    response == "an" || response == "co" ||
    response == "ch" || response == "ar" ||
    response == "up" || response == "wo"
  end

  def display_quote
    random_quote = Quote.all.sample
    puts "#{random_quote.philosopher.name} said..."
    puts ""
    puts "'#{random_quote.body.colorize(:light_blue)}'"
    @current_answer = "#{random_quote.school.name}"[0..1].downcase
  end

  def render_load_screen
    system("clear")
    puts "Initializing turn #{@questions_asked + 1}...".colorize(:magenta)
    sleep(2)
    system("clear")
    puts "Querying the database...".colorize(:light_magenta)
    sleep(2)
    system("clear")
    puts "Converting database entries into Ruby objects with our sweet wORMhole technology...".colorize(:light_cyan)
    sleep(3)
    system("clear")
  end
end


if __FILE__ == $PROGRAM_NAME
  DBConnection.reset
  quiz = Quiz.new
  quiz.run
end
