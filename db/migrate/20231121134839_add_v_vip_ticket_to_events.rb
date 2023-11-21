class AddVVipTicketToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :vvip_ticket, :string
  end
end
