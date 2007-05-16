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
-- @author Felix Hernandez (felixh@dia.uned.es)
--
-- @date 05/04/2004
--


drop table tracker_sessions cascade;
drop function tracker_session__new(integer,integer,varchar,varchar,varchar);
drop table tracker_parameters;
drop table tracker_visits;
drop sequence sec_visits;
drop function tracker_visit__new(integer,varchar,char,integer,integer,integer);
