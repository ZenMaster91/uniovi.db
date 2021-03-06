-- 1 
SELECT au_nombre NOMBRE, au_apellido APELLIDO FROM autores

-- 2 
SELECT titulo TITULO, ventas_previstas*precio REVENUE FROM titulos

-- 3 
SELECT titulo, ventas_previstas FROM titulos WHERE ventas_previstas<=500 AND ventas_previstas>=200

-- 4 
SELECT au_nombre FROM autores WHERE autores.au_telefono IS NULL;

-- 5 
SELECT titulo_id, titulo, ventas_previstas FROM titulos WHERE titulos.tipo='BD' OR titulos.tipo='PROG' ORDER BY titulos.precio DESC;

-- 6 
SELECT au_nombre, au_apellido FROM autores WHERE au_telefono LIKE '456%';

-- 7
-- A) 
SELECT AVG(precio) FROM titulos;
-- B)
SELECT AVG(precio) FROM titulos WHERE titulos.tipo='BD'

-- 8
-- A)
SELECT ed_id,COUNT(titulo_id) FROM editoriales, titulos WHERE titulos.ed_id=editoriales.ed_id GROUP BY editoriales.ed_id;
-- B)
SELECT ed_id, tipo, COUNT(titulo_id) FROM editoriales, titulos WHERE titulos.ed_id=editoriales.ed_id GROUP BY editoriales.ed_id, titulos.tipo;

-- 9 
SELECT tipo, COUNT(tipo) FROM titulos GROUP BY titulos.tipo 

-- 10 
SELECT tipo, AVG(precio) FROM titulos WHERE titulos.f_publicacion>'2000-01-01' GROUP BY titulos.tipo;

-- 11 
SELECT tipo, COUNT(tipo) FROM titulos GROUP BY titulos.tipo HAVING COUNT(tipo)>1

-- 12 
SELECT tipo, AVG(PRECIO) FROM titulos GROUP BY titulos.tipo HAVING AVG(precio)>35

-- 13 
SELECT ed_id, ed_nombre, AVG(precio) FROM editoriales, titulos WHERE titulos.ed_id=editoriales.ed_id AND editoriales.ed_id>2 GROUP BY ed_id, ed_nombre HAVING AVG(precio)>60 ORDER BY ed_id

-- 14 
SELECT editor_nombre, editor_apellido, orden_editores FROM editores, tituloseditores, titulos WHERE titulos.titulo_id=tituloseditores.titulo_id AND tituloseditores.editor_id=editores.editor_id AND titulos.titulo_id='1';

-- 15 
SELECT editor_nombre, ed_nombre FROM editoriales, editores WHERE editoriales.ed_ciudad=editores.editor_ciudad

-- 16 
SELECT titulo, au_nombre, orden_autores FROM titulos, titulosautores, autores WHERE titulos.titulo_id=titulosautores.titulo_id AND titulosautores.au_id=autores.au_id AND titulos.tipo='BD';

-- 17 
SELECT editor_nombre, e1.editor_apellido, e2.editor_nombre FROM editores e1, editores e2 WHERE e1.editor_jefe=e2.editor_id;

-- 18 
SELECT a1.au_id, a1.au_nombre, a1.au_apellido, a2.au_id, a2.au_nombre, a2.au_apellido FROM autores a1, autores a2 WHERE a1.au_apellido=a2.au_apellido AND a1.au_id!=a2.au_id;

-- 19 
SELECT ed_nombre FROM editoriales, titulos WHERE titulos.ed_id = editoriales.ed_id AND titulos.tipo='PROG';

-- 20 
SELECT titulo, precio FROM titulos WHERE titulos.precio=(SELECT MIN(precio) FROM titulos);

-- 21 
SELECT au_nombre, au_ciudad FROM autores WHERE au_ciudad=(SELECT au_ciudad FROM autores WHERE au_nombre='Abraham' AND au_apellido='Silberschatz')

-- 22 
SELECT au_nombre, au_apellido FROM autores, titulosautores WHERE autores.au_id=titulosautores.au_id AND porcentaje_participacion<1 AND au_id IN (SELECT au_id FROM autores, titulosautores WHERE autores.au_id=titulosautores.au_id AND porcentaje_participacion=1);

-- 23
-- A
SELECT tipo FROM titulos, editoriales WHERE titulos.ed_id=editoriales.ed_id GROUP BY tipo HAVING count(ed_id)>1;
-- B (Second option)
SELECT DISTINCT tipo FROM titulos WHERE tipo IN (SELECT tipo FROM titulos, editoriales WHERE titulos.ed_id=editoriales.ed_id GROUP BY tipo HAVING count(ed_id)>1)

-- 24
CREATE VIEW AVERAGES_BY_TYPE AS SELECT tipo, AVG(precio) AVERAGE FROM titulos GROUP BY tipo;
SELECT DISTINCT titulo, average FROM titulos, averages_by_type WHERE titulos.tipo=averages_by_type.tipo AND titulos.precio*2 = averages_by_type.average;

-- 25
SELECT titulo FROM titulos WHERE pre_publicacion > (SELECT MAX(pre_publicacion) FROM editoriales, titulos WHERE titulos.ed_id = editoriales.ed_id AND editoriales.ed_nombre='Prentice Hall');

-- 26
SELECT titulo FROM titulos, editoriales WHERE titulos.ed_id=editoriales.ed_id AND editoriales.ed_ciudad LIKE 'B%';

-- 27
-- A
SELECT ed_nombre FROM editoriales WHERE ed_id NOT IN (SELECT DISTINCT ed_id FROM editoriales, titulos WHERE editoriales.ed_id=titulos.ed_id and tipo='BD');
