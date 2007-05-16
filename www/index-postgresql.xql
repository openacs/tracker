<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="select_users">
        <querytext>
	select distinct person_id as user_id, first_names, last_name 
	from persons inner join tracker_visits on(person_id=user_id) limit 10
        </querytext>
    </fullquery>

</queryset>
