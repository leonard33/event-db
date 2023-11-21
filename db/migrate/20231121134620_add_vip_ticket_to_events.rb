class AddVipTicketToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :vip_ticket, :string
  end
end
