class Admin::PagesController < Admin::ApplicationController
  # edit landing_page
  def index
    @welcome_text = Content.find_or_create_by(name: 'landing_page_welcome_text')
  end
end
