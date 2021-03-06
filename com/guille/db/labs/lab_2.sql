-- First query.
SELECT nombrem, ciudadm FROM marcas WHERE ciudadm='barcelona';

-- Second query.
-- A)
SELECT * FROM clientes WHERE ciudad='madrid' AND apellido='garcia';
-- B)
SELECT * FROM clientes WHERE ciudad='madrid' OR apellido='garcia';

-- Third query.
SELECT apellido, ciudad FROM clientes;

-- 4
SELECT apellido FROM clientes WHERE ciudad='madrid';

-- 5
SELECT DISTINCT nombrem FROM marcas, marco, coches WHERE coches.codcoche=marco.codcoche AND marco.cifm=marcas.cifm AND coches.modelo='gtd';

-- 6
SELECT DISTINCT nombrem FROM marcas, marco, coches, ventas WHERE marcas.cifm=marco.cifm AND marco.codcoche=coches.codcoche AND coches.codcoche=ventas.codcoche AND ventas.color='rojo';

-- 7
SELECT nombrech FROM coches WHERE modelo=(SELECT modelo FROM coches WHERE nombrech='cordoba');

-- 8
SELECT DISTINCT nombrech FROM coches WHERE modelo NOT IN (SELECT modelo FROM coches WHERE nombrech='cordoba');

-- 9
SELECT * FROM concesionarios

-- 10
-- A)
SELECT cifm, dni FROM marcas, clientes WHERE marcas.ciudadm=clientes.ciudad;
--B)
SELECT cifm, dni FROM marcas, clientes WHERE marcas.ciudadm!=clientes.ciudad;

-- 11
SELECT codcoche from coches, distribucion, concesionarios WHERE coches.codcoche=distribucion.codcoche AND distribucion.cifc=concesionarios.cifc AND concesionarios.ciudadc='barcelona';

-- 12
SELECT codcoche from coches, ventas, concesionarios, clientes WHERE coches.codcoche=ventas.codcoche AND ventas.cifc=concesionarios.cifc AND ventas.dni=clientes.dni AND concesionarios.ciudadc='madrid' AND clientes.ciudad='madrid';

-- 13
SELECT codcoche from coches, ventas, concesionarios, clientes WHERE coches.codcoche=ventas.codcoche AND ventas.cifc=concesionarios.cifc AND ventas.dni=clientes.dni AND concesionarios.ciudadc=clientes.ciudad;

-- 14
SELECT DISTINCT c1.nombrem, c2.nombrem FROM marcas c1, marcas c2 WHERE c1.ciudadm=c2.ciudadm AND c1.nombrem!=c2.nombrem;

-- 15
SELECT * FROM clientes WHERE ciudad='madrid';

-- 16
SELECT DISTINCT dni FROM clientes, ventas, concesionarios WHERE clientes.dni=ventas.dni AND ventas.cifc=concesionarios.cifc AND concesionarios.ciudadc='madrid';

-- 17
SELECT DISTINCT color from ventas, concesionarios WHERE ventas.cifc=concesionarios.cifc AND concesionarios.nombrec='acar';

-- 18
SELECT codcoche FROM ventas, concesionarios where ventas.cifc=concesionarios.cifc AND concesionarios.ciudadc='madrid';


-- 19 
SELECT nombre FROM clientes, ventas, concesionarios WHERE clientes.dni=ventas.dni AND ventas.cifc=concesionarios.cifc AND concesionarios.nombrec='dcar';

-- 20 
SELECT nombre, apellido FROM clientes, ventas, coches WHERE clientes.dni=ventas.dni AND ventas.codcoche=coches.codcoche AND coches.modelo='gti' AND ventas.color='blanco';

-- 21 
SELECT DISTINCT nombre, apellido FROM clientes, ventas, concesionarios WHERE clientes.dni=ventas.dni AND ventas.cifc=concesionarios.cifc AND concesionarios.cifc IN (SELECT cifc from concesionarios, distribucion, coches WHERE concesionarios.cifc=distribucion.cifc AND distribucion.codcoche=coches.codcoche AND coches.modelo='gti');

-- 22 
SELECT dni, nombre, apellido FROM clientes where dni IN

-- 22 
(SELECT dni FROM clientes, ventas WHERE clientes.dni=ventas.dni AND ventas.color='blanco' GROUP BY clientes.dni, clientes.nombre, clientes.apellido) AND dni IN (SELECT dni FROM clientes, ventas WHERE clientes.dni=ventas.dni AND ventas.color='rojo' GROUP BY clientes.dni, clientes.nombre, clientes.apellido)

-- 23 
SELECT DISTINCT dni FROM clientes, ventas WHERE clientes.dni=ventas.dni AND ventas.cifc='1' AND dni NOT IN (SELECT DISTINCT dni FROM clientes, ventas WHERE clientes.dni=ventas.dni AND ventas.cifc!='1');

-- 24 
SELECT  nombre FROM clientes WHERE dni NOT IN (SELECT dni FROM clientes, ventas, concesionarios WHERE clientes.dni=ventas.dni AND ventas.cifc=concesionarios.cifc AND concesionarios.ciudadc='madrid' AND ventas.color='rojo');

-- 25 
SELECT cifc, SUM(cantidad) FROM concesionarios, distribucion WHERE concesionarios.cifc=distribucion.cifc GROUP BY concesionarios.cifc;

-- 26 
SELECT DISTINCT cifc, AVG(distribucion.cantidad) media FROM distribucion, concesionarios WHERE distribucion.cifc=concesionarios.cifc and cantidad > 10 GROUP BY cifc

-- 27 
SELECT DISTINCT cifc, SUM(distribucion.cantidad) stock FROM distribucion, concesionarios WHERE distribucion.cifc=concesionarios.cifc GROUP BY cifc HAVING SUM(distribucion.cantidad) >=10 AND SUM(distribucion.cantidad) <=18

-- 28 
SELECT COUNT(marcas.nombrem) FROM marcas WHERE marcas.ciudadm='madrid';

-- 29 
SELECT nombre, apellido FROM clientes, ventas, concesionarios WHERE clientes.dni=ventas.dni AND ventas.cifc=concesionarios.cifc AND concesionarios.ciudadc='madrid' AND clientes.nombre LIKE 'j%';

-- 30 
SELECT nombre, apellido FROM clientes ORDER BY clientes.nombre

-- 31 
SELECT DISTINCT nombre, apellido FROM clientes, ventas, concesionarios WHERE clientes.dni=ventas.dni AND ventas.cifc=concesionarios.cifc AND concesionarios.cifc IN (SELECT cifc FROM concesionarios, ventas WHERE concesionarios.cifc=ventas.cifc AND ventas.dni='1');

-- 32 
SELECT cifc cif, nombrec nombre, ciudadc ciudad, AVG(cantidad) cantidad FROM distribucion, concesionarios WHERE concesionarios.cifc=distribucion.cifc GROUP BY distribucion.cifc, concesionarios.nombrec, concesionarios.ciudadc HAVING AVG(cantidad) > (SELECT AVG(cantidad) FROM distribucion);
