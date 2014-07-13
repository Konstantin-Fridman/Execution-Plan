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

SET SHOWPLAN XML ON /OFF:
The event fires with each execution of a query and generates an estimated execution plan in the same way as SHOWPLAN_XML. 
This is the event you want in most cases. The others should be avoided because of the load they place on the system or 
because they don't return data that is usable for our purposes.

SET SHOWPLAN TEXT ON /OFF:
This event fires with each execution of a query and will generate the same type of estimated plan as the SHOWPLAN_TEXT T-SQL statement. 
It only shows a subset of the information available to Showplan XML. 

SET SHOWPLAN TEXT(unencoded) ON /OFF:
Same as above, but it shows the information as a string instead of binary. This is also on the list for deprecation in the future. 

SET SHOWPLAN All ON /OFF:
This event fires as each query executes and will generate the same type of estimated execution plan as the SHOWPLAN_ALL statement in T-SQL. 

SET SHOWPLAN All for Query Compile ON /OFF:
This event generates the same data as the Showplan All event, but it only fires when a query compile event occurs. 

SET SHOWPLAN Statistics Profile ON /OFF:
This event generates the actual execution plan in the same way as the T-SQL command STATISTICS PROFILE. 
It still has all the short- comings of the text output, including only supplying a subset of the data available to STATISTICS XML in T-SQL 
or the Showplan XML Statistics Profile event in SQL Server Profiler. The Showplan Statistics Profile event is on the list for deprecation.

SET Showplan XML for Query Compile ON /OFF:
Showplan XML for Query Compile – Like Showplan XML above, but it only fires on a compile of a given query.

SET Performance Statistics ON /OFF:
Performance Statistics – Similar to the Showplan XML For Query Compile event, except this event captures performance
metrics for the query as well as the plan. This only captures XML output for certain event subclasses, defined with the event. 
It fires the first time a plan is cached, compiled, recompiled, or removed from cache.

SET Showplan XML Statistics Profile ON/OFF:
This event will generate the actual execution plan for each query, as it runs.

