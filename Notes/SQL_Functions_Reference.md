#### Common SQL Functions Used

| Function | Purpose | Example |
|-----------|----------|----------|
| `DISTINCT` | Returns unique values | `SELECT DISTINCT Country FROM Customers;` |
| `COUNT()` | Counts rows or values | `COUNT(CustomerID)` |
| `SUM()` | Adds numeric values | `SUM(SalesAmount)` |
| `AVG()` | Averages numeric values | `AVG(UnitPrice)` |
| `DATEDIFF()` | Calculates difference between two dates | `DATEDIFF(DAY, OrderDate, ShippedDate)` |
| `ROW_NUMBER()` | Sequential numbering | `ROW_NUMBER() OVER (ORDER BY Sales DESC)` |
| `RANK()` | Assigns ranks with gaps | `RANK() OVER (ORDER BY Sales DESC)` |
| `DENSE_RANK()` | Assigns ranks without gaps | `DENSE_RANK() OVER (ORDER BY Sales DESC)` |
| `NTILE(n)` | Divides rows into groups | `NTILE(4) OVER (ORDER BY Sales DESC)` |
