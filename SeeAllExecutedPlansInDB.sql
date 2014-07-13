-- Get all executed plans from the Plan's cache
SELECT  [cp].[refcounts] ,
        [cp].[usecounts] ,
        [cp].[objtype] ,
        [st].[dbid] ,
        [st].[objectid] ,
        [st].[text] ,
        [qp].[query_plan]
FROM    sys.dm_exec_cached_plans cp
        CROSS APPLY sys.dm_exec_sql_text(cp.plan_handle) st
        CROSS APPLY sys.dm_exec_query_plan(cp.plan_handle) qp
WHERE db_name([st].[dbid]) = DB_NAME()


-- Clean cache
DBCC FREEPROCCACHE
DBCC FREEPROCCACHE([query_plan])

-- Permissions
GRANT SHOWPLAN TO [username];

SET SHOWPLAN_ALL ON/OFF;
--This event fires with each execution of a query and will generate the same type of estimated plan as the SHOWPLAN_TEXT T-SQL statement.
--It only shows a subset of the information available to Showplan XML.

SET SHOWPLAN_XML ON/OFF
--Same as above, but it shows the information as a string instead of binary. This is also on the list for deprecation in the future

SET STATISTICS PROFILE ON/OFF;
-- This event fires as each query executes and will generate the same type of estimated execution plan as the SHOWPLAN_ALL statement in T-SQL. 
-- This has the same shortcomings as Showplan Text, and is on the list for future deprecation.

SET STATISTICS XML ON/OFF
-- This event generates the same data as the Showplan All event, but it only fires when a query compile event occurs.
-- This is also on the list for deprecation in the future



