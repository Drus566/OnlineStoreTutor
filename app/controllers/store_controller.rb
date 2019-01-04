class StoreController < ApplicationController
  include CurrentCart
  skip_before_action :authorize
  before_action :set_cart
  before_action :counter_access, only: [:index]

  def index
    if params[:set_locale]
      redirect_to store_index_url(locale: params[:set_locale])
    else
      @products = Product.order(:title)
    end
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
