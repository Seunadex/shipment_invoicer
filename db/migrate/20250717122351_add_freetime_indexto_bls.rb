class AddFreetimeIndextoBls < ActiveRecord::Migration[7.2]
  def change
    add_index :bls, [ :arrival_date, :freetime ], name: 'index_bls_on_arrival_date_and_freetime'
  end
end
