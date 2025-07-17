class RenameColumnsInLegacyTables < ActiveRecord::Migration[7.2]
  def change
    # Renaming columns requires updating indexes and foreign keys accordingly.

    # BillOfLadings table (bls)
    # Remove any foreign keys referencing bls.numero_bl
    if foreign_key_exists?(:factures, :bls, column: :numero_bl)
      remove_foreign_key :factures, :bls, column: :numero_bl
    end
    if foreign_key_exists?(:remboursements, :bls, column: :numero_bl)
      remove_foreign_key :remboursements, :bls, column: :numero_bl
    end
    remove_index :bls, :numero_bl, name: "index_bls_on_numero_bl" if index_exists?(:bls, :numero_bl, name: "index_bls_on_numero_bl")
    rename_column :bls, :numero_bl,        :number               # numero_bl → more idiomatic :number
    add_index :bls, :number, unique: true, name: "index_bls_on_number" unless index_exists?(:bls, :number, name: "index_bls_on_number")

    remove_foreign_key :bls, column: :id_client, name: "fk_bls_id_client" if foreign_key_exists?(:bls, column: :id_client)
    remove_index :bls, :id_client, name: "index_bls_on_id_client"    if index_exists?(:bls, :id_client)
    rename_column :bls, :id_client,         :customer_id          # id_client → follows Rails FK naming
    add_index       :bls, :customer_id, name: "index_bls_on_customer_id" unless index_exists?(:bls, :customer_id, name: "index_bls_on_customer_id")
    add_foreign_key :bls, :clients, column: :customer_id, primary_key: "id", name: "fk_bls_customer_id" unless foreign_key_exists?(:bls, :clients, column: :customer_id, name: "fk_bls_customer_id")

    remove_index :bls, :statut, name: "index_bls_on_statut" if index_exists?(:bls, :statut)
    rename_column :bls, :statut,            :status               # statut → status
    add_index :bls, :status, name: "index_bls_on_status" unless index_exists?(:bls, :status, name: "index_bls_on_status")
    rename_column :bls, :date_upload,      :upload_date          # date_upload → upload_date
    rename_column :bls, :type_depotage,     :unloading_type       # type_depotage → English
    rename_column :bls, :released_statut,   :released_status      # released_statut → released_status
    rename_column :bls, :released_comment,  :released_notes       # released_comment → released_notes
    rename_column :bls, :date_validite,      :validity_date        # date_validite → validity_date
    rename_column :bls, :exempte,            :exempt               # exempte → exempt
    rename_column :bls, :valide,             :valid_flag           # valide → valid_flag (to avoid conflict with Rails' `valid?` method)
    rename_column :bls, :place_receipt,      :receipt_location     # place_receipt → receipt_location
    rename_column :bls, :place_delivery,      :delivery_location    # place_delivery → delivery_location
    rename_column :bls, :port_loading,      :loading_port         # port_loading → loading_port
    rename_column :bls, :port_discharge,    :discharge_port       # port_discharge → discharge_port

    # Prefix with 'quantity_' for clarity and easy identification
    rename_column :bls, :nbre_20pieds_sec, :quantity_dry_20ft
    rename_column :bls, :nbre_40pieds_sec, :quantity_dry_40ft
    rename_column :bls, :nbre_20pieds_frigo, :quantity_refrigerated_20ft
    rename_column :bls, :nbre_40pieds_frigo, :quantity_refrigerated_40ft
    rename_column :bls, :nbre_20pieds_special, :quantity_special_20ft
    rename_column :bls, :nbre_40pieds_special, :quantity_special_40ft

    # Customers table (clients)
    remove_index :clients, :nom, name: "index_clients_on_nom" if index_exists?(:clients, :nom, name: "index_clients_on_nom")
    rename_column :clients, :nom,            :name                # nom → name
    add_index :clients, :name, name: "index_clients_on_name" unless index_exists?(:clients, :name, name: "index_clients_on_name")

    remove_index :clients, :code_client, name: "index_clients_on_code_client" if index_exists?(:clients, :code_client, name: "index_clients_on_code_client")
    rename_column :clients, :code_client,    :client_code         # code_client → client_code
    add_index :clients, :client_code, unique: true, name: "index_clients_on_client_code" unless index_exists?(:clients, :client_code, name: "index_clients_on_client_code")

    remove_index :clients, :statut, name: "index_clients_on_statut" if index_exists?(:clients, :statut, name: "index_clients_on_statut")
    rename_column :clients, :statut,         :status              # statut → status
    add_index :clients, :status, name: "index_clients_on_status" unless index_exists?(:clients, :status, name: "index_clients_on_status")

    rename_column :clients, :nom_groupe,     :group_name          # nom_groupe → group_name
    rename_column :clients, :paie_caution,   :deposit_required    # paie_caution → deposit_required
    rename_column :clients, :prioritaire,    :priority            # prioritaire → priority
    rename_column :clients, :freetime_frigo, :freetime_refrigerated # freetime_frigo → freetime_refrigerated
    rename_column :clients, :freetime_sec,   :freetime_dry      # freetime_sec → freetime_dry
    rename_column :clients, :salesrepid,   :sales_rep_id        # salesrep_id → sales_rep_id
    rename_column :clients, :financerepid, :finance_rep_id      # financerepid → finance_rep_id
    rename_column :clients, :cservrepid,   :cservice_rep_id     # cservrepid → cservice_rep_id
    rename_column :clients, :date_validite, :validity_date      # date_validite → validity_date

    # Invoices table (factures)
    remove_index       :factures, :numero_bl, name: "index_factures_on_numero_bl"    if index_exists?(:factures, :numero_bl, name: "index_factures_on_numero_bl")
    remove_foreign_key :factures, column: :numero_bl, name: "fk_factures_numero_bl" if foreign_key_exists?(:factures, column: :numero_bl, name: "fk_factures_numero_bl")
    rename_column :factures, :numero_bl,        :number            # numero_bl → number
    add_index :factures, :number, name: "index_factures_on_number" unless index_exists?(:factures, :number, name: "index_factures_on_number")
    add_foreign_key :factures, :bls, column: :number, primary_key: "number", name: "fk_factures_number" unless foreign_key_exists?(:factures, :bls, column: :number, name: "fk_factures_number")

    remove_index :factures, :code_client, name: "index_factures_on_code_client" if index_exists?(:factures, :code_client, name: "index_factures_on_code_client")
    rename_column :factures, :code_client,      :client_code       # code_client → client_code
    add_index :factures, :client_code, name: "index_factures_on_client_code" unless index_exists?(:factures, :client_code, name: "index_factures_on_client_code")

    remove_index :factures, :statut, name: "index_factures_on_statut" if index_exists?(:factures, :statut, name: "index_factures_on_statut")
    rename_column :factures, :statut,           :status            # statut → status
    add_index :factures, :status, name: "index_factures_on_status" unless index_exists?(:factures, :status, name: "index_factures_on_status")

    remove_index :factures, :date_facture, name: "index_factures_on_date_facture" if index_exists?(:factures, :date_facture, name: "index_factures_on_date_facture")
    rename_column :factures, :date_facture,     :invoice_date      # date_facture → invoice_date
    add_index :factures, :invoice_date, name: "index_factures_on_invoice_date" unless index_exists?(:factures, :invoice_date, name: "index_factures_on_invoice_date")

    rename_column :factures, :nom_client,       :client_name       # nom_client → client_name
    rename_column :factures, :montant_facture,  :amount            # montant_facture → amount
    rename_column :factures, :montant_orig,     :original_amount   # montant_orig → original_amount
    rename_column :factures, :devise,           :currency          # devise → currency
    rename_column :factures, :id_utilisateur,    :user_id           # id_utilisateur → user_id

    # RefundRequests table (remboursements)
    remove_index       :remboursements, :numero_bl, name: "index_remboursements_on_numero_bl"    if index_exists?(:remboursements, :numero_bl, name: "index_remboursements_on_numero_bl")
    remove_foreign_key :remboursements, column: :numero_bl, name: "fk_remboursements_numero_bl" if foreign_key_exists?(:remboursements, column: :numero_bl, name: "fk_remboursements_numero_bl")
    rename_column :remboursements, :numero_bl,           :number         # numero_bl → number
    add_index       :remboursements, :number, name: "index_remboursements_on_number" unless index_exists?(:remboursements, :number, name: "index_remboursements_on_number")
    add_foreign_key :remboursements, :bls, column: :number, primary_key: "number", name: "fk_remboursements_number" unless foreign_key_exists?(:remboursements, :bls, column: :number, name: "fk_remboursements_number")

    remove_index :remboursements, :statut, name: "index_remboursements_on_statut" if index_exists?(:remboursements, :statut, name: "index_remboursements_on_statut")
    rename_column :remboursements, :statut,              :status            # statut → status
    add_index :remboursements, :status, name: "index_remboursements_on_status" unless index_exists?(:remboursements, :status, name: "index_remboursements_on_status")

    remove_index :remboursements, :reason_for_refund, name: "index_remboursements_on_reason_for_refund" if index_exists?(:remboursements, :reason_for_refund, name: "index_remboursements_on_reason_for_refund")
    rename_column :remboursements, :reason_for_refund,   :refund_reason     # reason_for_refund → refund_reason
    add_index :remboursements, :refund_reason, name: "index_remboursements_on_refund_reason" unless index_exists?(:remboursements, :refund_reason, name: "index_remboursements_on_refund_reason")
    rename_column :remboursements, :montant_demande,     :requested_amount  # montant_demande → requested_amount
  end
end
