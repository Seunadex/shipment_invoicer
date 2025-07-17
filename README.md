
# Shipment Invoicer

A small Rails service to simulate invoice generation for overdue Bill of Ladings (BLs) in a legacy shipping database.

---

## 🚀 Setup Steps

1. **Clone the repository**

   ```bash
   git clone https://github.com/seunadex/shipment_invoicer.git
   cd shipment_invoicer
   ```

2. **Install dependencies**

   ```bash
   bundle install
   ```

3. **Set up the database**

   ```bash
   rails db:create db:migrate db:seed
   ```

4. **Run the server**
   ```bash
   rails server
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
http://localhost:3000/invoices/overdue
```

### Or using curl:

```bash
curl -X http://localhost:3000/invoices/overdue.json
```

---

## 💡 Design Decisions & Assumptions

- **Legacy Schema Adaptation:** The system adapts a legacy French-named MySQL schema into idiomatic Rails models. Fields like `numero_bl` were renamed to `number`, `id_client` to `customer_id` and relationships were inferred using best practices.

- **Invoice Generation Logic:** A service object (`Demurrage::InvoiceGenerator`) checks for BLs that became overdue today and generates invoices at a flat rate of $80 per container per day. Container count is calculated as the sum of all `quantity_*` columns on the bill_of_ladding.

- **Skip Logic:** BLs with any unpaid (status: `"init"`) invoices are skipped to prevent duplicates. Paid invoices are ignored.

- **API & View Separation:** Invoice generation is triggered via a JSON-only API endpoint, while overdue invoices can be viewed either as JSON. The API is namespaced under `/api/invoices`.

---
