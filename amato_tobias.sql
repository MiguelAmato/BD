-- Práctica realizada por Miguel Amato y Alejandro Tobías 

-- 1.   Muestra el nombre de los canales y el tiempo total dedicado a documentales 
--      en el mes de diciembre de 2017 de aquellos canales que han emitido m´as de 3 documentales en ese periodo.

        SELECT C.NOMBRE, SUM(A.DURACION) AS TIEMPO
        FROM PR5_CANAL C
            JOIN PR5_PROGRAMACION P     -- ESTA MAL 
                ON C.IDCANAL = P.IDCANAL
            JOIN PR5_PROGRAMA A
                ON A.CODPROGRAMA = P.CODPROGRAMA
        WHERE EXTRACT(MONTH FROM P.FEC_HORA) = 12 AND 
              EXTRACT (YEAR FROM P.FEC_HORA) = 2017 AND 
              A.TIPO = 'documental'
              GROUP BY C.NOMBRE 
              HAVING COUNT (*) > 3;
              

--2.    Muestra el nombre de los canales que emiten m´as de 2 documentales 
--      distintos el mismo d´?a. NOTA: recuerda que puedes agrupar por columnas, pero tambien por expresiones (con operadores, funciones, etc.).
 
 
-- 3.   Muestra el nombre de los canales que han programado alg´un programa con una 
--      duraci´on mayor a la de ’Lo que el viento se llevo’, junto con el t´?tulo del programa y su duraci´on.

    SELECT C.NOMBRE, A.TITULO,A.DURACION
    FROM PR5_CANAL C 
        JOIN PR5_PROGRAMACION P
            ON C.IDCANAL = P.IDCANAL
        JOIN PR5_PROGRAMA A
            ON A.CODPROGRAMA = P.CODPROGRAMA
    WHERE A.DURACION > (SELECT DURACION
                        FROM PR5_PROGRAMA 
                        WHERE TITULO = 'Lo que el viento se llevo');
                    

-- 4.   Muestra el t´?tulo de los documentales que no se han emitido nunca en el canal con nombre ’Antena Sexta’.

    SELECT DISTINCT A.TITULO 
    FROM PR5_PROGRAMA A
        JOIN PR5_PROGRAMACION P     
             USING(CODPROGRAMA)
        JOIN PR5_CANAL C
             USING(IDCANAL)
    WHERE A.TIPO = 'documental' AND 
          A.TITULO NOT IN (SELECT PR5_PROGRAMA.TITULO 
                           FROM PR5_PROGRAMA 
                                JOIN PR5_PROGRAMACION 
                                    USING (CODPROGRAMA)
                                JOIN PR5_CANAL
                                    USING (IDCANAL)
                           WHERE PR5_CANAL.NOMBRE = 'Antena Sexta');
                           
-- 5.   Para los programas que se emiten en alg´un canal, muestra el t´?tulo del programa y el nombre del canal en el 
--      que se emite de aquellos programas que cumplen la siguiente condici´on: la duraci´on del programa es mayor a 
--      la duraci´on media de los programas emitidos en ese mismo canal.

    SELECT A.TITULO, C.NOMBRE 
    FROM PR5_PROGRAMA A
        JOIN PR5_PROGRAMACION P
            USING (CODPROGRAMA)
        JOIN PR5_CANAL C
            USING(IDCANAL)
    WHERE A.DURACION > (SELECT AVG(DURACION)
                        FROM PR5_PROGRAMA);
       
                        
-- 6.   Muestra el t´?tulo de los programas de mayor duraci´on 
--      de cada tipo de los emitidos en el mismo mes en cualquier canal.
                           
        SELECT TITULO 
        FROM PR5_PROGRAMA
        WHERE DURACION IN (SELECT MAX(DURACION)
                           FROM PR5_PROGRAMA)
        
        
    
    
        