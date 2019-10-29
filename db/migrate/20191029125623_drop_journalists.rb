class DropJournalists < ActiveRecord::Migration[6.0]
  def change
    drop_table :journalists
  end
end
