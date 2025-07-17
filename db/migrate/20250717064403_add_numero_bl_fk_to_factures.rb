class AddNumeroBlFkToFactures < ActiveRecord::Migration[7.2]
  def change
    # Handles non-null constraint for numero_bl
    change_column_null :factures, :numero_bl, false

    # Add the FK to bls.numero_bl
    unless foreign_key_exists?(:factures, :bls, column: :numero_bl, name: "fk_factures_numero_bl")
      add_foreign_key :factures, :bls,
                      column:      :numero_bl,
                      primary_key: :numero_bl,
                      name:        "fk_factures_numero_bl"
    end
  end
end
