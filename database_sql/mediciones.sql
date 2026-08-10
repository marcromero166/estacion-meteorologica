CREATE DATABASE IF NOT EXISTS estacionmetereologica_proa;

USE estacionmetereologica_proa;
CREATE TABLE IF NOT EXISTS mediciones (
    id_mediciones INT AUTO_INCREMENT PRIMARY KEY,
    fecha_hora DATETIME DEFAULT CURRENT_TIMESTAMP,
    temperatura INT, -- El DHT11 mide de 1 en 1 grado, INT es eficiente
    humedad INT      -- Guardamos un INT ya que la humedad del DHT11 viene entera
);

INSERT INTO mediciones (temperatura, humedad) VALUES (24, 55); 
SELECT * FROM mediciones;
SELECT 
    fecha_hora,
    temperatura,
    humedad,
    CASE 
        WHEN temperatura >= 35 THEN 'ALERTA: CALOR EXTREMO'
        WHEN temperatura >= 30 AND temperatura < 35 THEN 'PRECAUCIÓN: TEMP ELEVADA'
        WHEN temperatura < 15 THEN 'ALERTA: FRÍO EXTREMO'
        ELSE 'ESTADO ÓPTIMO'
    END AS diagnostico_clima
FROM mediciones 
ORDER BY fecha_hora DESC;


ALTER TABLE mediciones 
ADD COLUMN gas INT AFTER humedad;


-- 3. Inserciones de prueba (Normal, Calor y Fuga de Gas)
INSERT INTO mediciones (temperatura, humedad, gas) VALUES (24, 55, 120); -- Óptimo
INSERT INTO mediciones (temperatura, humedad, gas) VALUES (36, 40, 150); -- Alerta Calor
INSERT INTO mediciones (temperatura, humedad, gas) VALUES (22, 60, 480); -- Alerta Fuga de Gas

SELECT 
    fecha_hora,
    temperatura,
    humedad,
    gas,
    CASE 
        WHEN gas > 300 THEN 'ALERTA: GAS / ANOMALÍA EN AIRE'
        WHEN temperatura >= 35 THEN 'ALERTA: CALOR EXTREMO'
        WHEN temperatura <= 15 THEN 'ALERTA: FRÍO EXTREMO'
        ELSE 'ESTADO ÓPTIMO'
    END AS diagnostico_integral
FROM mediciones 
ORDER BY fecha_hora DESC;









