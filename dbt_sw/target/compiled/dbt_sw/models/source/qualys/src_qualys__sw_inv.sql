SELECT q.asset_id,
    q.ip,
    q.qid,
    q.os,
    NULL::text AS title,
    q.last_detected,
        CASE
            WHEN q.qid::text = ANY (ARRAY['45141'::character varying::text, '90235'::character varying::text]) THEN q.sw[1]
            WHEN q.qid::text = ANY (ARRAY['45211'::character varying::text, '45253'::character varying::text]) THEN q.sw[2]
            ELSE NULL::text
        END AS sw_name,
        CASE
            WHEN q.qid::text = ANY (ARRAY['45141'::character varying::text, '90235'::character varying::text]) THEN q.sw[2]
            WHEN q.qid::text = ANY (ARRAY['45211'::character varying::text, '45253'::character varying::text]) THEN q.sw[3]
            ELSE NULL::text
        END AS sw_version,
        CASE
            WHEN q.qid::text = ANY (ARRAY['45141'::character varying::text, '90235'::character varying::text]) THEN
            CASE
                WHEN btrim(q.sw[3]) = ''::text THEN NULL::text
                ELSE q.sw[3]
            END
            ELSE NULL::text
        END AS sw_install_date,
        CASE
            WHEN q.qid::text = '90235'::text THEN q.sw[4]
            ELSE NULL::text
        END AS sw_publisher,
        CASE
            WHEN q.qid::text = '90235'::text THEN q.sw[5]
            ELSE NULL::text
        END AS sw_language,
        CASE
            WHEN q.qid::text = '90235'::text THEN q.sw[6]
            WHEN q.qid::text = '45211'::text THEN q.sw[1]
            ELSE NULL::text
        END AS sw_install_path,
        CASE
            WHEN q.qid::text = '45253'::text THEN q.sw[1]
            ELSE NULL::text
        END AS sw_descr
   FROM ( SELECT qc.asset_id,
            qc.ip,
            qc.qid,
            qc.os,
            qc.last_found_date AS last_detected,
            regexp_split_to_array(regexp_split_to_table(qc.results::text, chr(10)), chr(9)) AS sw
           FROM "mymops"."ldr"."sherlock_sw_inventory" qc
          WHERE qc.asset_id IS NOT NULL AND (qc.qid::text = ANY (ARRAY['45141'::character varying::text, '90235'::character varying::text]))) q