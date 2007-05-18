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
-- @date 28/03/2007
--

create table tracker_sessions (
	session_id	integer, 
	user_id		integer constraint tracker_user_id_fk references users(user_id)
 on delete cascade,
	ip		varchar2(255),
        ip_reverse      varchar2(255), 
	user_agent	varchar2(255),
	constraint tracker_session_pk primary key (session_id,user_id)
);

create table tracker_visits (
	visit_id	integer constraint tracker_visits_pk primary key, 
	visit_date	date,
	url		varchar2(2000),
	page_type	char(1) default('d') check(page_type in ('d','s')), 
	request		integer,
	session_id	integer,
	user_id 	integer constraint tracker_v_user_id_fk references users(user_id) on delete cascade,
        object_id       integer constraint tracker_v_object_id_fk references acs_objects(object_id) on delete cascade
);

create index tracker_visits_url_idx on tracker_visits (url);
create index tracker_visits_date_idx on tracker_visits (visit_date);

create sequence sec_visits start with 1;

create table tracker_parameters (
	visit_id	integer references tracker_visits(visit_id) on delete cascade,
	name		varchar2(255),
	value		CLOB,
	constraint tracker_parameter_pk primary key (visit_id, name)
);




