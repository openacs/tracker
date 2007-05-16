--
--  Copyright (C) 2004, 
--
--  This file is part of "tracker" package.
--
--  "tracker" is distributed in the hope that it will be useful, but WITHOUT ANY
--  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
--  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
--  details.
--
--
-- @author Felix Hernandez del Olmo (felixh@dia.uned.es)
--
-- @date 05/04/2004
--

create table tracker_sessions (
	session_id	integer, 
	user_id		integer references users(user_id) on delete cascade,
	ip		varchar,
        ip_reverse      varchar, 
	user_agent	varchar,
	primary key (session_id,user_id)
);


create table tracker_visits (
	visit_id	integer primary key, --integer references acs_objects(object_id) primary key,
	visit_date	timestamp,
	url		varchar,
	page_type	char(1) default('d') check(page_type in ('d','s')), 
	request		integer,
	session_id	integer, --references tracker_sessions(session_id) on delete cascade, 
	user_id 	integer references users(user_id) on delete cascade,
        object_id       integer references acs_objects(object_id) on delete cascade
);

create index tracker_visits_url_index on tracker_visits (url);
create index tracker_visits_date_index on tracker_visits (visit_date);

create sequence sec_visits;

create table tracker_parameters (
	visit_id	integer references tracker_visits(visit_id) on delete cascade,
	name		varchar,
	value		varchar,
	primary key (visit_id, name)
);

