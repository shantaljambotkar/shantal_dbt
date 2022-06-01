SELECT qc.asset_id,
    qc.ip,
    qc.qid,
    qc.os,
    NULL::text AS title,
    NULL::text AS last_detected,
    qc.results
   FROM {{ source('Qualys', 'sherlock_sw_inventory') }} qc
  WHERE qc.asset_id IS NOT NULL AND NOT (qc.qid::text = ANY (ARRAY['45141'::character varying::text, '90235'::character varying::text]))