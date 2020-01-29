require_relative '../views/sessions_view'

class SessionsController
  def initialize(employee_repository)
    @employee_repository = employee_repository
    @sessions_view = SessionsView.new
  end

  def sign_in
    # username = view asks for username
    username = @sessions_view.ask_for('username')
    # password = view asks for password
    password = @sessions_view.ask_for('password')
    employee = @employee_repository.find_by_username(username)
    # check the repo if username exists && password is right
    if employee && employee.password == password
      # tell view to welcome them
      @sessions_view.welcome(employee)
      employee
    else
      @sessions_view.wrong_credentials
      sign_in
      #  tell them the credentials are wrong
      # try again
    end
  end
end
