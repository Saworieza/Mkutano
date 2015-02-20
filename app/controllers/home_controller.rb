class HomeController < ApplicationController
  def index
  	@events = Event.order('created_at DESC').limit(10)
  	#@events = Event.paginate(page: params[:page], per_page: 5)
  end
end
