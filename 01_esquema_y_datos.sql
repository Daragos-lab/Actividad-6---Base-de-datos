--Limpieza preventiva de tablas previas si existen
GOTA MESASI EXISTE detalle_pedidos CASCADA;
GOTA MESASI EXISTE pedidos CASCADA;
GOTA MESASI EXISTEN productos CASCADE;
GOTA MESASI EXISTE categorias CASCADA;
GOTA MESASI EXISTEN clientes CASCADA;
--1. Tabla de Categorías
CREAR MESA categorías(
    id_categoríaDE SERIE CLAVE PRINCIPAL,
    nombreVARCHAR(50)NO NULOÚNICO,
    descripciónTEXTO
);
--2. Tabla de Clientes
CREAR MESA clientes(
    id_clienteDE SERIE CLAVE PRINCIPAL,
    nombreVARCHAR(100)NO NULO,
    correo electrónicoVARCHAR(100)NO NULOÚNICO,
    ciudadVARCHAR(50)NO NULO,
    teléfonoVARCHAR(20),
    saldoNUMÉRICO(10,2) POR DEFECTO0.00 CONTROLAR(saldo>= 0),
    activoBOOLEOVERDADERO POR DEFECTO,
    fecha_registroFECHAPOR DEFECTOFECHA_ACTUAL
);
--3. Tabla de Productos
CREAR MESA productos(
    id_productoDE SERIE CLAVE PRINCIPAL,
    nombreVARCHAR(120)NO NULO,
    id_categoríaINT NO NULO,
    precioNUMÉRICO(10,2)NO NULO CONTROLAR(precio> 0),
    existenciasINT NO NULOPOR DEFECTO0 CONTROLAR(existencias>= 0),
    descuento_porcentajeNUMÉRICO(5,2) POR DEFECTO0.00 CONTROLAR(descuento_porcentaje>= 0 Ydescuento_porcentaje<= 100),
    disponibleBOOLEOVERDADERO POR DEFECTO,
    RESTRICCIÓNfk_productos_categorías
        LLAVE EXTRANJERA(id_categoría)REFERENCIAScategorías(id_categoría)AL ELIMINARRESTRINGIR
);
--4. Tabla de Pedidos
CREAR MESA pedidos(
    id_pedidoDE SERIE CLAVE PRINCIPAL,
    id_clienteINT NO NULO,
    fecha_pedidoFECHAPOR DEFECTOFECHA_ACTUAL,
    estadoVARCHAR(20) POR DEFECTO'Pendiente' CONTROLAR(estadoEN('Pendiente','Pagado','Enviado','Entregado','Cancelado')),
    totalNUMÉRICO(10,2) POR DEFECTO0.00 CONTROLAR(total>= 0),
    RESTRICCIÓNfk_pedidos_clientes
        LLAVE EXTRANJERA(id_cliente)REFERENCIASclientes(id_cliente)EN CASCADA DE ELIMINACIÓN
);
--5. Tabla de Detalle de Pedidos
CREAR MESA detalle_pedidos(
    id_detalleDE SERIE CLAVE PRINCIPAL,
    id_pedidoINT NO NULO,
    id_productoINT NO NULO,
    cantidadINT NO NULO CONTROLAR(cantidad> 0),
    precio_unitarioNUMÉRICO(10,2)NO NULO CONTROLAR(precio_unitario> 0),
    total parcialNUMÉRICO(10,2)NO NULO CONTROLAR(total parcial> 0),
    RESTRICCIÓNfk_detalle_pedidos
        LLAVE EXTRANJERA(id_pedido)REFERENCIASpedidos(id_pedido)EN CASCADA DE ELIMINACIÓN,
    RESTRICCIÓNfk_detalle_productos
        LLAVE EXTRANJERA(id_producto)REFERENCIASproductos(id_producto)AL ELIMINARRESTRINGIR
);
--Inserción de Categorías
INSERTAR ENcategorias (nombre, descripcion)VALORES
('portátiles','Computadoras portátiles y accesorios'),
('teléfonos inteligentes','Teléfonos inteligentes y tabletas'),
('Audio','Auriculares, altavoces y micrófonos'),
('Monitores','Monitores para oficina, diseño y gaming.'),
('Accesorios','Periféricos, cables y complementos');
--Inserción de Clientes
INSERTAR ENclientes (nombre, correo electrónico, ciudad, teléfono, saldo, activo, fecha_registro)VALORES
('Carlos Mendoza','carlos.m@mail.com','Bogotá','3101112233',150.00, VERDADERO,'15/01/2023'),
('Lucía Fernández','lucia.f@mail.com','Medellín','3152223344',0.00, VERDADERO,'2023-02-20'),
('Andrés Torres','andres.t@mail.com','Cali','3183334455',45.50, VERDADERO,'10/03/2023'),
('Mariana Gómez','mariana.g@mail.com','Bogotá',NULO,320.00, VERDADERO,'5 de abril de 2023'),
('Javier Ortiz','javier.o@mail.com','Barranquilla','3205556677',0.00, FALSO,'12/11/2022'),
('Paula Morales','paula.m@mail.com','Medellín','3116667788',85.00, VERDADERO,'18/05/2023'),
('Diego Ramírez','diego.r@mail.com','Bucaramanga',NULO,0.00, VERDADERO,'22-06-2023'),
('Valentina Ríos','valentina.r@mail.com','Bogotá','3178889900',500.00, VERDADERO,'1 de julio de 2023'),
('Felipe Silva','felipe.s@mail.com','Cali','3129990011',12.00, FALSO,'8 de septiembre de 2022'),
('Camila Vargas','camila.v@mail.com','Cartagena','3190001122',0.00, VERDADERO,'14/08/2023');
--Inserción de Productos
INSERTAR ENproductos (nombre, id_categoria, precio, stock, descuento_porcentaje, disponible)VALORES
('Laptop Gamer Nitro 5',1,1200.00,15,10.00, VERDADERO),
('MacBook Air M2',1,1450.00,8,0.00, VERDADERO),
('Portátil ThinkPad E14',1,850.00,20,5.00, VERDADERO),
('iPhone 14 Pro',2,1100.00,12,0.00, VERDADERO),
('Samsung Galaxy S23',2,950.00,18,8.00, VERDADERO),
('Xiaomi Redmi Note 12',2,220.00,35,15.00, VERDADERO),
('Auriculares Sony WH-1000XM5',3,380.00,25,12.00, VERDADERO),
('AirPods Pro de 2.ª generación',3,260.00,30,0.00, VERDADERO),
('Parlante Bluetooth JBL Charge 5',3,140.00,0,0.00, FALSO),
('Monitor LG Ultrawide de 29"',4,280.00,14,5.00, VERDADERO),
('Monitor para juegos Samsung de 24" y 144 Hz',4,210.00,10,10.00, VERDADERO),
('Teclado Mecánico RGB Redragon',5,55.00,50,0.00, VERDADERO),
('Ratón Inalámbrico Logitech MX Master 3S',5,95.00,40,5.00, VERDADERO),
('Hub USB-C 7 en 1 Anker',5,45.00,0,0.00, FALSO),
('Base Refrigerante para Laptop',5,25.00,60,20.00, VERDADERO);
--Inserción de Pedidos
INSERTAR ENpedidos (id_cliente, fecha_pedido, estado, total)VALORES
(1,'1 de agosto de 2023','Entregado',1450.00),
(2,'3 de agosto de 2023','Entregado',475.00),
(3,'5 de agosto de 2023','Enviado',950.00),
(4,'6 de agosto de 2023','Entregado',1295.00),
(1,'10/08/2023','Pagado',280.00),
(6,'12/08/2023','Pendiente',380.00),
(7,'15/08/2023','Cancelado',1100.00),
(8,'18/08/2023','Entregado',1505.00),
(2,'2023-08-20','Enviado',220.00),
(4,'22-08-2023','Pagado',150.00);
--Inserción de Detalle de Pedidos
INSERTAR ENdetalle_pedidos (id_pedido, id_producto, cantidad, precio_unitario, subtotal)VALORES
(1,2,1,1450.00,1450.00),
(2,6,1,220.00,220.00),
(2,12,1,55.00,55.00),
(2,11,1,200.00,200.00),
(3,5,1,950.00,950.00),
(4,1,1,1200.00,1200.00),
(4,13,1,95.00,95.00),
(5,10,1,280.00,280.00),
(6,7,1,380.00,380.00),
(7,4,1,1100.00,1100.00),
(8,2,1,1450.00,1450.00),
(8,12,1,55.00,55.00),
(9,6,1,220.00,220.00),
(10,13,1,95.00,95.00),
(10,12,1,55.00,55.00);