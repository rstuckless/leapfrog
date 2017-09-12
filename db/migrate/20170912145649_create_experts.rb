class CreateExperts < ActiveRecord::Migration[5.1]
  def change
    create_table :experts do |t|
      t.text :email
      t.text :name
      t.text :picture_url

      t.timestamps
    end
  end
end
