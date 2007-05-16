ad_library {
    Traker libraries
    
    @author Felix Hernandez del Olmo
    @date 04/04/2004
}


ad_proc -public tr_another_visit { page_type parameters } { 
    Procedure which handles calls to \"ad_page_contract\" from tcl's.
    It takes a list of \{variable value\} list which correspond with tcls' parameters.    
    Here page_type is set to \"dynamic\"

    It takes control of static pages also. Then page_type is set to \"static\"
} {

    set session_id [ad_conn session_id]
    set user_id [ad_conn user_id]
    set url [ad_conn url]
    set page_type [string range $page_type 0 0]
    set request [ad_conn request]
    set package_id [ad_conn object_id]
    if { [db_0or1row q "select 1 from tracker_sessions where session_id= :session_id and user_id= :user_id"] } {
        #Next 
	set request [ad_conn request]
	set visit_id [db_exec_plsql insert_visit {}]
    } else {
        #Create new session
	set peeraddr [ad_conn peeraddr]
        with_catch error {
	    set host [ns_hostbyaddr $peeraddr]
        } { 
	    set host "no accesible" 
	}
	db_transaction {
	    set user_agent [ns_set get [ad_conn header] User-Agent]
	    db_exec_plsql insert_session {}
	    set visit_id [db_exec_plsql insert_visit {}]
	}
    }

    #Si la pagina es dinamica genera las filas de parametros
    if {$page_type == "d"} {
	foreach v $parameters {
	    upvar 2 $v value
	    if [info exists value] {
		if [array exists value] {
		    set vars [array names value]
		    foreach v1 $vars {
			set var [array get value $v1]
			if {$var != ""} {
			    set v "$v:$v1"
			    db_dml insert_parameters {}
			}
		    }
		} else {
		    if {$value != ""} {
			set var $value
			db_dml insert_parameters {}
		    }
		}
	    }
	} 
    }
    
}

# static HTML filters
ad_proc -private tr_trace_static_page { conn why } {
    Procedure that handles calls from html filters.
} {
    tr_another_visit static {}
    return filter_ok
}

if {[info exist tr_only_once] == 0} {
    ad_register_filter trace * *.html tr_trace_static_page 
    ad_register_filter trace * *.htm tr_trace_static_page 
    set tr_only_once 1
}
