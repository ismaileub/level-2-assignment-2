# PostgreSQL Basics

## What is PostgreSQL?

PostgreSQL is a powerful, open-source object-relational database management system (ORDBMS). It supports both SQL (relational) and JSON (non-relational) querying. Known for its stability, extensibility, and standards compliance, PostgreSQL is widely used for both small-scale and enterprise-level applications.

---

## Primary Key and Foreign Key Concepts in PostgreSQL

### Primary Key
- A **Primary Key** is a column or a set of columns that uniquely identifies each row in a table.
- It must contain unique values and cannot contain `NULL`s.
- A table can have only one Primary Key.

**Example:**
```sql
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL
);
```

### Foreign Key
- A **Foreign Key** is a column or a set of columns that establishes a link between the data in two tables.
- It references the Primary Key of another table to enforce referential integrity.

**Example:**
```sql
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id),
    amount DECIMAL(10, 2)
);
```

---

## Difference Between `VARCHAR` and `CHAR` Data Types

- **VARCHAR(n)**: Variable-length character string with a limit of `n` characters.
  - Uses only the required storage.
  - Preferred for strings of variable length.
- **CHAR(n)**: Fixed-length character string. Always stores exactly `n` characters.
  - Pads with spaces if the input is shorter than `n`.
  - Slightly faster for fixed-length data but less flexible.

**Example:**
```sql
name VARCHAR(50)
code CHAR(5)
```

---

## Purpose of the `WHERE` Clause in a `SELECT` Statement

The `WHERE` clause is used to filter records that meet a specified condition. It helps retrieve only those rows from a table that satisfy the condition(s).

**Example:**
```sql
SELECT * FROM users
WHERE username = 'john_doe';
```

---

## Modifying Data Using `UPDATE` Statements

The `UPDATE` statement is used to modify existing records in a table. It can target specific rows using the `WHERE` clause.

**Example:**
```sql
UPDATE users
SET username = 'jane_doe'
WHERE user_id = 1;
```

- Without a `WHERE` clause, all rows will be updated.
