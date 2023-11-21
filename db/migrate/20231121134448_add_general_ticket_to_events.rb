class AddGeneralTicketToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :general_ticket, :string
  end
end
