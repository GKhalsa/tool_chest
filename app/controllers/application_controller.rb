class ApplicationController < ActionController::Base
  helper_method :most_recent_tool, :current_tool_summary, :current_user
  protect_from_forgery with: :exception

  def current_user
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def send_message(tool)
    account_sid = ""
    auth_token  = ""

    client = Twilio::REST::Client.new(account_sid, auth_token)
    from   = "+"
    data   = {
      :from => from,
      :to => "+1#{tool.number}", # format of this number needs to be "+1" at the beginning of the area code and phone number
      :body => "You just created #{tool.quantity} #{tool.name}(s)",
    }

    client.account.messages.create(data)
  end

  def user_message(user)
    account_sid = ""
    auth_token  = ""

    client = Twilio::REST::Client.new(account_sid, auth_token)
    from   = "" # Your Twilio number
    data   = {
      :from => from,
      :to => "+1#{user.number}", # format of this number needs to be "+1" at the beginning of the area code and phone number
      :body => "Your security access code is 3498",
    }

    client.account.messages.create(data)
  end

  def current_tool_summary
    stats
    count = session[:current_tool_count]
    revenue = session[:current_potential_revenue]
    "#{count} tool(s) with a value of #{revenue}"
  end

  def stats
    t = Tool.all.reduce(0) {|acc, tool| acc + (tool.quantity * tool.price)}

    session[:current_tool_count] = Tool.sum(:quantity)
    session[:current_potential_revenue] = t
  end
end


# session[:current_tool_count] = Tool.count
# session[:current_potential_revenue] = Tool.sum(:price)
