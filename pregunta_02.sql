-- 
--  La tabla `data` tiene la siguiente estructura:
-- 
--    K0  CHAR(1)
--    K1  INT
--    c12 FLOAT
--    c13 INT
--    c14 DATE
--    c15 FLOAT
--    c16 CHAR(4)
-- 
--  Escriba una consulta que retorne la cantidad de registros
--  de la tabla `tbl1`.
-- 
--  Rta/
--     COUNT(*)
--  0        30
--
--  >>> Escriba su codigo a partir de este punto <<<
-- 
import sqlite3

conn = sqlite3.connect("mibase")  ## aca se indica el nombre de la db.
cur = conn.cursor()
conn.executescript(
    """

DROP TABLE IF EXISTS mibase;
CREATE TABLE mibase (
  K0  CHAR(1),
  K1  INT,
  c12 FLOAT,
  c13 INT,
  c14 DATE,
  c15 FLOAT,
  c16 CHAR(4));
"""
)
conn.commit()

# Lectura de todo el archivo
with open("tbl1.csv", "rt") as f:
    data = f.readlines()

# Elimina el '\n' al final de la línea
data = [line.replace('\n', '')  for line in data]

# Separa los campos por comas
data = [line.split(",") for line in data]

#debo quitar el \n

# Convierte la fila en una tupla
data = [tuple(line) for line in data]

#
# Carga a partir de la lista de tuplas
# contenidas en data
#
cur.executemany("INSERT INTO mibase VALUES (?,?,?,?,?,?,?)", data)
cur.execute("SELECT COUNT(*) FROM mibase;").fetchall()
