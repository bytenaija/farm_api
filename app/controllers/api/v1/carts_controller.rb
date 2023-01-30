class Api::V1::CartsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_cart, except: [:create]
  
    def create
      @cart = current_user.carts.create
      render json: @cart
    end

    def show
        render json: @cart.to_json
    end

    def destroy
      @cart.destroy
      render json: { message: 'Cart destroyed successfully' }
    end
  

    def update_cart
        @cart.update_cart(params: params)
        render json: @cart.to_json
    end
  
   
    def remove_item
        farm_produce = FarmProduce.find(params[:farm_produce_id])
        @cart.remove_item(farm_produce)
        render json: { message: "Item removed from cart successfully" }, status: :ok
    end

    private
  
    def set_cart
      
      @cart = Cart.includes(:cart_items).find(params[:id])
      # debug @cart
    end
  
    def check_cart_ownership
      render json: { error: 'Access denied' }, status: :forbidden unless @cart.user == current_user
    end

    
end
