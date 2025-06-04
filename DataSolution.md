# DataSolution.sql

---

## Metadata

```
Host:                         Bianca Razzoli
Server Version:               MP0224
Server OS:                    UF1470
Database:                     DataSolutionsDB
Programming Languages:        MariaDB, SQLite, Batch
Versions:                     MariaDB-11.6.2, HeidiSQL 12.8.0.6908, SQLiteStudio v3.4.17
```

---

## INDEX

- **PART 1: MySQL Database Creation and Configuration**
  - 1. Database and Table Creation (MySQL)
  - 2. User Creation
  - 3. Query Optimization
  - 4. Process Management

- **PART 2: Data Administration with SQLite**
  - 1. Database Creation
  - 2. Table Creation
  - 3. Data Insertion

- **PART 3: Task Automation and Security**
  - 1. Backups
  - 2. Stored Procedures
  - 3. Trigger

- **PART 4: Task Scheduling**
  - 1. Backup Scheduling
  - 2. Performance Monitoring

- **CONCLUSIONS**
- **WEBGRAPHY**

---

## PART 1: MySQL Database Creation and Configuration

### 1. Database and Table Creation (MySQL)

We will create a database called DataSolutionDB with MySQL and, inside it, a table called clientes.
We will define the fields of the table with their respective values and constraints,
for example, the 'id' field as integer, auto-increment, and primary key.

```sql
CREATE DATABASE IF NOT EXISTS `datasolutionsdb`;
USE `datasolutionsdb`;

CREATE TABLE IF NOT EXISTS `clientes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  `apellido` varchar(50) DEFAULT NULL,
  `ciudad` varchar(50) DEFAULT NULL,
  `fecha_registro` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb;
```

### 2. Data Insertion


Insert data into the table with all fields filled.

```sql
INSERT INTO `clientes` (`id`, `nombre`, `apellido`, `ciudad`, `fecha_registro`) 
VALUES
    (1, 'Ana', 'Garcia', 'Madrid', '2024-02-02'),
    (2, 'Maria', 'Lopez', 'Tarragona', '2025-03-06'),
    (3, 'Gorka', 'Martinez', 'Valencia', '2022-10-18'),
    (4, 'David', 'Perez', 'Barcelona', '2020-11-19'),
    (5, 'Julia', 'Maion', 'Valladolid', '2021-09-26'),
    (6, 'Esteban', 'Soresina', 'Sevilla', '2022-04-24'),
    (7, 'Francisco', 'Arko', 'Granada', '2023-06-11'),
    (8, 'Lorea', 'Nazabal', 'Bilbao', '2022-01-25'),
    (9, 'Idoia', 'Gurmendi', 'Donostia', '2025-03-22'),
    (10, 'Uxua', 'Arego', 'Pamplona', '2022-11-03');
```

### 3. User Creation


Create two users with their respective permissions using CREATE USER and GRANT:
   - 'consultor': read-only on all tables
   - 'admin_venta': read, insert, and update on the clientes table
FLUSH PRIVILEGES is used to update user permissions.

```sql
CREATE USER 'consultor'@'localhost' IDENTIFIED BY '';
GRANT USAGE ON *.* TO 'consultor'@'localhost';
GRANT SELECT  ON `datasolutionsdb`.* TO 'consultor'@'localhost';
FLUSH PRIVILEGES;
           
CREATE USER 'admin_venta'@'localhost' IDENTIFIED BY '';
GRANT USAGE ON *.* TO 'admin_venta'@'localhost';
GRANT SELECT, INSERT, UPDATE  ON TABLE `datasolutionsdb`.`clientes`
TO 'admin_venta'@'localhost';
FLUSH PRIVILEGES;
```

### 4. Query Optimization


Creating indexes is recommended to optimize queries, especially when searching on specific columns, like:

```sql
SELECT *
FROM clientes
WHERE ciudad = 'Madrid' AND fecha_registro > '2024-01-01';

/* Create indexes with CREATE INDEX, e.g. idx_ciudad_fecha on ciudad and fecha_registro. */
CREATE INDEX idx_ciudad_fecha ON clientes (ciudad, fecha_registro);

/* Use EXPLAIN to analyze the execution plan of the query. */
EXPLAIN SELECT *
FROM clientes
WHERE ciudad = 'Madrid' AND fecha_registro > '2024-01-01';
```

### 5. Process Management

```sql
/* SHOW PROCESSLIST displays running processes, KILL <id> kills a process. */
SHOW PROCESSLIST;
KILL <id_proceso>;
```

---

## PART 2: Data Administration with SQLite

### 1. Database and Table Creation


Create a clientes.db database in Sqlite3, with the clientes table and the same fields as in MySQL.

```sql
CREATE DATABASE IF NOT EXISTS clientes.db;
USE clientes.db;

