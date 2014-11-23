class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.boolean :score
      t.boolean :score_char

      t.timestamps
    end
  end
end
