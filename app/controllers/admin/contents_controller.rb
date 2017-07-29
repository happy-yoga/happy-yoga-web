class Admin::ContentsController < Admin::ApplicationController
  before_action :set_content, only: [:show, :edit, :update]

  # edit landing_page
  def index
    @contents = Content.all
  end

  def show
  end

  # GET /fubars/1/edit
  def edit
  end

  def update
    if @content.update(content_params)
      redirect_to @content, notice: 'Fubar was successfully updated.'
    else
      render :edit
    end
  end


  private

  def set_content
    @content = Content.find(params[:id])
  end

  def content_params
    params.require(:content).permit(:body)
  end

  def content_url(content)
    edit_admin_content_url(content)
  end
end
