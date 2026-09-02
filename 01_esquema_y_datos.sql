-- Limpieza preventiva de tablas previas si existen
DROP TABLE IF EXISTS detalle_pedidos CASCADE;
DROP TABLE IF EXISTS pedidos CASCADE;
DROP TABLE IF EXISTS productos CASCADE;
DROP TABLE IF EXISTS categorias CASCADE;
DROP TABLE IF EXISTS clientes CASCADE;

-- 1. Tabla de Categorías
CREATE TABLE categorias (
    id_categoria SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    descripcion TEXT
);

-- 2. Tabla de Clientes
CREATE TABLE clientes (
    id_cliente SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    ciudad VARCHAR(50) NOT NULL,
    telefono VARCHAR(20),
    saldo NUMERIC(10, 2) DEFAULT 0.00 CHECK (saldo >= 0),
    activo BOOLEAN DEFAULT TRUE,
    fecha_registro DATE DEFAULT CURRENT_DATE
);

-- 3. Tabla de Productos
CREATE TABLE productos (
    id_producto SERIAL PRIMARY KEY,
    nombre VARCHAR(120) NOT NULL,
    id_categoria INT NOT NULL,
    precio NUMERIC(10, 2) NOT NULL CHECK (precio > 0),
    stock INT NOT NULL DEFAULT 0 CHECK (stock >= 0),
    descuento_porcentaje NUMERIC(5, 2) DEFAULT 0.00 CHECK (descuento_porcentaje >= 0 AND descuento_porcentaje <= 100),
    disponible BOOLEAN DEFAULT TRUE,
    CONSTRAINT fk_productos_categorias 
        FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria) ON DELETE RESTRICT
);

-- 4. Tabla de Pedidos
CREATE TABLE pedidos (
    id_pedido SERIAL PRIMARY KEY,
    id_cliente INT NOT NULL,
    fecha_pedido DATE DEFAULT CURRENT_DATE,
    estado VARCHAR(20) DEFAULT 'Pendiente' CHECK (estado IN ('Pendiente', 'Pagado', 'Enviado', 'Entregado', 'Cancelado')),
    total NUMERIC(10, 2) DEFAULT 0.00 CHECK (total >= 0),
    CONSTRAINT fk_pedidos_clientes 
        FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente) ON DELETE CASCADE
);

-- 5. Tabla de Detalle de Pedidos
CREATE TABLE detalle_pedidos (
    id_detalle SERIAL PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL CHECK (cantidad > 0),
    precio_unitario NUMERIC(10, 2) NOT NULL CHECK (precio_unitario > 0),
    subtotal NUMERIC(10, 2) NOT NULL CHECK (subtotal > 0),
    CONSTRAINT fk_detalle_pedidos 
        FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido) ON DELETE CASCADE,
    CONSTRAINT fk_detalle_productos 
        FOREIGN KEY (id_producto) REFERENCES productos(id_producto) ON DELETE RESTRICT
);
-- Inserción de Categorías
INSERT INTO categorias (nombre, descripcion) VALUES
('Laptops', 'Computadores portátiles y accesorios'),
('Smartphones', 'Teléfonos inteligentes y tabletas'),
('Audio', 'Auriculares, altavoces y micrófonos'),
('Monitores', 'Monitores para oficina, diseño y gaming'),
('Accesorios', 'Periféricos, cables y complementos');

