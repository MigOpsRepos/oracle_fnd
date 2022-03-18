-- complain if script is sourced in psql, rather than via CREATE EXTENSION
\echo Use "ALTER EXTENSION oracle_fnd UPDATE TO '1.2'" to load this file. \quit

-- This procedure sets up global variables and profile values in a database session.
-- Call this procedure to initialize the global security context for a database session.
--	USER_ID 	The USER_ID number
--	RESP_ID 	The ID number of the responsibility
--	RESP_APPL_ID 	The ID number of the application to which the responsibility belongs
-- Example:
-- fnd_global.APPS_INITIALIZE (1010, 20417, 201); 
--
CREATE OR REPLACE PROCEDURE FND_GLOBAL.APPS_INITIALIZE (user_id bigint, resp_id bigint, resp_appl_id bigint) AS $$
BEGIN
  PERFORM set_config('fnd_global.user_id', coalesce(user_id, -1)::text, false);
  PERFORM set_config('fnd_global.resp_id', coalesce(resp_id, -1)::text, false);
  PERFORM set_config('fnd_global.resp_appl_id', coalesce(resp_appl_id, -1)::text, false);
END
$$ LANGUAGE PLPGSQL;

