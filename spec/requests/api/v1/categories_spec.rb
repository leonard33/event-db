require 'swagger_helper'

RSpec.describe 'api/v1/categories', type: :request do
  let(:category_params) { { name: 'comedy' } }
  let(:category_id) { Category.create(category_params).id }

  path '/api/v1/categories' do
    # List categories
    get('list categories') do
      tags 'Categories'
      response(200, 'successful') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    # Create category
    post('create category') do
      tags 'Categories'
      consumes 'application/json'
      parameter name: :category, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string }
        },
        required: %w[name]
      }
      response(201, 'successful') do
        let(:category) { category_params }
        run_test!
      end

      response(422, 'invalid request') do
        let(:category) { { name: '' } }
        run_test!
      end
    end
  end

  path '/api/v1/categories/{id}' do
    parameter name: :id, in: :path, type: :string

    # Show category
    get('show category') do
      tags 'Categories'
      response(200, 'successful') do
        let(:id) { category_id }
        run_test!
      end
    end

    # Update category
    put('update category') do
      tags 'Categories'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :category, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string }
        },
        required: %w[name]
      }
      response(200, 'successful') do
        let(:id) { category_id }
        let(:category) { { name: 'updated category' } }
        run_test!
      end
    end

    # Delete category
    delete('delete category') do
      tags 'Categories'
      parameter name: :id, in: :path, type: :string

      response(204, 'successful') do
        let(:id) { category_id }

        run_test! do
          expect(response.status).to eq(204)
          expect(Category.find_by_id(id)).to be_nil
        end
      end
    end
  end
end
