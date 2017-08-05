class PagesController < ApplicationController
  def landing_page
    @welcome_text = Content.find_by(name: "landing_page_welcome_text")
    render layout: 'landing_page'
  end
end
