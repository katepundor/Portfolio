--MERGE INTO DBO.STCOKITEM USING STOCKTRANSACTION WHERE STOCK ITEMS ARE UPDATED EVERY WEEK FROM DBO.STOCKTRANSACTION. QUERY RETURNS A LIST OF AFFECTED ITEMS, SHOWINGITEMID AND THE ACTION--

MERGE 
     INTO dbo.StockItem AS I 
	 USING dbo.StockTransaction AS T 
	      ON I.ItemID = T.ItemId 
	WHEN Matched AND T.ItemName <> ISNULL(I.Color, N'<NULL>')
	OR T.UnitPrice <> I.UnitPrice
	THEN UPDATE 
			SET ItemName = T.ItemName, Color = T.Color, UnitPrice = T.UnitPrice

	WHEN NOT MATCHED 

			THEN INSERT 

				VALUES (ItemId, T.ItemName, T.Color, T.UniPrice)

	WHEN NOT MATCHED BY SOURCE 

			THEN DELETE 
	
	OUTPUT COALESCE(inserted.ItemID, deleted.ItemID) AS [ItemID], $action AS [Action];
