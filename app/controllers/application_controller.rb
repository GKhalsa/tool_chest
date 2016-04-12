class ApplicationController < ActionController::Base
  helper_method :most_recent_tool, :current_tool_summary
  protect_from_forgery with: :exception

  def most_recent_tool
    id = session[:most_recent_tool_id]
    if Tool.all.empty?
      "No Tools in System"
    else
      Tool.find(id).name
    end
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
