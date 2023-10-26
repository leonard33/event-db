require 'swagger_helper'

RSpec.describe 'api/v1/bookings', type: :request do
  let(:user_id) do
    User.create(username: 'test', role: 'member', email: 'test@gmail.com', password: 'test1234').id
  end

  let(:category_id) { Category.create(name: 'comedy').id }

  let(:event_id) do
    Event.create(
      name: 'fun',
      description: 'dance',
      amount: 23.0,
      event_datetime: '2023-07-23T12:00:00Z',
      image_url: 'image.png',
      rating: 5.4,
      location: 'new jersey',
      category_id:
    ).id
  end

  let(:booking_params) do
    { number_of_tickets: 23, ticket_number: '23mnufc', amount: 200, event_id:, user_id: }
  end

  path '/api/v1/bookings' do
    get('list bookings') do
      tags 'bookings'
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

    post('create booking') do
      tags 'bookings'
      consumes 'application/json'
      parameter name: :booking, in: :body, schema: {
        type: :object,
        properties: {
          number_of_tickets: { type: :number },
          ticket_number: { type: :string },
          amount: { type: :number, format: :float },
          event_id: { type: :integer },
          user_id: { type: :integer }
        },
        required: %w[number_of_tickets ticket_number amount event_id user_id]
      }
      response(201, 'successful') do
        let(:booking) { booking_params }
        run_test!
      end
    end
  end

  path '/api/v1/bookings/{id}' do
    parameter name: :id, in: :path, type: :string

    get('show booking') do
      tags 'bookings'
      response(200, 'successful') do
        let(:id) do
          Booking.create(booking_params).id
        end
        run_test!
      end
    end

    put('update booking') do
      tags 'bookings'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :booking, in: :body, schema: {
        type: :object,
        properties: {
          number_of_tickets: { type: :number },
          ticket_number: { type: :string },
          amount: { type: :number, format: :float },
          event_id: { type: :integer },
          user_id: { type: :integer }
        },
        required: %w[number_of_tickets ticket_number amount event_id user_id]
      }
      response(200, 'successful') do
        let(:id) do
          Booking.create(booking_params).id
        end
        let(:booking) do
          { number_of_tickets: 5, ticket_number: 'WXYZ5678', amount: 50, event_id:, user_id: }
        end
        run_test!
      end

      response(422, 'unsuccessful') do
        let(:id) do
          Booking.create(booking_params).id
        end
        let(:booking) { { number_of_tickets: 5, ticket_number: 'WXYZ5678', amount: 50, event_id: '', user_id: '' } }
        run_test!
      end
    end

    delete('delete booking') do
      tags 'bookings'
      response(204, 'successful') do
        let(:id) do
          Booking.create(booking_params).id
        end
        run_test! do
          expect(response.status).to eq(204)
          expect(Booking.find_by_id(id)).to be_nil
        end
      end
    end
  end
end
