-- ===================================================
-- TALLER PRÁCTICO: CONSULTAS DML SQL
-- Estudiante: Cristian Quiroga
-- Fecha: 2026-08-25
-- Engine: PostgreSQL
-- ===================================================

-- ---------------------------------------------------
-- BLOQUE 1: Filtros, Ordenamiento y Selección Básica
-- ---------------------------------------------------

-- Ejercicio 1: Consulta general
-- Obtener nombre, email, ciudad y saldo de clientes activos ordenados por nombre.
SELECT nombre, email, ciudad, saldo
FROM clientes
WHERE activo IS TRUE
ORDER BY nombre ASC;

-- Ejercicio 2: Filtrado por rango
-- Listar productos cuyo precio esté comprendido entre $100.00 y $500.00.
SELECT nombre, precio, stock
FROM productos
WHERE precio >= 100.00 AND precio <= 500.00;

-- Ejercicio 3: Búsqueda por patrones
-- Obtener clientes con correo dominios @mail.com ubicados en Bogotá o Medellín.
SELECT id_cliente, nombre, email, ciudad, telefono, saldo, activo, fecha_registro
FROM clientes
WHERE ciudad IN ('Bogotá', 'Medellín')
  AND email LIKE '%@mail.com';

-- Ejercicio 4: Valores nulos y operadores lógicos
-- Identificar clientes sin número telefónico en el sistema.
SELECT nombre, ciudad
FROM clientes
WHERE telefono IS NULL;

-- Ejercicio 5: Cálculo de columnas derivadas
-- Listado de productos indicando precio original, descuento y precio final calculado.
SELECT nombre, 
       precio, 
       descuento_porcentaje,
       ROUND(precio * (1 - (descuento_porcentaje / 100.0)), 2) AS precio_con_descuento
FROM productos;

-- Ejercicio 6: Top y ordenamiento descendente
-- Consultar los 3 artículos disponibles de mayor valor monetario.
SELECT *
FROM productos
WHERE disponible IS TRUE
ORDER BY precio DESC
LIMIT 3;


-- ---------------------------------------------------
-- BLOQUE 2: Funciones Agregadas y Agrupación
-- ---------------------------------------------------

-- Ejercicio 7: Métricas globales
-- Obtener total de registros, promedio, precio mínimo y precio máximo en catálogo.
SELECT COUNT(id_producto) AS total_productos,
       ROUND(AVG(precio)::numeric, 2) AS precio_promedio,
       MIN(precio) AS precio_minimo,
       MAX(precio) AS precio_maximo
FROM productos;

-- Ejercicio 8: Conteo agrupado
-- Contabilizar la cantidad de clientes activos agrupados por ciudad.
SELECT ciudad, COUNT(1) AS total_clientes_activos
FROM clientes
WHERE activo = TRUE
GROUP BY ciudad;

-- Ejercicio 9: Suma agrupada
-- Calcular los ingresos acumulados según el estado del pedido.
SELECT estado, SUM(total) AS total_recaudado
FROM pedidos
GROUP BY estado;

-- Ejercicio 10: Promedio y filtrado de grupos
-- Mostrar categorías con un precio promedio superior a $300.00.
SELECT id_categoria, ROUND(AVG(precio)::numeric, 2) AS precio_promedio
FROM productos
GROUP BY id_categoria
HAVING AVG(precio) > 300.00;

-- Ejercicio 11: Conteo con condición agrupada
-- Filtrar clientes que registren más de 1 pedido generado.
SELECT id_cliente, COUNT(id_pedido) AS total_pedidos
FROM pedidos
GROUP BY id_cliente
HAVING COUNT(id_pedido) > 1;

-- Ejercicio 12: Métricas de inventario
-- Sumatoria total de existencias en stock por categoría, orden de mayor a menor.
SELECT id_categoria, SUM(stock) AS total_stock
FROM productos
GROUP BY id_categoria
ORDER BY total_stock DESC;


-- ---------------------------------------------------
-- BLOQUE 3: Actualización e Integridad de Datos (UPDATE)
-- ---------------------------------------------------

-- Ejercicio 13: Actualización simple
-- Reasignar el saldo a $100.00 para el registro id_cliente = 2.
UPDATE clientes
SET saldo = 100.00
WHERE id_cliente = 2;

-- Ejercicio 14: Actualización con cálculo porcentual
-- Aplicar incremento del 10% en precios para productos de la categoría 1.
UPDATE productos
SET precio = ROUND(precio * 1.10, 2)
WHERE id_categoria = 1;

-- Ejercicio 15: Actualización condicional múltiple
-- Deshabilitar disponibilidad de artículos cuyo stock sea 0.
UPDATE productos
SET disponible = FALSE
WHERE stock = 0;

-- Ejercicio 16: Actualización masiva de estado
-- Actualizar pedidos en estado 'Enviado' hacia 'Entregado'.
UPDATE pedidos
SET estado = 'Entregado'
WHERE estado = 'Enviado';


-- ---------------------------------------------------
-- BLOQUE 4: Inserciones y Eliminaciones (INSERT, DELETE)
-- ---------------------------------------------------

-- Ejercicio 17: Inserción de nuevo registro
-- Insertar datos del estudiante como nuevo cliente activo.
INSERT INTO clientes (nombre, email, ciudad, telefono, saldo, activo, fecha_registro)
VALUES ('Cristian Quiroga', 'cristian.quiroga@mail.com', 'Medellín', '3000000000', 250.00, TRUE, CURRENT_DATE);

-- Ejercicio 18: Subconsulta de comparación
-- Listar productos con precio mayor al promedio general de la tienda.
SELECT nombre, precio
FROM productos
WHERE precio > (SELECT AVG(precio) FROM productos);

-- Ejercicio 19: Eliminación condicional
-- Depurar registros de clientes inactivos con saldo igual a cero.
DELETE FROM clientes
WHERE activo IS FALSE 
  AND saldo = 0.00;

-- Ejercicio 20: Subconsulta con borrado selectivo
-- Borrado de detalles y pedidos en estado 'Cancelado'.
DELETE FROM detalle_pedidos
WHERE id_pedido IN (
    SELECT id_pedido 
    FROM pedidos 
    WHERE estado = 'Cancelado'
);

DELETE FROM pedidos
WHERE estado = 'Cancelado';
message.txt
6 KB