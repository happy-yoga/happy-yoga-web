class CreateContents < ActiveRecord::Migration[5.1]
  def change
    create_table :contents do |t|
      t.string :name
      t.string :body

      t.timestamps
    end
    add_index :contents, :name, unique: true
  end
end
