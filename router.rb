class Router
  def initialize(meals_controller, customers_controller, sessions_controller)
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @sessions_controller = sessions_controller
    @running = true
  end

  def run
    while @running
      @employee = @sessions_controller.sign_in
      if @employee.manager?
        choice = display_manager_menu
        print `clear`
        manager_action(choice)
      else
        choice = display_delivery_menu
        print `clear`
        delivery_action(choice)
      end

    end
  end

  private

  def display_manager_menu
    puts "------------------------------"
    puts "------------ MENU ------------"
    puts "------------------------------"
    puts "What do you want to do"
    puts "1 - List all meals"
    puts "2 - Add a meal"
    puts "3 - List all customers"
    puts "4 - Add a customer"
    puts "8 - Sign out"
    puts "9 - Quit"
    print "> "
    gets.chomp.to_i
  end

  def display_delivery_menu
    puts "------------------------------"
    puts "------------ DG MENU ------------"
    puts "------------------------------"
    puts "What do you want to do"
    puts "1 - "
    puts "8 - Sign out"
    puts "9 - Quit"
    print "> "
    gets.chomp.to_i
  end

  def manager_action(choice)
    case choice
    when 1 then @meals_controller.list
    when 2 then @meals_controller.add
    when 3 then @customers_controller.list
    when 4 then @customers_controller.add
    when 8 then run
    when 9 then @running = false
    else
      puts "Try again..."
    end
  end

  def delivery_action(choice)
    case choice
    when 1 then @meals_controller.list
    when 8 then run
    when 9 then @running = false
    else
      puts "Try again..."
    end
  end
end
