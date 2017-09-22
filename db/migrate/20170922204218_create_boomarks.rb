class CreateBoomarks < ActiveRecord::Migration
  def change
    create_table :boomarks do |t|
      t.integer :movie_id
      t.integer :user_id

      t.timestamps

    end
  end
end
