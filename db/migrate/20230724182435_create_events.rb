class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.decimal :amount, precision: 10, scale: 2
      t.datetime :event_datetime
      t.string :image_url
      t.decimal :rating, precision: 2, scale: 1
      t.string :location
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
