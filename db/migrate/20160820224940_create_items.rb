class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :title
      t.text :description
      t.references :category, foreign_key: true
      t.decimal :price, precision: 10, scale: 6
      t.references :seller, foreign_key: true
      t.references :status, foreign_key: true
      t.date :published_date

      t.timestamps
    end
  end
end
