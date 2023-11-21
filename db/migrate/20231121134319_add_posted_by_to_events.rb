class AddPostedByToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :posted_by, :string
  end
end
