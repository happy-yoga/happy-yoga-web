class PagesController < ApplicationController
  def landing_page
    render layout: 'landing_page'
  end
end
