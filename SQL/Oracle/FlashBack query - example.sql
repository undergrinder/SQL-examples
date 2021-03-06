/******************************
    Flashback Query Examples
*******************************/

--With discrete timestamps
 SELECT versions_startscn, 
        versions_starttime,
        versions_endscn, 
        versions_endtime,
        versions_xid, 
        versions_operation,
        description
  FROM table_name
  VERSIONS BETWEEN TIMESTAMP TO_TIMESTAMP('2017-11-15 15:10:00', 'YYYY-MM-DD HH24:MI:SS')
                         AND TO_TIMESTAMP('2017-11-15 15:43:00', 'YYYY-MM-DD HH24:MI:SS')
  WHERE ID=123456;

--Versions in the last 15 minutes
  SELECT versions_startscn  as startscn,
         versions_starttime as starttime,
         versions_endscn    as endscn,
         versions_endtime   as endtime,
         versions_xid,
         versions_operation,
         t_kozos.* 
  FROM table_name
  VERSIONS BETWEEN TIMESTAMP systimestamp -INTERVAL '15' MINUTE
                         AND systimestamp 
   WHERE versions_startscn IS NOT NULL;

