# 1.1 Tienda Informática

Base de datos de práctica sobre productos y fabricantes de tecnología.

## 📋 Descripción

Este ejercicio trabaja con una base de datos simple de dos tablas que simula una tienda de productos informáticos. Incluye consultas SQL desde nivel básico hasta avanzado.

## 🗂️ Estructura de la base de datos

### Tablas

**fabricante**
- `id` (INT, PRIMARY KEY, AUTO_INCREMENT)
- `nombre` (VARCHAR(100), NOT NULL)

**producto**
- `id` (INT, PRIMARY KEY, AUTO_INCREMENT)
- `nombre` (VARCHAR(100), NOT NULL)
- `precio` (DOUBLE, NOT NULL)
- `id_fabricante` (INT, FOREIGN KEY → fabricante.id)

## 📁 Archivos

| Archivo | Descripción | Ejercicios |
|---------|-------------|------------|
| `schema.sql` | Estructura de la BD e inserción de datos | - |
| `1.1.3 Consultas sobre una tabla.sql` | SELECT básico, filtros, ordenamiento, funciones | 36 |
| `1.1.4 Consultas multitabla (Composición interna).sql` | INNER JOIN | 13 |
| `1.1.5 Consultas multitabla (Composición externa).sql` | LEFT JOIN | 3 |
| `1.1.6 Consultas resumen.sql` | Funciones agregación, GROUP BY, HAVING | 29 |
| `1.1.7 Subconsultas (En la cláusula WHERE).sql` | Subconsultas simples, ALL, ANY, IN, EXISTS | 14 |
| `1.1.7.5 Subconsultas correlacionadas.sql` | Subconsultas correlacionadas y en HAVING | 4 |

**Total: 99 ejercicios resueltos**

## 🎯 Conceptos cubiertos

### 1.1.3 - Consultas básicas
- SELECT, WHERE, ORDER BY, LIMIT, OFFSET
- Funciones: UPPER, LOWER, SUBSTRING, LENGTH, ROUND, TRUNCATE
- Operadores: LIKE, BETWEEN, IN, NOT, DISTINCT

### 1.1.4 y 1.1.5 - Consultas multitabla
- INNER JOIN (composición interna)
- LEFT JOIN (composición externa)
- Alias de tablas

### 1.1.6 - Consultas resumen
- COUNT, SUM, AVG, MAX, MIN
- GROUP BY
- HAVING

### 1.1.7 - Subconsultas
- Subconsultas en WHERE
- ALL, ANY, IN, NOT IN
- EXISTS, NOT EXISTS
- Subconsultas correlacionadas
- Subconsultas en HAVING

## 🚀 Cómo usar

1. **Crear la base de datos**:
```bash
   mysql -u root -p < schema.sql
```

2. **Ejecutar consultas de un archivo específico**:
```bash
   mysql -u root -p tienda_informatica < "1.1.3 Consultas sobre una tabla.sql"
```
3. **O ejecutar en tu cliente MySQL favorito** (Workbench, DBeaver, etc.)

## 📚 Fuente

Ejercicios de [José Juan Sánchez](https://josejuansanchez.org/bd/ejercicios-consultas-sql/)

## ✅ Estado

**✅ Completado** 