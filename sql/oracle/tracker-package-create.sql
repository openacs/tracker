--
--  Copyright (C) 2007, 
--
--  This file is part of "tracker" package.
--
--  "tracker" is distributed in the hope that it will be useful, but WITHOUT ANY
--  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
--  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
--  details.
--
--
-- @author David Arroyo Menéndez (darroyo@innova.uned.es)
--
-- @date 27/03/2007
--

create or replace package tracker
as

    procedure new (
        p_session_id in tracker_sessions.session_id%TYPE,
        p_user_id in tracker_sessions.user_id%TYPE,
        p_ip in tracker_sessions.ip%TYPE default null,
        p_ip_reverse in tracker_sessions.ip_reverse%TYPE default null,
        p_user_agent in tracker_sessions.user_agent%TYPE default null
    );
    
    function visit (
	p_user_id in tracker_visits.user_id%TYPE,
	p_url in tracker_visits.url%TYPE default null,
	p_page_type in tracker_visits.page_type%TYPE default null,
	p_request in tracker_visits.request%TYPE default null,
	p_session_id in tracker_visits.session_id%TYPE,
	p_object_id in tracker_visits.object_id%TYPE
    ) return tracker_visits.visit_id%TYPE;
	
end tracker;
/
show errors



create or replace package body tracker
as

    procedure new (
        p_session_id in tracker_sessions.session_id%TYPE,
        p_user_id in tracker_sessions.user_id%TYPE,
        p_ip in tracker_sessions.ip%TYPE default null,
        p_ip_reverse in tracker_sessions.ip_reverse%TYPE default null,
        p_user_agent in tracker_sessions.user_agent%TYPE default null
    ) 
    is
        v_session_temp tracker_sessions.session_id%TYPE;
    begin
	select count(session_id) into v_session_temp from tracker_sessions where session_id=p_session_id and user_id=p_user_id;
	if v_session_temp = 0 then
		insert into tracker_sessions values(p_session_id,p_user_id,p_ip,p_ip_reverse,p_user_agent);
	end if;
    end new;

    function visit (
	p_user_id in tracker_visits.user_id%TYPE,
	p_url in tracker_visits.url%TYPE default null,
	p_page_type in tracker_visits.page_type%TYPE default null,
	p_request in tracker_visits.request%TYPE default null,
	p_session_id in tracker_visits.session_id%TYPE,
	p_object_id in tracker_visits.object_id%TYPE
    ) return tracker_visits.visit_id%TYPE
    is
	v_visit_id tracker_visits.visit_id%TYPE;
    begin
	select sec_visits.nextval into v_visit_id from dual;
	insert into tracker_visits values (v_visit_id,sysdate,p_url,p_page_type,p_request,p_session_id,p_user_id,p_object_id);
	return v_visit_id;
    end visit;

end tracker;
/
show errors

