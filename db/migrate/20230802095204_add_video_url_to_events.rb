class AddVideoUrlToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :video_url, :string
  end
end
