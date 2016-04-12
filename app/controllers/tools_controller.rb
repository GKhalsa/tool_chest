class ToolsController < ApplicationController

  def index
    @tools = Tool.all
  end

  def show
    @tool = Tool.find(params[:id])
  end

  def new
    @tool = Tool.new
  end

  def create
    @tool = Tool.new(tool_params)

    if @tool.save
      flash[:notice] = "You successfully created a tool"
      session[:most_recent_tool_id] = @tool.id
      redirect_to tool_path(@tool.id)
    else
      flash.now[:error] = @tool.errors.full_messages.join(", ")
      render :new
    end

  end

  def edit
    @tool = Tool.find(params[:id])
  end

  def update
    @tool = Tool.find(params[:id])
    if @tool.update( tool_params)
      redirect_to tools_path(@tool)
    else
      render :edit
    end
  end

  def destroy
    tool = Tool.find(params[:id])
    tool.destroy
    redirect_to tools_path
  end



  private


  def tool_params
    params.require(:tool).permit(:name, :price, :quantity)
  end
end
