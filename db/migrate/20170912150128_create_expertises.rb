class CreateExpertises < ActiveRecord::Migration[5.1]
  def change
    create_table :expertises do |t|
      t.references :skill, foreign_key: true
      t.references :expert, foreign_key: true
      t.string :level

      t.timestamps
    end
  end
end
