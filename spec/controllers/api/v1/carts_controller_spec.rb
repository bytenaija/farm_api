require 'rails_helper'

RSpec.describe Api::V1::CartsController, type: :controller do
  describe "GET #show" do
    let(:cart) { create(:cart) }

    it "returns a success response" do
      get :show, params: { id: cart.to_param }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Cart" do
        expect {
          post :create, params: { cart: { user_id: create(:user).id } }
        }.to change(Cart, :count).by(1)
      end

      it "renders a JSON response with the new cart" do
        post :create, params: { cart: { user_id: create(:user).id } }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.location).to eq(api_v1_cart_url(Cart.last))
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new cart" do
        post :create, params: { cart: { user_id: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "PUT #update" do
    let(:cart) { create(:cart) }

    context "with valid params" do
      let(:new_attributes) { { user_id: create(:user).id } }

      it "updates the requested cart" do
        put :update, params: { id: cart.to_param, cart: new_attributes }
        cart.reload
        expect(cart.user_id).to eq(new_attributes[:user_id])
      end

      it "renders a JSON response with the cart" do
        put :update, params: { id: cart.to_param, cart: valid_attributes }
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the cart" do
        put :update, params: { id: cart.to_param, cart: { user_id: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  # describe "DELETE #destroy" do
  #   let(:cart) { create(:cart) }

  #   it "destroys the requested cart" do
  #     expect {
  #       delete :destroy, params: { id: cart.to_param }
  #   end
  # end
end



