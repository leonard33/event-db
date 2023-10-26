require 'swagger_helper'

RSpec.describe 'api/v1/events', type: :request do
  let(:category_id) { Category.create(name: 'comedy').id }

  let(:event_params) do
    {
      name: 'fun',
      description: 'dance',
      amount: 23.0,
      event_datetime: '2023-07-23T12:00:00Z',
      image_url: 'image.png',
      rating: 5.4,
      location: 'new jersey',
      category_id:
    }
  end

  let(:event_id) { Event.create(event_params).id }

  path '/api/v1/events' do
    # List events
    get('list events') do
      tags 'events'
      response(200, 'successful') do
        run_test!
      end
    end

    # Create event
    post('create event') do
      tags 'events'
      consumes 'application/json'
      parameter name: :event, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          description: { type: :string },
          amount: { type: :number, format: :float },
          event_datetime: { type: :string, format: :date_time },
          image_url: { type: :string },
          rating: { type: :number, format: :float },
          location: { type: :string },
          category_id: { type: :integer }
        },
        required: %w[name description amount event_datetime image_url rating location category_id]
      }
      response(201, 'successful') do
        let(:event) { event_params }
        run_test!
      end

      response(422, 'unprocessable entity') do
        let(:event) { event_params.merge(category_id: 'invalid_category_id') }
        run_test!
      end
    end
  end

  path '/api/v1/events/{id}' do
    parameter name: :id, in: :path, type: :string

    # Show event
    get('show event') do
      tags 'events'
      response(200, 'successful') do
        let(:id) { event_id }
        run_test!
      end
    end

    # Update event
    put('update event') do
      tags 'events'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :event, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          description: { type: :string },
          amount: { type: :number, format: :float },
          event_datetime: { type: :string, format: :date_time },
          image_url: { type: :string },
          rating: { type: :number, format: :float },
          location: { type: :string },
          category_id: { type: :integer }
        },
        required: %w[name description amount event_datetime image_url rating location category_id]
      }
      response(200, 'successful') do
        let(:event) do
          {
            name: 'updated event',
            description: 'updated description',
            amount: 30.0,
            event_datetime: '2023-07-23T13:00:00Z',
            image_url: 'updated_image.png',
            rating: 4.8,
            location: 'new york',
            category_id:
          }
        end
        let(:id) { event_id }
        run_test!
      end

      response(422, 'unsuccessful') do
        let(:event) do
          {
            name: 'updated event',
            description: 'updated description',
            amount: 30.0,
            event_datetime: '2023-07-23T13:00:00Z',
            image_url: 'updated_image.png',
            rating: 4.8,
            location: 'new york',
            category_id: ''
          }
        end
        let(:id) { event_id }
        run_test!
      end
    end

    # Delete event
    delete('delete event') do
      tags 'events'
      response(204, 'successful') do
        let(:id) { event_id }
        run_test! do
          expect(response.status).to eq(204)
          expect(Event.find_by_id(id)).to be_nil
        end
      end
    end
  end
end
