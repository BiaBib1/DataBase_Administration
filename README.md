# DataSolution SQL Project

This project provides a comprehensive SQL script for database administration, automation, and optimization using both MySQL/MariaDB and SQLite. The script is organized into several parts, each focusing on a different aspect of database management.

## Contents

- **Database Creation and Configuration (MySQL/MariaDB)**
  - Creates a database named `DataSolutions`.
  - Defines a `clientes` table with fields for ID, name, surname, city, and registration date.
  - Inserts sample data into the `clientes` table.

- **User Management**
  - Creates two users:
    - `consultor`: Read-only access to all tables.
    - `admin_venta`: Read, insert, and update permissions on the `clientes` table.

- **Query Optimization**
  - Demonstrates the use of indexes to optimize queries on the `clientes` table.
  - Uses `EXPLAIN` to analyze query execution plans.

- **Process Management**
  - Shows how to list and kill active database processes.

- **Data Administration with SQLite**
  - Replicates the `clientes` table structure and data in SQLite.
  - Demonstrates basic data insertion.

- **Automation and Security**
  - Provides SQL and batch scripts for creating backups of the `clientes` table.
  - Includes a stored procedure to validate data integrity (e.g., preventing future registration dates).
  - Implements a trigger to log changes to the `clientes` table in an audit table.

- **Task Scheduling**
  - Shows how to automate backups using Windows batch scripts and Task Scheduler.

- **Performance Monitoring**
  - Describes how to monitor database performance using tools like DBeaver and HeidiSQL.
  - Includes queries for monitoring active processes and long-running queries.

## How to Use

1. **MySQL/MariaDB**: Run the SQL sections in your MySQL/MariaDB environment to set up the database, tables, users, and automation features.
2. **SQLite**: Use the SQLite sections to create and populate the `clientes` table in a local SQLite database.
3. **Backup and Automation**: Adapt the provided batch scripts for your environment to automate backups.
4. **Monitoring**: Use the suggested queries and tools to monitor and optimize your database performance.

## Notes

- Modify user names, passwords, and file paths in the scripts as needed for your environment.
- The script is intended for educational and demonstration purposes.
