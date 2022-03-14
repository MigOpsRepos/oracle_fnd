-- complain if script is sourced in psql, rather than via CREATE EXTENSION
\echo Use "ALTER EXTENSION oracle_fnd UPDATE TO \"1.1\"" to load this file. \quit

-- Returns the security group ID.
CREATE FUNCTION FND_GLOBAL.SECURITY_GROUP_ID () RETURNS bigint AS $$
  SELECT current_setting('fnd_global.security_group_id')::bigint;
$$ LANGUAGE SQL;

-- Returns the organisation ID.
CREATE FUNCTION FND_GLOBAL.ORG_ID () RETURNS bigint AS $$
  SELECT current_setting('fnd_global.org_id')::bigint;
$$ LANGUAGE SQL;

-- Returns the user name.
CREATE FUNCTION FND_GLOBAL.USER_NAME () RETURNS varchar AS $$
  SELECT current_setting('fnd_global.user_name')::varchar;
$$ LANGUAGE SQL;

-- Returns the resp name.
CREATE FUNCTION FND_GLOBAL.RESP_NAME () RETURNS varchar AS $$
  SELECT current_setting('fnd_global.resp_name')::varchar;
$$ LANGUAGE SQL;

-- Returns the application name.
CREATE FUNCTION FND_GLOBAL.APPLICATION_NAME () RETURNS varchar AS $$
  SELECT current_setting('fnd_global.application_name')::varchar;
$$ LANGUAGE SQL;

-- Returns the application short name.
CREATE FUNCTION FND_GLOBAL.APPLICATION_SHORT_NAME () RETURNS varchar AS $$
  SELECT current_setting('fnd_global.application_short_name')::varchar;
$$ LANGUAGE SQL;

-- Returns the organisation name.
CREATE FUNCTION FND_GLOBAL.ORG_NAME () RETURNS varchar AS $$
  SELECT current_setting('fnd_global.org_name')::varchar;
$$ LANGUAGE SQL;

-- Returns the base language.
CREATE FUNCTION FND_GLOBAL.BASE_LANGUAGE () RETURNS varchar AS $$
  SELECT current_setting('fnd_global.base_language')::varchar;
$$ LANGUAGE SQL;

-- Returns the current language.
CREATE FUNCTION FND_GLOBAL.CURRENT_LANGUAGE () RETURNS varchar AS $$
  SELECT current_setting('fnd_global.current_language')::varchar;
$$ LANGUAGE SQL;

-- Returns the priority request.
CREATE FUNCTION FND_GLOBAL.CONC_PRIORITY_REQUEST () RETURNS varchar AS $$
  SELECT current_setting('fnd_global.conc_priority_request')::varchar;
$$ LANGUAGE SQL;

-- Returns the responsable ID.
CREATE FUNCTION FND_GLOBAL.RESP_ID () RETURNS bigint AS $$
  SELECT current_setting('fnd_global.resp_id')::bigint;
$$ LANGUAGE SQL;

-- Returns the responsable application ID.
CREATE FUNCTION FND_GLOBAL.RESP_APPL_ID () RETURNS bigint AS $$
  SELECT current_setting('fnd_global.resp_appl_id')::bigint;
$$ LANGUAGE SQL;

