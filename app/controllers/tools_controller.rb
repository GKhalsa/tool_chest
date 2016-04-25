class ToolsController < ApplicationController

  def index
    @user = current_user
    @tools = @user.tools
  end

  def show
    @user = User.find(params[:user_id])
    @tool = Tool.find(params[:id])
  end

  def new
    @user = User.find(params[:user_id])
    @tool = Tool.new
  end

  def create
    @user = User.find(params[:user_id])
    @tool = @user.tools.new(tool_params)
    if @tool.save
      flash[:notice] = "You successfully created a tool"
      session[:most_recent_tool_id] = @tool.id
      #send message
      send_message(@tool)
      redirect_to @user
    else
      flash.now[:error] = @tool.errors.full_messages.join(", ")
      render :new
    end
  end

  def edit
    @user = User.find(params[:user_id])
    @tool = Tool.find(params[:id])
  end

  def update
    @tool = Tool.find(params[:id])
    if @tool.update(tool_params)
      redirect_to
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @tool = Tool.find(params[:id])
    @tool.destroy
    redirect_to user_tools_path(@user)
  end

  private

  def tool_params
    params.require(:tool).permit(:name, :price, :quantity, :category_id, :number)
  end
end