CREATE TABLE IF NOT EXISTS clientes (
    id             INTEGER,
    nombre         TEXT,
    apellido       TEXT,
    ciudad         TEXT,
    fecha_registro NUMERIC,
    PRIMARY KEY (
        id
    )
);
```

### 2. Data Insertion

```sql
INSERT INTO clientes (id, nombre, apellido, ciudad, fecha_registro)
VALUES (1, 'Ana', 'Garcia', 'Madrid', '2024-02-02');
INSERT INTO clientes (id, nombre, apellido, ciudad, fecha_registro)
VALUES (2, 'Maria', 'Lopez', 'Tarragona', '2025-03-06');
INSERT INTO clientes (id, nombre, apellido, ciudad, fecha_registro)
VALUES (3, 'Gorka', 'Martinez', 'Valencia', '2022-10-18');
INSERT INTO clientes (id, nombre, apellido, ciudad, fecha_registro)
VALUES (4, 'David', 'Perez', 'Barcelona', '2020-11-19');
INSERT INTO clientes (id, nombre, apellido, ciudad, fecha_registro)
VALUES (5, 'Julia', 'Maion', 'Valladolid', '2021-09-26');
INSERT INTO clientes (id, nombre, apellido, ciudad, fecha_registro)
VALUES (6, 'Esteban', 'Soresina', 'Sevilla', '2022-04-24');
INSERT INTO clientes (id, nombre, apellido, ciudad, fecha_registro)
VALUES (7, 'Francisco', 'Arko', 'Granada', '2023-06-11');
INSERT INTO clientes (id, nombre, apellido, ciudad, fecha_registro)
VALUES (8, 'Lorea', 'Nazabal', 'Bilbao', '2024-01-02');
INSERT INTO clientes (id, nombre, apellido, ciudad, fecha_registro)
VALUES (9, 'Idoia', 'Gurmendi', 'Donostia', '2025-03-22');
INSERT INTO clientes (id, nombre, apellido, ciudad, fecha_registro)
VALUES (10, 'Uxua', 'Arego', 'Pamplona', '2022-11-03');
```

---

## PART 3: Task Automation and Security

### 1. Backups


Create a backup table for clientes, with the same structure, and insert a copy of the data.

```sql
CREATE TABLE IF NOT EXISTS clientes_backup LIKE clientes;
INSERT INTO clientes_backup SELECT * FROM clientes;
```

#### MySQLDump Command


Use MYSQLDUMP in Windows CMD to create backups in different formats (sql, csv)

```bash
# Modify user and username in the path
mysqldump -u usuario -p DataSolutionsDB clientes > C:/Users/NombreUsuario/Downloads/clientes_backup.sql
```

#### Batch Script for Automatic Backup

```batch
@echo off
:: === Configure your data here ===
set MYSQL_USER=User
set MYSQL_PASSWORD=****
set MYSQL_DATABASE=DataSolutionsDB
set MYSQL_TABLE=clientes
set BACKUP_PATH=C:\Users\UserName\Downloads\clientes_backup.sql
set MYSQL_BIN_PATH="C:\Program Files\MariaDB 11.6\bin"

:: === Dump the table ===
%MYSQL_BIN_PATH%\mysqldump.exe -u %MYSQL_USER% -p%MYSQL_PASSWORD% %MYSQL_DATABASE% %MYSQL_TABLE% > "%BACKUP_PATH%"

echo.
echo Backup completed! The file is in Downloads.

pause
```

#### CSV Backup

Create a backup of clientes in CSV format in the folder C:\Program Files\MariaDB 11.6\data\datasolutionsdb

```sql
SELECT * FROM clientes INTO OUTFILE 'clientes_backup.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n';
```

### 2. Stored Procedures


Create a stored procedure to validate data integrity when inserting a new client.
This procedure checks that fecha_registro is not a future date.

```sql
DELIMITER //
CREATE PROCEDURE InsertarClienteSeguro(
    IN nombre VARCHAR(255),
    IN apellido VARCHAR(255),
    IN ciudad VARCHAR(100),
    IN fecha_registro DATE,
    OUT mensaje VARCHAR(255)
)
BEGIN
    -- Validate that the date is not in the future
    IF fecha_registro > CURDATE() THEN
        SET mensaje = 'Error: Esta no es una máquina del tiempo';
    ELSE
        -- If the date is valid, insert the client
        INSERT INTO clientes (nombre, apellido, ciudad, fecha_registro)
        VALUES (nombre, apellido, ciudad, fecha_registro);
        SET mensaje = 'Cliente insertado correctamente';
    END IF;
END //
DELIMITER ;

