-- Ejercicio 1
-- Editar un archivo de texto: simple. vhd con el siguiente prog
-- a) Compilar
-- b) Simular
-- c) Analizar resultados

ENTITY simple IS
END simple;

ARCHITECTURE prueba OF simple IS
    CONSTANT mensaje: String := "hola, mundo";
    SIGNAL canal: Character := ' ';
BEGIN
    p1: PROCESS
        BEGIN
            FOR i IN mensaje'Range LOOP
                canal <= mensaje(i);
                WAIT FOR 1 ns;
            END LOOP;
            WAIT;
        END PROCESS;	
END prueba;

-- Ejercicio 2
-- Modificar el anterior -agregando lo subrayado- y repetir items a), b) y c):

USE std.textio.all;
ENTITY simple IS
END simple;

ARCHITECTURE prueba OF simple IS
    CONSTANT mensaje: String := "hola, mundo";
    SIGNAL canal: Character := ' ';
BEGIN
    p1: PROCESS
    variable linea: line;
    variable dummy: side;
        BEGIN
            FOR i IN mensaje'Range LOOP
                canal <= mensaje(i);
                write(linea, mensaje(i), dummy,1);
                WAIT FOR 1 ns;
            END LOOP;
            writeline(output, linea);
            WAIT;
        END PROCESS;	
END prueba;