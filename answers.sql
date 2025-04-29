-- Question 1: Normalize the Products column
SELECT 
    OrderID,
    CustomerName,
    TRIM(value) AS Product
FROM 
    ProductDetail
CROSS APPLY 
    STRING_SPLIT(Products, ',');

    -- Question 2 Removing partial dependencies
    -- Create Orders table (removes CustomerName partial dependency)
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Create OrderItems table (contains full dependencies)
CREATE TABLE OrderItems (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Populate the Orders table
INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

-- Populate the OrderItems table
INSERT INTO OrderItems (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;