-- To run the procedure:
CALL InsertarClienteSeguro('Juan', 'Pérez', 'Madrid', '2025-05-10', @mensaje);
SELECT @mensaje; -- Check for error or success
```

### 3. Trigger


Triggers are automatic procedures executed in the database in response to specific events.
Here we create a trigger that activates AFTER an UPDATE on the clientes table.
We also create an audit table called log_clientes to record changes.

```sql
CREATE TABLE IF NOT EXISTS log_clientes (
    id INT NOT NULL AUTO_INCREMENT,
    fecha_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    usuario VARCHAR(50) NULL,
    operacion VARCHAR(20) NULL,
    datos_antiguos VARCHAR(255) NULL,
    datos_nuevos VARCHAR(255) NULL,
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DELIMITER //
CREATE TRIGGER tr_clientes
AFTER UPDATE ON clientes
FOR EACH ROW
BEGIN
    -- Check if the name changes
    IF NEW.nombre != OLD.nombre THEN
        INSERT INTO log_clientes (usuario, operacion, datos_antiguos, datos_nuevos)
        VALUES (CURRENT_USER(), 'UPDATE', OLD.nombre, NEW.nombre);
    END IF;
   
    -- Check if the surname changes
    IF NEW.apellido != OLD.apellido THEN
        INSERT INTO log_clientes (usuario, operacion, datos_antiguos, datos_nuevos)
        VALUES (CURRENT_USER(), 'UPDATE', OLD.apellido, NEW.apellido);
    END IF;
   
    -- Check if the city changes
    IF NEW.ciudad != OLD.ciudad THEN
        INSERT INTO log_clientes (usuario, operacion, datos_antiguos, datos_nuevos)
        VALUES (CURRENT_USER(), 'UPDATE', OLD.ciudad, NEW.ciudad);
    END IF;
   
    -- Check if the registration date changes
    IF NEW.fecha_registro != OLD.fecha_registro THEN
        INSERT INTO log_clientes (usuario, operacion, datos_antiguos, datos_nuevos)
        VALUES (CURRENT_USER(), 'UPDATE', OLD.fecha_registro, NEW.fecha_registro);
    END IF;
END//
DELIMITER ;
```

```sql
-- To test the trigger, update a client
UPDATE clientes SET ciudad = 'Modena' WHERE id = 1;
```

---

## PART 4: Task Scheduling

### 1. Backup Scheduling (Batch Script)

```batch
@echo Starting BackUp

set MYSQL_BIN="C:\Program Files\MariaDB 5.5\bin\mysqldump.exe"
set DB_USER=Usuario
set DB_PASS=****
set DB_NAME=DataSolutionsDB
set BACKUP_DIR="C:\BackupMySQL"

:: Create folder if it doesn't exist
if not exist %BACKUP_DIR% mkdir %BACKUP_DIR%

:: Generate file name with date
set BACKUP_FILE=%DB_NAME%_%DATE:/=-%.sql

:: Run backup
%MYSQL_BIN% -u%DB_USER% -p%DB_PASS% %DB_NAME% > %BACKUP_DIR%\%BACKUP_FILE%

echo Backup completed in %BACKUP_DIR%\%BACKUP_FILE%
pause
```

#### Windows Task Scheduler Instructions

```
Automatic scheduling with Windows Task Scheduler:

- Search for "Task Scheduler" in the Start menu
- Create task:
  - Action → "Create Basic Task"
  - Name: "Daily MySQL Backup"
  - Trigger: Daily (e.g., at 23:00)
  - Action: "Start a program"
  - Program: C:\path\backup_mysql.bat
  - Finish: "Finish"
```

### 2. Performance Monitoring

##### DBeaver
Performance Panel:
Database Menu > Performance > Real-time panel shows:
- Active queries
- CPU/RAM usage
- Query latency
Execution Plan:
Right-click on a query > Explain execution plan to analyze index usage


##### HeidiSQL
Select the desired connection
In the top bar
Select Processes


The query would be:
```sql
SELECT *
FROM information_schema.processlist;
```

Shows all active connections and running queries, providing details such as which user is connected and what query is being executed.
A more detailed version of SHOW PROCESSLIST.

```sql
SHOW FULL PROCESSLIST;
```

You can also set a maximum number of connections to optimize resources:
```sql
SET GLOBAL max_connections = [number];
```

Shows queries running for more than 10 seconds.
```sql
SELECT * FROM information_schema.processlist
WHERE COMMAND != 'Sleep' AND TIME > 10
ORDER BY TIME DESC;
```

---

## CONCLUSIONS

Part 1: MySQL Configuration
- Database creation and user management with well-defined roles (consultor, admin_ventas), following the principle of least privilege.
- Query optimization with indexes to avoid full table scans.

Process management:
- SHOW PROCESSLIST and KILL are essential for resolving blocking or runaway queries.

Part 2: SQLite for Local Data
- Creation of a lightweight database (clientes.db) with a well-structured table.

Part 3: Automation and Security
- Backup: The script for copying the clientes table ensures disaster recovery.
- Data validation: The stored procedure with future date control prevents integrity errors.
- Trigger: The script logs modifications, which is crucial for accountability.

Part 4: Scheduling and Monitoring
- Automatic backups: Using .bat scripts (Windows) with the task scheduler ensures continuity.

Monitoring tools:
- DBeaver / HeidiSQL for visual analysis.
- SHOW FULL PROCESSLIST and slow query logs to diagnose bottlenecks.


---

## WEBGRAPHY

- UF1470_SGBD_administracion  
- UF1470_Administracion_MYSQL  
- UF1470-EXPLAIN  
- SQLite  
- https://www.w3schools.com/mysql/default.asp  
- https://todohacker.com/tutoriales/lenguaje-batch  
- https://dev.mysql.com/doc/refman/8.4/en/trigger-syntax.html  
- https://chatgpt.com/  
- https://www.deepseek.com/  