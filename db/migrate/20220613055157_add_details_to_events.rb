class AddDetailsToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :gender_ratio, :integer, null: false, default: 0
    add_column :events, :number_of_participants, :integer
  end
end
