-- complain if script is sourced in psql, rather than via CREATE EXTENSION
\echo Use "CREATE EXTENSION oracle_fnd" to load this file. \quit

CREATE SCHEMA FND_GLOBAL;

-- This procedure sets up global variables and profile values in a database session.
-- Call this procedure to initialize the global security context for a database session.
--	USER_ID 	The USER_ID number
--	RESP_ID 	The ID number of the responsibility
--	RESP_APPL_ID 	The ID number of the application to which the responsibility belongs
-- Example:
-- fnd_global.APPS_INITIALIZE (1010, 20417, 201); 
--
CREATE PROCEDURE FND_GLOBAL.APPS_INITIALIZE (user_id bigint, resp_id bigint, resp_appl_id bigint) AS $$
BEGIN
  PERFORM set_config('fnd_global.user_id', coalesce(user_id, -1), false);
  PERFORM set_config('fnd_global.resp_id', coalesce(resp_id, -1), false);
  PERFORM set_config('fnd_global.resp_appl_id', coalesce(resp_appl_id, -1), false);
END
$$ LANGUAGE PLPGSQL;

-- Returns the user ID.
CREATE FUNCTION FND_GLOBAL.USER_ID () RETURNS bigint AS $$
  SELECT current_setting('fnd_global.user_id')::bigint;
$$ LANGUAGE SQL;

-- Returns the login ID (unique per signon).
CREATE FUNCTION FND_GLOBAL.LOGIN_ID () RETURNS bigint AS $$
  SELECT current_setting('fnd_global.login_id')::bigint;
$$ LANGUAGE SQL;

-- Returns the concurrent program login ID.
CREATE FUNCTION FND_GLOBAL.CONC_LOGIN_ID () RETURNS bigint AS $$
  SELECT current_setting('fnd_global.conc_login_id')::bigint;
$$ LANGUAGE SQL;

-- Returns the concurrent program application ID.
CREATE FUNCTION FND_GLOBAL.PROG_APPL_ID () RETURNS bigint AS $$
  SELECT current_setting('fnd_global.prog_appl_id')::bigint;
$$ LANGUAGE SQL;

-- Returns the concurrent program ID.
CREATE FUNCTION FND_GLOBAL.CONC_PROGRAM_ID () RETURNS bigint AS $$
  SELECT current_setting('fnd_global.conc_program_id')::bigint;
$$ LANGUAGE SQL;

-- Returns the concurrent request ID.
CREATE FUNCTION FND_GLOBAL.CONC_REQUEST_ID () RETURNS bigint AS $$
  SELECT current_setting('fnd_global.conc_request_id')::bigint;
$$ LANGUAGE SQL;


-----------------
-- FND_PROFILE --
-----------------

CREATE SCHEMA FND_PROFILE;

-- Puts a value to the specified user profile option.
--	pname 	The (developer) name of the profile option you want to set.
--	value 	The value to set in the specified profile option.
CREATE PROCEDURE FND_PROFILE.PUT (pname varchar, value varchar) AS $$
BEGIN
  PERFORM set_config('fnd_global.'||pname, coalesce(value, ''), false);
END
$$ LANGUAGE PLPGSQL;

-- Gets the current value of the specified user profile option, or NULL
-- if the profile does not exist. All GET operations are satisfied locally
-- in other words, a GET on the server is satisfied from the server-side
-- cache, and a GET on the client is satisfied from the client-side cache.
-- The server-side PL/SQL package FND_GLOBAL returns the values you need to set Who columns for inserts and updates from stored procedures. You should use FND_GLOBAL to obtain Who values from stored procedures rather than using GET, which you may have used in prior releases of Oracle E-Business Suite.
--	pname 	The (developer) name of the profile option whose value you want to retrieve.
--	value 	The current value of the specified user profile option as last set by PUT or as defaulted in the current user's profile.
CREATE FUNCTION FND_PROFILE.GET (pname varchar, OUT value varchar) AS $$
DECLARE
  v_varname text;
BEGIN
  SELECT name INTO v_varname FROM pg_settings WHERE v_varname = 'fnd_global.'||pname;
  IF v_varname IS NOT NULL THEN
    value := current_setting('fnd_global.'||pname);
  END IF;
  value := NULL;
END
$$ LANGUAGE PLPGSQL;

-- VALUE works exactly like GET, except it returns the value of the specified profile option as a function result.
--	pname 	The (developer) name of the profile option whose value you want to retrieve.
CREATE FUNCTION FND_PROFILE.VALUE (pname varchar) RETURNS varchar AS $$
DECLARE
  v_varname text;
BEGIN
  SELECT name INTO v_varname FROM pg_settings WHERE v_varname = 'fnd_global.'||pname;
  IF v_varname IS NOT NULL THEN
    RETURN current_setting('fnd_global.'||pname);
  END IF;
  RETURN NULL;
END
$$ LANGUAGE PLPGSQL;
