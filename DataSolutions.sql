-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         11.6.2-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.8.0.6908
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- PARTE 1 --

-- 1. Creación y Configuración de la Base de Datos (MySQL) --
-- Volcando estructura de base de datos para datasolutionsdb
CREATE DATABASE IF NOT EXISTS `datasolutionsdb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_uca1400_ai_ci */;
USE `datasolutionsdb`;

-- Volcando estructura para tabla datasolutionsdb.clientes
CREATE TABLE IF NOT EXISTS `clientes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  `apellido` varchar(50) DEFAULT NULL,
  `ciudad` varchar(50) DEFAULT NULL,
  `fecha_registro` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;


-- Volcando datos para la tabla datasolutionsdb.clientes: ~10 rows (aproximadamente)
INSERT INTO `clientes` (`id`, `nombre`, `apellido`, `ciudad`, `fecha_registro`) VALUES
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

-- 2. Creacion de Usuarios: --

-- Creacion del usuarios consultor
CREATE USER 'consultor'@'localhost' IDENTIFIED BY '';
GRANT USAGE ON *.* TO 'consultor'@'localhost';
GRANT SELECT  ON `datasolutionsdb`.* TO 'consultor'@'localhost';
FLUSH PRIVILEGES;

-- Creacion del usuario admin_venta         
CREATE USER 'admin_venta'@'localhost' IDENTIFIED BY '';
GRANT USAGE ON *.* TO 'admin_venta'@'localhost';
GRANT SELECT, INSERT, UPDATE  ON TABLE `datasolutionsdb`.`clientes` TO 'admin_venta'@'localhost';
FLUSH PRIVILEGES;

-- 3. OPTIMIZACION DE CONSULTAS: --
-- Creacion índices 

CREATE INDEX idx_ciudad_fecha ON clientes (ciudad, fecha_registro);

-- Optimizacion de las consultas
EXPLAIN SELECT * 
FROM clientes 
WHERE ciudad = 'Madrid' AND fecha_registro > '2024-01-01';

-- Visualizacion y gestion de los procesos
SHOW PROCESSLIST;

KILL <id_proceso>;


-- PARTE 2 Administración de Datos con SQLite --
-- Volcando estructura de base de datos para clientes.db en Sqlite3
CREATE DATABASE IF NOT EXISTS clientes.db;
USE clientes.db;

-- Tabla: clientes
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

-- Insercion de datos en la tabla clientes
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


-- Parte 3: Automatización de Tareas y Seguridad --

-- 1. Copias de seguridad --

-- Creacion tabla de backup de clientes
CREATE TABLE IF NOT EXISTS clientes_backup LIKE clientes;
INSERT INTO clientes_backup SELECT * FROM clientes;

-- Backup con MYSQLDUMP en el CMD de Windows 
    -- modificar el usuario y el nombre del usuario en la ruta
mysqldump -u usuario -p DataSolutionsDB clientes > C:/Users/NombreUsuario/Downloads/clientes_backup.sql

-- Fichero .bat para crear un backup automatico
    -- Modificar User, password y UserName en Path
@echo off
:: === Configura tus datos aquí ===
set MYSQL_USER=User
set MYSQL_PASSWORD=****
set MYSQL_DATABASE=DataSolutionsDB
set MYSQL_TABLE=clientes
set BACKUP_PATH=C:\Users\UserName\Downloads\clientes_backup.sql
set MYSQL_BIN_PATH="C:\Program Files\MariaDB 11.6\bin"

:: === Realiza el volcado de la tabla ===
%MYSQL_BIN_PATH%\mysqldump.exe -u %MYSQL_USER% -p%MYSQL_PASSWORD% %MYSQL_DATABASE% %MYSQL_TABLE% > "%BACKUP_PATH%"

echo.
echo Backup completado! El file si encuentra in Downloads.

pause

-- Creacion de un backup de datos de la tabla clientes en formato csv
SELECT * FROM clientes INTO OUTFILE 'clientes_backup.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n';


-- 2. Procedimientos almacenados --
-- Al insertar un nuevo cliente verifica que el campo fecha_registro no sea una fecha futura.

-- Creacion del procedimiento almacenado
DELIMITER //
CREATE PROCEDURE InsertarClienteSeguro(
    IN nombre VARCHAR(255),
    IN apellido VARCHAR(255),
    IN ciudad VARCHAR(100),
    IN fecha_registro DATE,
    OUT mensaje VARCHAR(255)
)
BEGIN
    -- Validamos que la fecha no sea futura
    IF fecha_registro > CURDATE() THEN
        SET mensaje = 'Error: Esta no es una maquina del tiempo';
    ELSE
        -- Si la fecha es válida, insertamos el cliente
        INSERT INTO clientes (nombre, apellido, ciudad, fecha_registro)
        VALUES (nombre, apellido, ciudad, fecha_registro);
        SET mensaje = 'Cliente insertado correctamente';
    END IF;
