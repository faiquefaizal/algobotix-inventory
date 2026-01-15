# 📦 AlgoBotix Inventory Manager

A high-performance, offline-first Flutter application engineered for precise stock control and inventory auditing. Built with a focus on data integrity, reactive state management, and modern UX.

---

## 🚀 Key Features

### 📦 Product Management
- **Full CRUD Operations:** Seamlessly add, edit, and remove products with a validated form interface.
- **Unique Alphanumeric IDs:** Automatically generates collision-resistant 5-character IDs for every product, optimized for QR identification.
- **Visual Assets:** Integrated image cataloging via camera and gallery with local path persistence.

### 📸 Smart Scanning
- **High-Speed QR Scanner:** Instant product lookup using the `mobile_scanner` engine.
- **Custom Viewfinder:** A professionally engineered masking overlay for precise barcode targeting and improved UX.

### 📊 Stock Auditing
- **Relational History Logging:** Every stock change (add/remove) is automatically tracked in a dedicated `stock_history` table.
- **Visual Status Indicators:** Logical separation of stock increments vs. decrements for rapid reconciliation.
- **Time-Stamped Logs:** Detailed chronological auditing for all inventory movements.

### 🔍 Search & UI
- **Real-time Search:** Instant filtering of the inventory list by product name.
- **Centralized Theming:** Consistent brand identity across all screens via a dedicated Material 3 Design System.

---

## 🛠 Technical Architecture

This project utilizes a **Layered Architecture** to ensure maintainability and scalability:

- **State Management:** [BLoC/Cubit Pattern](https://pub.dev/packages/flutter_bloc) for a decoupled, testable, and reactive business logic layer.
- **Database:** [SQLite](https://pub.dev/packages/sqflite) with Foreign Key constraints and cascading deletes to ensure strict data integrity.
- **Data Persistence:** Relational schema optimized for performance and 100% offline reliability.



---

## ⚙️ Setup & Installation

1. **Clone the repository:**
   ```bash

   git clone [https://github.com/faiquefaizal/algobotix-inventory.git](https://github.com/faiquefaizal/algobotix-inventory.git)
