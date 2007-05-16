<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>8.1.6</version></rdbms>

    <fullquery name="tr_another_visit.insert_visit">
        <querytext>
	begin
	:1 := tracker.visit(:user_id,:url,:page_type,:request,:session_id,:package_id);
	end;
        </querytext>
    </fullquery>

    <fullquery name="tr_another_visit.insert_session">
        <querytext>
	begin
		tracker.new(:session_id,:user_id,:peeraddr,:host,:user_agent);
	end;
        </querytext>
    </fullquery>

    <fullquery name="tr_another_visit.insert_parameters">
        <querytext>
	insert into tracker_parameters values(:visit_id,:v,:var)
        </querytext>
    </fullquery>

</queryset>