-- Inserción de Clientes
INSERT INTO clientes (nombre, email, ciudad, telefono, saldo, activo, fecha_registro) VALUES
('Carlos Mendoza', 'carlos.m@mail.com', 'Bogotá', '3101112233', 150.00, TRUE, '2023-01-15'),
('Lucía Fernández', 'lucia.f@mail.com', 'Medellín', '3152223344', 0.00, TRUE, '2023-02-20'),
('Andrés Torres', 'andres.t@mail.com', 'Cali', '3183334455', 45.50, TRUE, '2023-03-10'),
('Mariana Gómez', 'mariana.g@mail.com', 'Bogotá', NULL, 320.00, TRUE, '2023-04-05'),
('Javier Ortiz', 'javier.o@mail.com', 'Barranquilla', '3205556677', 0.00, FALSE, '2022-11-12'),
('Paula Morales', 'paula.m@mail.com', 'Medellín', '3116667788', 85.00, TRUE, '2023-05-18'),
('Diego Ramírez', 'diego.r@mail.com', 'Bucaramanga', NULL, 0.00, TRUE, '2023-06-22'),
('Valentina Ríos', 'valentina.r@mail.com', 'Bogotá', '3178889900', 500.00, TRUE, '2023-07-01'),
('Felipe Silva', 'felipe.s@mail.com', 'Cali', '3129990011', 12.00, FALSE, '2022-09-08'),
('Camila Vargas', 'camila.v@mail.com', 'Cartagena', '3190001122', 0.00, TRUE, '2023-08-14');

-- Inserción de Productos
INSERT INTO productos (nombre, id_categoria, precio, stock, descuento_porcentaje, disponible) VALUES
('Laptop Gamer Nitro 5', 1, 1200.00, 15, 10.00, TRUE),
('MacBook Air M2', 1, 1450.00, 8, 0.00, TRUE),
('Laptop ThinkPad E14', 1, 850.00, 20, 5.00, TRUE),
('iPhone 14 Pro', 2, 1100.00, 12, 0.00, TRUE),
('Samsung Galaxy S23', 2, 950.00, 18, 8.00, TRUE),
('Xiaomi Redmi Note 12', 2, 220.00, 35, 15.00, TRUE),
('Auriculares Sony WH-1000XM5', 3, 380.00, 25, 12.00, TRUE),
('AirPods Pro 2da Gen', 3, 260.00, 30, 0.00, TRUE),
('Parlante Bluetooth JBL Charge 5', 3, 140.00, 0, 0.00, FALSE),
('Monitor LG Ultrawide 29"', 4, 280.00, 14, 5.00, TRUE),
('Monitor Gamer Samsung 144Hz 24"', 4, 210.00, 10, 10.00, TRUE),
('Teclado Mecánico RGB Redragon', 5, 55.00, 50, 0.00, TRUE),
('Mouse Inalámbrico Logitech MX Master 3S', 5, 95.00, 40, 5.00, TRUE),
('Hub USB-C 7 en 1 Anker', 5, 45.00, 0, 0.00, FALSE),
('Base Refrigerante para Laptop', 5, 25.00, 60, 20.00, TRUE);

-- Inserción de Pedidos
INSERT INTO pedidos (id_cliente, fecha_pedido, estado, total) VALUES
(1, '2023-08-01', 'Entregado', 1450.00),
(2, '2023-08-03', 'Entregado', 475.00),
(3, '2023-08-05', 'Enviado', 950.00),
(4, '2023-08-06', 'Entregado', 1295.00),
(1, '2023-08-10', 'Pagado', 280.00),
(6, '2023-08-12', 'Pendiente', 380.00),
(7, '2023-08-15', 'Cancelado', 1100.00),
(8, '2023-08-18', 'Entregado', 1505.00),
(2, '2023-08-20', 'Enviado', 220.00),
(4, '2023-08-22', 'Pagado', 150.00);

-- Inserción de Detalle de Pedidos
INSERT INTO detalle_pedidos (id_pedido, id_producto, cantidad, precio_unitario, subtotal) VALUES
(1, 2, 1, 1450.00, 1450.00),
(2, 6, 1, 220.00, 220.00),
(2, 12, 1, 55.00, 55.00),
(2, 11, 1, 200.00, 200.00),
(3, 5, 1, 950.00, 950.00),
(4, 1, 1, 1200.00, 1200.00),
(4, 13, 1, 95.00, 95.00),
(5, 10, 1, 280.00, 280.00),
(6, 7, 1, 380.00, 380.00),
(7, 4, 1, 1100.00, 1100.00),
(8, 2, 1, 1450.00, 1450.00),
(8, 12, 1, 55.00, 55.00),
(9, 6, 1, 220.00, 220.00),
(10, 13, 1, 95.00, 95.00),
(10, 12, 1, 55.00, 55.00);
