require_relative "scraper"
require_relative "plant"
require_relative "user"

class CLI
  def run
    User.load_users_from_file
    url = 'https://aznps.com/the-plant-list/'
    plants = Scraper.scrape_data(url)
    greeting
    authenticate
    menu(plants)
    end_program
  end

  def greeting
    puts '--------------------------------'
    puts "Welcome to the Arizona Native Plant Society CLI"
    puts '--------------------------------'
  end

  def end_program
    puts '--------------------------------'
    puts "Thank you for using the Arizona Native Plant Society CLI!"
    puts '--------------------------------'
  end

  def menu(plants)
    input = nil
    while input != "exit"
      list_options
      input = gets.chomp.downcase
      choose_option(input, plants)
    end
  end

  def list_options
    puts "--------------------------------"
    puts "Please select an option from the menu below"
    puts "1. List all plants"
    puts "2. List plants by scientific name"
    puts "Exit the program by entering 'exit'"
  end

  def choose_option(option, plants)
    case option
    when "1"
      puts "---------------------"
      puts "Listing all plants..."
      plants.each_with_index do |plant, index|
        puts "#{index + 1}. #{plant.name}"
      end
    when "2"
      puts "------------------------------------"
      puts "Listing plants by scientific name..."
      plants.each_with_index do |plant, index|
        scientific_name = plant.scientific_name || "N/A"
        puts "#{index + 1}. #{plant.name} (#{scientific_name})"
    end
    when "exit"
      # Do nothing, the loop will exit
    else
      puts "Invalid option. Please choose a valid option from the menu."
    end
  end
  
  # authenticate user or create account
    def authenticate
      authenticated = false

      until authenticated
        puts 'Please login or sign up'
        puts 'Which do you choose? (sign up/login)'
        if get_input == 'login'
          authenticated = login
        else
          create_account
        end
      end
    end

  # This will enter in the user's choice (signup/login)
  def get_input
    puts "Enter your choice: "
    gets.chomp.downcase
  end
  
    # check if user is in User class and if password matches
    def login
      puts 'Please enter your username:'
      username = gets.chomp
      puts 'Please enter your password:'
      password = gets.chomp
      result = User.authenticate(username, password)

      if result
        puts "Welcome back #{username}!"
      else
        puts 'Sorry, that username and password combination is not recognized. Please try again.'
      end
      result
    end

    # create a new user and add to User class
    def create_account
      puts 'Please enter a username:'
      username = gets.chomp
    
      puts 'Please enter a password:'
      password = gets.chomp
    
      user = User.new(username, password, false) # false indicates that the password is not hashed
      User.store_credentials(user)
      puts 'Account created'
    end
  end
