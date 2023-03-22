select * from project..tabla

--PREGUNTA 1 
-- SELECCIONANDO DATOS Y MOSTRAR EL MONTO TOTAL DE TRANSACCIONES POR BARRIO PARA LUEGO SACAR EL PORCENTAJE

select nombre_barrio, num_cliente, SUM(mnt_total_trx) as 'Monto Transacciones por cliente',
ROUND(100* SUM(mnt_total_trx) / (SELECT SUM(mnt_total_trx)FROM Project..tabla),2) AS 'Porcentaje'
from Project..tabla
group by nombre_barrio, num_cliente
order by SUM(mnt_total_trx) DESC

-- SUMA TOTAL DE MONTO
SELECT SUM(mnt_total_trx) as 'Monto Total de transacciones' from project..tabla 


-- CREANDO UNA TABLA PARA LUEGO SACAR PORCENTAJES 

CREATE TABLE TABLA2(TRX float,
BARRIO varchar(50))

SELECT CONVERT(VARCHAR(100), BARRIO)
FROM TABLA2

--- CREANDO NUEVA TABLA PARA ANALIZAR MONTO POR BARRIO
INSERT INTO TABLA2 (TRX, BARRIO)
Select mnt_total_trx, nombre_barrio
from project..tabla;

select BARRIO, SUM(TRX) as 'Monto Transacciones por Barrio', ROUND(SUM(TRX)/159433327802087 * 100,1) AS 'PORCENTAJE'
from TABLA2
group by BARRIO
order by ROUND(SUM(TRX)/159433327802087 * 100,1) desc

-- alter table TABLA2 adding porcentaje
ALTER TABLE TABLA2
add PORCENTAJE float;
UPDATE TABLA2
SET PORCENTAJE = TRX/159433327802087 * 100

--- saber la suma total de porcentaje
-- SUBQUERY OF TOTAL SUM 
SELECT SUM(TRX) as 'SUMA TOTAL' from TABLA2
SELECT * FROM TABLA2

-- AGRUPAR CANTIDAD TOTAL DE TRANSACCIONES POR BARRIO

SELECT DISTINCT BARRIO, SUM(TRX) AS 'SUMA DE TRANSACCIONES', ROUND(100 * SUM(TRX) / (SELECT SUM(TRX) FROM TABLA2),2) AS 'PORCENTAJE'
FROM TABLA2
group by BARRIO
ORDER BY 'PORCENTAJE' DEsc
--PREGUNTA 2: CUALES SON LOS DISPOSITIVOS DE TRANSACCIONES DE ALMENOS 100 CLIENTES DIFERENTES 
-- lista total de clientes y sus dispositivos 
select distinct TOP 100 num_cliente, tipo_dispositivo 
from project..tabla
order by tipo_dispositivo


--PREGUNTA 3 
--Cuáles son los 5 barrios donde la mayor cantidad de clientes únicos realizan transacciones en dispositivos tipo POS? La respuesta debe incluir la cantidad de clientes asociados a estos barrios.

SELECT nombre_barrio, num_cliente, tipo_dispositivo from project..tabla
where tipo_dispositivo = 'POS'
order by num_cliente

select num_cliente, nombre_barrio from project..tabla
where tipo_dispositivo = 'POS'

SELECT nombre_barrio,  COUNT( DISTINCT num_cliente) as 'Clientes Distintos'
FROM project..tabla
where tipo_dispositivo = 'POS' 
group by nombre_barrio 
ORDER BY COUNT(DISTINCT num_cliente) DESC;

-- PREGUNTA 4 
-- 4.	¿Cuáles son las 10 distancias únicas (en kilómetros) de los dispositivos más alejados entre sí del barrio Sucre?

SELECT DISTINCT(nombre_barrio), latitud, longitud from project..tabla order by nombre_barrio
 
 --crear una funcion para saber los valores en kms utilizando la latitud y longitud 

DECLARE @start geography, @end geography
SET @start = geography::Point(3.446585795, -76.52194317, 4326) -- sucre
SET @end = geography::Point(3.45173452, -76.48469759, 4326) -- Siete de Agosto
-- El siguiente query nos muestra de manera descendente el barrio más lejano de sucre hasta el más cercano en kms 

DECLARE @sucre geography;
SET @sucre = geography::Point(3.446585795, -76.52194317, 4326);
SELECT TOP 10 nombre_barrio, ROUND(AVG(geography::Point(Latitud, Longitud, 4326).STDistance(@sucre)/1000),1) AS 'Distancia en KM del Barrio Sucre'
FROM project..tabla
GROUP BY nombre_barrio
ORDER BY ROUND(AVG(geography::Point(Latitud, Longitud, 4326).STDistance(@sucre)/1000),1) DESC;
