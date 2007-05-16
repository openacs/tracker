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

create or replace function tracker_session__new (integer,integer,varchar,varchar,varchar)
returns integer as '
declare
 p_session_id	alias for $1;
 p_user_id      alias for $2;
 p_ip    	alias for $3;
 p_ip_reverse	alias for $4;
 p_user_agent	alias for $5;
 v_session_temp	integer;
begin
 select session_id into v_session_temp from tracker_sessions where session_id=p_session_id and user_id=p_user_id;
 if v_session_temp is null then
  insert into tracker_sessions values(p_session_id,p_user_id,p_ip,p_ip_reverse,p_user_agent);
 end if;
 return 0;
end;' language 'plpgsql';

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
	visit_id	integer primary key references tracker_visits(visit_id) on delete cascade,
	name		varchar,
	value		varchar
);

create or replace function tracker_visit__new(integer,varchar,char,integer,integer,integer,integer)
returns integer as '
declare
  user_id     alias for $1;
  url	      alias for $2;
  page_type   alias for $3;
  request     alias for $4;
  session_id  alias for $5;
  object_id   alias for $6;
  visit_id    integer;
begin
  visit_id := nextval(''sec_visits'');
  insert into tracker_visits values (visit_id,now(),url,page_type,request,session_id,user_id,object_id);
  return visit_id;
end;' language 'plpgsql';

