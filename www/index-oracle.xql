<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>8.1.6</version></rdbms>

    <fullquery name="select_users">
        <querytext>
	select distinct person_id as user_id, first_names, last_name 
	from persons, tracker_visits 
	where person_id=user_id and rownum<=10
        </querytext>
    </fullquery>

</queryset>
