require_relative 'base_view'

class SessionsView < BaseView
  def welcome(employee)
    puts "Welcome #{employee.username} 👋"
  end

  def wrong_credentials
    puts "Sorry. Wrong credentials 🤮"
  end
end
