# 🗄️ SQL Data Analysis & Database Design Portfolio

Welcome! This repository contains a collection of hands-on SQL projects demonstrating database design, relational integrity, date arithmetic, complex joins, and business metrics calculation using **MySQL**.

---

## 📌 Featured Projects
### 1. 📚 [Library Management System](./Library-Management)
* **Tech Stack**: MySQL Workbench, Relational Schema Design
* **Key Concepts**: FOREIGN KEY constraints, DATEDIFF() for fine calculation, CASE WHEN logic, LEFT JOIN for inventory detection.
* **Core Deliverable**: Calculated automated late fees and identified active vs. zero-demand catalog items.

### 2. 🛒 [E-Commerce Sales & Customer Analytics](./Ecommerce-Analytics)
* **Tech Stack**: MySQL Workbench
* **Key Concepts**: Multi-table JOINs, GROUP BY, SUM(), COUNT(DISTINCT), churn detection with IS NULL.
* **Core Deliverable**: Evaluated total platform revenue, top customer spenders, and inactive user cohorts.
*

### 3. 🚨 [Financial Transaction Fraud Analytics](./Fraud-Analytics)
* **Tech Stack**: MySQL Workbench, Advanced Window Functions
* **Key Concepts**: CTEs, Window Aggregations (`AVG() OVER`), Self-Joins, Time-Series Analysis (`TIMESTAMPDIFF`), Index Optimization.
* **Core Deliverable**: Engineered anomaly detection algorithms to identify impossible geographic travel and sudden transaction amount spikes.
*
### 4. 📈 [SaaS Subscription Engine & Churn Analytics](./Subscription-Analytics)
* **Tech Stack**: MySQL Workbench, Advanced Stateful Querying
* **Key Concepts**: Recursive CTEs, State Machine Reconstruction, Window Functions (`LAG`, `ROW_NUMBER`), Dynamic Date Generators.
* **Core Deliverable**: Designed a revenue attribution pipeline tracking MRR movement (Expansion, Contraction, Churn) and building time-series retention matrices.
*

## 🛠️ Technical SQL Skills Demonstrated
- **DDL & DML**: `CREATE TABLE`, `ALTER`, `FOREIGN KEY`, `AUTO_INCREMENT`, `INSERT INTO`
- **Data Aggregation**: `GROUP BY`, `HAVING`, `COUNT()`, `SUM()`
- **Advanced Joins**: `INNER JOIN`, `LEFT JOIN` (Identifying unlinked/inactive records)
- **Conditional & Date Logic**: `CASE WHEN`, `DATEDIFF()`, `CURRENT_DATE`
-
