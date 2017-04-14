select t.consumer_id_id, con_inc.incentive_id, con_inc."SELECTION_DATE", ti."DATE" as TRANSACTION_DATE, ti.product_id as UPC, ti.quantity, ti.clientid
from mdot_client.consumer_incentive con_inc
  join mdot_client.transaction t 
  on con_inc.consumer_id_id = t.consumer_id_id
  and t."DATE" >= con_inc."SELECTION_DATE"
  and con_inc.incentive_id in (261868, 261869)
join mdot_client.transaction_item ti
  on t.basket_id = ti.basket_id
where 
   ti.product_id in (7144830004,7144830030,7144830014,7144830057,7144830025,7144830019,7144830085)
  and ti.clientid = 10
  and t.transyear = 2017
  and ti."DATE" between date'2017-02-10' and date'2017-04-06'
;