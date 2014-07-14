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

Statistics are created and updated automatically within the system for all indexes or for any column 
used as a predicate, as part of a WHERE clause or JOIN ON clause. 

When a Query is Submitted:
1. Parsing & Errors check
2. Starts in the  "relational engine" : Based on the statistics - it looks for the best execution plan
After a minimum allowed time ( depends on the Optimizer's decision ) - The plan is sent (in a binary format) 
to the storage engine. 
3. The storage engine is where processes such as locking, index maintenance, and transactions occur. 
4. The DDL ( CREATE et.c. ) language is not optimized.


Algebrizer:
Verification & Connection of supplied object names to the existing schemas, objects & the data type's 
verifications. It includes a hash - stamp & outputs a binary called the query processor tree, which is
then passed on to the query optimizer. The optimizer uses the hash to determine whether there is already
a plan generated and stored in the plan cache. If there is a plan there, the process stops here and that
plan is used. This reduces all the overhead required by the query optimizer to generate a new plan.


Once the optimizer arrives at an execution plan, the estimated plan is created and stored
in a memory space known as the plan cache 

When we submit a query to the server, the algebrizer process creates a hash code( a signature ).
If a query's signature exists in the "Plan Cache" - it the optimization process is skipped
and the execution plan in the plan cache is reused.

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

