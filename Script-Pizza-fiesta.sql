CREATE database Pizza_Fiesta;
use Pizza_Fiesta;

create table tamaños(ID int primary key, tamaño enum("grande", "mediana", "pequeña") not null, precio decimal not null);
create table cliente (ID int primary key, nombre varchar(50) not null, direccion varchar(100), telefono varchar(13));
create table pago(ID int primary key, pago enum("realizado", "en espera") not null, N_transaccion varchar(50), hora time);
create table producto(ID int primary key, 
nombre varchar(50) not null,
categoria varchar(50) not null,
precioU decimal not null,
marca varchar(50),
cantidad int default(0), 
id_tamaño int, foreign key(id_tamaño) references tamaños(ID) );

create table combos (ID int primary key, 
nombre varchar(50) not null, 
pizza int,
bebida int,
precio decimal not null, 
foreign key(pizza) references producto(ID),
foreign key(bebida) references producto(ID)
);

create table pedido(ID int primary key, 
cliente int, 
pizza int, 
bebida int,
tamaño_pizza int, 
combo int,
cantidad_bebidas int default(0),
cantidad_pizza int, 
ingre_adicionla enum ("maiz", "tocineta", "carne", "pollo", "champiñones"), 
fecha_hora datetime, precio_total decimal not null, 
pago int, 
foreign key (pago) references pago(ID), 
foreign key(cliente) references cliente(ID),
foreign key(pizza) references producto(ID),
foreign key(bebida) references producto(ID),
foreign key(tamaño_pizza) references tamaños(ID),
foreign key(combo) references combos(ID));

-- consultas

insert into pago values (1,"realizado","123432212", "3:00" );
insert into combos values (1, "rancheco", 1, 2, 14000)
insert into combos values (3, "ranchefa", 1, 5, 12000)

insert into tamaños values (2, "mediana", 7000 );
-- 1 **Registrar un nuevo cliente:**

insert into cliente values (1, "jennifer Arcs", "cra 20-19", "12345678901");



-- 2**Agregar un nuevo producto (pizza) al menú:**
insert into producto values (1, "ranchera", "pizza", 10000, "casa", 1, 1);
insert into producto values (6, "mega ranchera", "pizza", 100000, "casa", 1, 1);

-- 3 **Registrar una bebida en el menú:**
insert into producto (ID, nombre, categoria, precioU, marca,cantidad ) values (2, "coca cola", "bebida", 3500, "coca cola", 1);
insert into producto (ID, nombre, categoria, precioU, marca,cantidad ) values (5, "fanta", "bebida", 2000, "fanta", 1);

-- 4. **Agregar un ingrediente a la base de datos:**
insert into producto (ID, nombre, categoria, precioU, marca,cantidad ) values (3,"salsa tomate", "ingrediente", 3000, "fruco", 1);

-- 5. **Crear un pedido para un cliente:** 
insert into pedido (ID, cliente, pizza, bebida, tamaño_pizza, cantidad_pizza, cantidad_bebidas, fecha_hora, precio_total, pago )
values (2, 1, 1, 2, 1,1,2, "2025-02-19 3:00", 17000, 1);


insert into pedido (ID, cliente, pizza, bebida, tamaño_pizza, cantidad_pizza, cantidad_bebidas, fecha_hora, precio_total, pago )
values (4, 1, 1, 2, 1,1,2, "2025-02-19 5:00", 17000, 1);

insert into pedido (ID, cliente, pizza, bebida, tamaño_pizza, cantidad_pizza, cantidad_bebidas, fecha_hora, precio_total, pago )
values (5, 1, 5, 2, 1,1,2, "2025-02-19 5:00", 12000, 1);

insert into pedido (ID, cliente, pizza, bebida, tamaño_pizza, cantidad_pizza, cantidad_bebidas, fecha_hora, precio_total, pago )
values (6, 1, 5, 1, 2,1,2, "2025-02-19 5:00", 9000, 1);
-- 6**Añadir productos a un pedido específico:**
insert into pedido (ID, cliente, pizza, bebida, tamaño_pizza, cantidad_pizza, cantidad_bebidas, ingre_adicionla, fecha_hora, precio_total, pago )
values (3, 1, 1, 2, 1,1,2, "tocineta", "2025-02-19 3:00", 17000, 1);

-- 13 **Consultar todos los pedidos de un cliente:**
SELECT c.nombre, p.ID, p.pizza, p.bebida, p.ingre_adicionla, p.precio_total
from pedido p
join cliente c on p.cliente = c.ID;


-- 14. **Listar todos los productos disponibles en el menú (pizzas y bebidas):**
SELECT nombre, cantidad, categoria 
from producto p 
where categoria  in("pizza","bebida");


-- 15 Listar todos los ingredientes disponibles para personalizar una pizza:
SELECT nombre
from producto
where categoria = 'ingrediente' 



-- 18. **Buscar pedidos programados para recogerse después de una hora específica:**
SELECT c.nombre, p.fecha_hora, p2.nombre, t.tamaño
from pedido p
join cliente c on p.cliente = c.ID
join producto p2 on p.pizza = p2.ID
join tamaños t on p.tamaño_pizza = t.ID 
where fecha_hora = "2025-02-19 5:00";

-- 19. **Listar todos los combos de pizzas con bebidas disponibles en el menú:**

SELECT nombre 
FROM combos 
where bebida is not null;

-- 20. **Buscar pizzas con un precio mayor a $100:**
SELECT ID, nombre
from producto 
where precioU >= 100000;

-- 21. calcular el total de ingresos por día, semana y mes. 
select sum(precio_total) as ingresoDia
from pedido
where fecha_hora = "2025-02-19 3:00";



