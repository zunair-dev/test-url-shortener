class CreateUrls < ActiveRecord::Migration[8.0]
  def change
    create_table :urls do |t|
      t.text :original_url, null: false
      t.string :short_url, null: false
      t.integer :visits_count, default: 0, null: false

      t.timestamps
    end

    add_index :urls, :short_url
  end
end
