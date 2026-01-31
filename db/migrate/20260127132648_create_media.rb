class CreateMedia < ActiveRecord::Migration[8.0]
  def change
    create_table :media do |t|
      t.references :post, null: false, foreign_key: true
      t.string :url
      t.string :media_type

      t.timestamps
    end
  end
end
