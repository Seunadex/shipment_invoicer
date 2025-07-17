# Shipment Invoicer

A small Rails service to simulate invoice generation for overdue Bill of Ladings (BLs) in a legacy shipping database.

---

## 🚀 Setup Steps

1. **Clone the repository**

   ```bash
   git clone https://github.com/seunadex/shipment_invoicer.git
   cd shipment_invoicer
   ```

2. **Run setup script**

   ```bash
   bin/setup
   ```

3. **Run the server**

   ```bash
   rails server
   ```

---

### 🧱 Ruby Version

This project requires **Ruby 3.3.5**. You can install it using a version manager like [`rbenv`](https://github.com/rbenv/rbenv) or [`asdf`](https://asdf-vm.com/).

```bash
# Example using rbenv
rbenv install 3.3.5
rbenv local 3.3.5
```

---

## 🧪 Running Tests

Run the full test suite using RSpec:

```bash
bundle exec rspec
```

To run a specific spec:

```bash
bundle exec rspec spec/requests/api/invoices/generation_spec.rb
```

---

## 🧾 Sample cURL Requests

### Generate invoices for overdue BLs:

```bash
curl -X POST http://localhost:3000/api/invoices/generate_overdue
```

### Sample Response:

```json
[
  {
    "id": 12,
    "reference": "INV20240716-001",
    "number": "BL20240716X",
    "client_code": "CUST001",
    "client_name": "ABC Logistics",
    "amount": 240,
    "status": "init",
    "invoice_date": "2025-07-17T00:00:00Z"
  }
]
```

### View overdue invoices in browser (JSON):

```
http://localhost:3000/invoices/overdue.json
```

### Or using curl:

```bash
curl http://localhost:3000/invoices/overdue.json
```

---

## 💡 Design Decisions & Assumptions

- **Legacy Schema Adaptation:** The system adapts a legacy French-named MySQL schema into idiomatic Rails models. Fields like `numero_bl` were renamed to `number`, `id_client` to `customer_id`, and relationships were inferred and enforced via associations and foreign keys.

- **Invoice Generation Logic:** A service object (`Demurrage::InvoiceGenerator`) checks for BLs that became overdue today and generates invoices at a flat rate of $80 per container per overdue day. Container count is computed as the sum of all six legacy `quantity_*` fields on the Bill of Lading.

- **Skip Logic for Open Invoices:** BLs are skipped if they already have any unpaid (status: `"init"`) invoices. This ensures that only one open invoice exists per overdue BL at a time.

- **Refund Guard Logic:** BLs that are flagged as `blocked_for_refund`, `exempt` or have associated refund requests (`remboursements`) with active statuses are excluded from invoicing. Only fully cancelled or absent refunds qualify.

- **Factory & Test Constraints:** FactoryBot and Faker are used in specs with character limits enforced to avoid validation errors (e.g. trimming names to ≤ 20 characters).

---
