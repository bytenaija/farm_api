module CartMethods
    extend ActiveSupport::Concern

  included do
    has_many :cart_items, dependent: :destroy

    def create_cart(user_id)
        user = User.find(user_id)
        cart = user.carts.create
        cart
    end

    def destroy_cart(cart_id)
        cart = Cart.find(cart_id)
        cart.destroy
        cart
    end

    def update_cart(params: nil)
        return unless params

        if params[:shipping_address].present?
            update_shipping_address(params[:shipping_address])
        end

        if params[:billing_address].present?
            update_billing_address(params[:billing_address])
        end

        if params[:farm_produce_id].present? ||  params[:quantity].present?
            update_quantity(params[:farm_produce_id], params[:quantity].to_i)
        end

        reload
    end


    def update_shipping_address(shipping_address_params)
        unless shipping_address.nil?
            address = Address.find(shipping_address.id)
        end

        address ||= Address.new()
        address.first_name = shipping_address_params[:first_name] if shipping_address_params.present?
        address.last_name = shipping_address_params[:last_name] if shipping_address_params.present?
        address.line1 = shipping_address_params[:line1] if shipping_address_params.present?
        address.line2 = shipping_address_params[:line2] if shipping_address_params.present?
        address.city = shipping_address_params[:city] if shipping_address_params.present?
        address.state = shipping_address_params[:state] if shipping_address_params.present?
        address.zipcode = shipping_address_params[:zipcode] if shipping_address_params.present?
        address.country = shipping_address_params[:country] if shipping_address_params.present?
        address.phone_number = shipping_address_params[:phone_number] if shipping_address_params.present?
        address.address_type = :shipping
        address.user = user
        address.cart = self
        address.save!
    end

    def update_billing_address(billing_address_params)

        unless billing_address.nil?
            address = Address.find(billing_address&.id)
        end
        
        address ||= Address.new()
        address.first_name = billing_address_params[:first_name] if billing_address_params.present?
        address.last_name = billing_address_params[:last_name] if billing_address_params.present?
        address.line1 = billing_address_params[:line1] if billing_address_params.present?
        address.line2 = billing_address_params[:line2] if billing_address_params.present?
        address.city = billing_address_params[:city] if billing_address_params.present?
        address.state = billing_address_params[:state] if billing_address_params.present?
        address.zipcode = billing_address_params[:zipcode] if billing_address_params.present?
        address.country = billing_address_params[:country] if billing_address_params.present?
        address.phone_number = billing_address_params[:phone_number] if billing_address_params.present?
        address.user = user
        address.cart = self
        address.address_type = :billing
        address.save!
    end

    def add_item(farm_produce, quantity = 1)
        cart_item = cart_items.find_or_initialize_by(farm_produce: farm_produce)
        cart_item.quantity = 1
        cart_item.save!
    end

    def update_quantity(item_id, quantity = 1)
        item = cart_items.find_by(farm_produce_id: item_id)
        if item.present?
            item.update(quantity: quantity)
            print item
        else
            add_item(FarmProduce.find(item_id))
        end
        update_total_amount
    end

    def remove_item(farm_produce)
        cart_item = cart_items.find_by(farm_produce: farm_produce)
        return if cart_item.nil?
        cart_item.destroy
        update_total_amount
    end

    def update_total_amount
      self.total_amount = cart_items.sum { |item| item.farm_produce.price * item.quantity }
      save!
      self.reload

      print self.total_amount
    end

    def to_json
        json_data = {
            id: id,
            total_amount: total_amount
        }
        json_data[:cart_items] = cart_items.map do |cart_item|
            cart_item.as_json(include: :farm_produce)
        end

        json_data[:shipping_address] = shipping_address
        json_data[:billing_address] = billing_address

        json_data
    end
  end
end