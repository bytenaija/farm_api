describe 'Carts API' do
    path '/api/v1/carts' do
      post 'Creates a cart' do
        tags 'Carts'
        consumes 'application/json'
        parameter name: :cart, in: :body, schema: {
          type: :object,
          properties: {
            user_id: { type: :integer },
          },
          required: [ 'user_id' ]
        }
  
        response '201', 'cart created' do
          let(:cart) { { user_id: 1 } }
          run_test!
        end
      end
  
      get 'Retrieves a cart' do
        tags 'Carts'
        consumes 'application/json'
        parameter name: :id, in: :path, type: :integer
  
        response '200', 'cart retrieved' do
          let(:id) { Cart.create(user_id: 1).id }
          run_test!
        end
      end
  
      delete 'Deletes a cart' do
        tags 'Carts'
        consumes 'application/json'
        parameter name: :id, in: :path, type: :integer
  
        response '204', 'cart deleted' do
          let(:id) { Cart.create(user_id: 1).id }
          run_test!
        end
      end
    end
  end