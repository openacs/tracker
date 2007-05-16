<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="tr_another_visit.insert_visit">
        <querytext>
	select tracker_visit__new(:user_id,:url,:page_type,65,:session_id,:package_id);
        </querytext>
    </fullquery>

    <fullquery name="tr_another_visit.insert_session">
        <querytext>
	select tracker_session__new(:session_id,:user_id,:peeraddr,:host,:user_agent);
        </querytext>
    </fullquery>

    <fullquery name="tr_another_visit.insert_parameters">
        <querytext>
	insert into tracker_parameters values(:visit_id,:v,:var)
        </querytext>
    </fullquery>

</queryset>
