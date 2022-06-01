SELECT qc.asset_id,
    qc.ip,
    qc.os,
    max(qc.last_scan_date::text) AS last_detected
   FROM "mymops"."ldr"."sherlock_sw_inventory" qc
  GROUP BY qc.asset_id, qc.ip, qc.os