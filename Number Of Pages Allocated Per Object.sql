SELECT [Number Of Pages Allocated Per Object] = in_row_reserved_page_count
	 , [Object Name] = OBJECT_NAME(object_id)
  from sys.dm_db_partition_stats
