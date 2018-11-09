class StoreController < ApplicationController
  before_action :counter_access, only: [:index]

  def index
    @products = Product.order(:title)
  end

  private 

    def counter_access
      if session[:counter].nil?
        session[:counter] = 0
      else
        session[:counter] += 1
      end
      @counter = session[:counter]
    end

end