END //
DELIMITER ;

-- Para lanzar el procedimiento hay que ejecutar
CALL InsertarClienteSeguro('Juan', 'Pérez', 'Madrid', '2025-05-10', @mensaje);
SELECT @mensaje; -- Verifica si hubo error o éxito


-- 3. Disparador (Trigger)  --
-- Trigger para registrar los cambios realizados (datos_nuevos)*/

-- Creacion de la tabla log_clientes
CREATE TABLE IF NOT EXISTS log_clientes (
    id INT NOT NULL AUTO_INCREMENT,
    fecha_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    usuario VARCHAR(50) NULL,
    operacion VARCHAR(20) NULL,
    datos_antiguos VARCHAR(255) NULL,
    datos_nuevos VARCHAR(255) NULL,
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Creacion del trigger
DELIMITER //
CREATE TRIGGER tr_clientes
AFTER UPDATE ON clientes
FOR EACH ROW
BEGIN
    -- Compreba si el nombre cambia
    IF NEW.nombre != OLD.nombre THEN
        INSERT INTO log_clientes (usuario, operacion, datos_antiguos, datos_nuevos)
        VALUES (CURRENT_USER(), 'UPDATE', OLD.nombre, NEW.nombre);
    END IF;
    
    -- Verifica si cambia el apellido
    IF NEW.apellido != OLD.apellido THEN
        INSERT INTO log_clientes (usuario, operacion, datos_antiguos, datos_nuevos)
        VALUES (CURRENT_USER(), 'UPDATE', OLD.apellido, NEW.apellido);
    END IF;
    
	 -- Verifica si la cidad cambia
    IF NEW.ciudad != OLD.ciudad THEN
        INSERT INTO log_clientes (usuario, operacion, datos_antiguos, datos_nuevos)
        VALUES (CURRENT_USER(), 'UPDATE', OLD.ciudad, NEW.ciudad);
    END IF;
    
    -- Comprueba si la fecha_registro cambia
    IF NEW.fecha_registro != OLD.fecha_registro THEN
        INSERT INTO log_clientes (usuario, operacion, datos_antiguos, datos_nuevos)
        VALUES (CURRENT_USER(), 'UPDATE', OLD.fecha_registro, NEW.fecha_registro);
    END IF;
END//
DELIMITER ;

-- Para probar el trigger, actualizamos un cliente
UPDATE clientes SET ciudad = 'Modena' WHERE id = 1;

--PARTE 4: Planificación de Tareas --

-- 1. Planificación de Copias de Seguridad:--
-- Creacion de un archivo .bat utilizando mysqldump para realizar copias de seguridad automáticas de la base de datos.

    -- Modificar el usuario y la contraseña
@echo Starting BackUp

set MYSQL_BIN="C:\Program Files\MariaDB 5.5\bin\mysqldump.exe"
set DB_USER=Usuario
set DB_PASS=****
set DB_NAME=DataSolutionsDB
set BACKUP_DIR="C:\BackupMySQL"

:: Crea carpeta si no existe
if not exist %BACKUP_DIR% mkdir %BACKUP_DIR%

:: Genera nombre file con data
set BACKUP_FILE=%DB_NAME%_%DATE:/=-%.sql

:: Ejecuta backup
%MYSQL_BIN% -u%DB_USER% -p%DB_PASS% %DB_NAME% > %BACKUP_DIR%\%BACKUP_FILE%

echo Backup completado en %BACKUP_DIR%\%BACKUP_FILE%
pause

/*Planificación automática con el Programador de tareas de Windows:

Busca "Programador de tareas" en el menú de Inicio
Crear tarea:
Acción → "Crear tarea básica"
Nombre: "Copia de seguridad diaria de MySQL"
Disparador: Diario (por ejemplo, a las 23:00)
Acción: "Iniciar un programa"
Programa: C:\ruta\backup_mysql.bat
Finalizando: "Finalizar".
*/

-- 2. Monitoreo del Rendimiento: --

-- Query para ver las conexiones activas y las consultas en ejecución
    SELECT * 
    FROM information_schema.processlist;

-- Comando para ver los proces activos
SHOW FULL PROCESSLIST;

-- Establecer un número máximo de conexiones para optimizar los recursos
SET GLOBAL max_connections = [numero];

-- Mostrar las consultas en ejecución desde hace más de 10 segundos.
SELECT * FROM information_schema.processlist 
WHERE COMMAND != 'Sleep' AND TIME > 10
ORDER BY TIME DESC;


/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
