

  create  table "mymops"."dbt_shantal"."stg_sw_scanned__dbt_tmp"
  as (
    with __dbt__cte__src_qualys__sw_scan as (
SELECT qc.asset_id,
    qc.ip,
    qc.qid,
    qc.os,
    NULL::text AS title,
    NULL::text AS last_detected,
    qc.results
   FROM "mymops"."ldr"."sherlock_sw_inventory" qc
  WHERE qc.asset_id IS NOT NULL AND NOT (qc.qid::text = ANY (ARRAY['45141'::character varying::text, '90235'::character varying::text]))
)select * from __dbt__cte__src_qualys__sw_scan
  );