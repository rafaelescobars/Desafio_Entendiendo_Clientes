--------------------------------------------Comienzo desafio-------------------------------------


--Desactivar autocommit
\set AUTOCOMMIT false

--Realizar compra por partr frl cliente usuario01
BEGIN TRANSACTION;
    UPDATE public.producto SET stock = stock - 5 WHERE descripcion='producto9';
    INSERT INTO public.compra (cliente_id, fecha)VALUES ((SELECT id FROM public.cliente WHERE nombre='usuario01'), CURRENT_DATE);
    INSERT INTO public.detalle_compra (producto_id, compra_id, cantidad) VALUES ((SELECT id FROM public.producto WHERE descripcion='producto9'), (SELECT MAX(id) FROM public.compra), 5);
COMMIT;

--Compras cliente usuario02 producto1, 2 y 8, cantidad: 3 c/u, fecha del sistema
--producto1
BEGIN TRANSACTION;
    UPDATE public.producto SET stock = stock - 3 WHERE descripcion='producto1';
    INSERT INTO public.compra (cliente_id, fecha)VALUES ((SELECT id FROM public.cliente WHERE nombre='usuario02'), CURRENT_DATE);
    INSERT INTO public.detalle_compra (producto_id, compra_id, cantidad) VALUES ((SELECT id FROM public.producto WHERE descripcion='producto1'), (SELECT MAX(id) FROM public.compra), 3);
COMMIT;

--producto2
BEGIN TRANSACTION;
    UPDATE public.producto SET stock = stock - 3 WHERE descripcion='producto2';
    INSERT INTO public.compra (cliente_id, fecha)VALUES ((SELECT id FROM public.cliente WHERE nombre='usuario02'), CURRENT_DATE);
    INSERT INTO public.detalle_compra (producto_id, compra_id, cantidad) VALUES ((SELECT id FROM public.producto WHERE descripcion='producto2'), (SELECT MAX(id) FROM public.compra), 3);
COMMIT;

--producto8
BEGIN TRANSACTION;
    UPDATE public.producto SET stock = stock - 3 WHERE descripcion='producto8';
    INSERT INTO public.compra (cliente_id, fecha)VALUES ((SELECT id FROM public.cliente WHERE nombre='usuario02'), CURRENT_DATE);
    INSERT INTO public.detalle_compra (producto_id, compra_id, cantidad) VALUES ((SELECT id FROM public.producto WHERE descripcion='producto8'), (SELECT MAX(id) FROM public.compra), 3);
COMMIT;

--Habilitar autocommit
\set AUTOCOMMIT true

--Desabilitar autocommit
\set AUTOCOMMIT false

--Crear checkpoint
SAVEPOINT checkpoint_01;

--Insertar nuevo cliente
INSERT INTO public.cliente (nombre, email) VALUES ('usuario11','usuario11@gmail.com');

--confirmar que el usuario fue agregado en la tabla cliente
SELECT * from public.cliente WHERE nombre='usuario11';

--Realizar rollback
ROLLBACK TO checkpoint_01;

--Confirmar que se restauró la información
SELECT * from public.cliente;

--Habilitar autocommit
\set AUTOCOMMIT true