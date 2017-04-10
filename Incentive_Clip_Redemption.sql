set schema chhedar;
set var clientid 188;
set var rdmdate '2016-11-01';
 
create or replace view incentive_$clientid as 
select
     inc.*
    ,clp.valid_clip_count
    ,red.valid_redemption_count

from 
    (select distinct clientid, incentive_id, offer_code, brand, manufacturer, clip_start_date, clip_end_date, active_date, expire_date, buyqty, value, description, short_description, max_clip_count
     from mdot_client.incentive  
     where clientid = $clientid and active_date >= date $rdmdate
     ) inc
     
left join
    (select 
         clientid
        ,incentive_id
        ,count(distinct consumer_incentive_id) as valid_clip_count

    from
        mdot_client.consumer_incentive

    where 
        clientid=$clientid and selection_date >= date $rdmdate

    group by 1,2
    ) clp 
on inc.clientid = clp.clientid and inc.incentive_id = clp.incentive_id

left join
    (select 
         clientid
        ,incentive_id
        ,sum(redeem_cnt) as valid_redemption_count

    from 
        mdot_client.redemption

    where 
        clientid = $clientid and redeem_dt >= date $rdmdate and redemption_status_id not in (98,99)
    
    group by 1,2
    ) red 
on inc.clientid = red.clientid and inc.incentive_id = red.incentive_id

cascade drop images;
create view image incentive_$clientid;