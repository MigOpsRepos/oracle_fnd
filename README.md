* [Description](#description)
* [Installation](#installation)
* [Configuration](#configuration)
* [Use of the extension](#use-of-the-extension)
* [Authors](#authors)

## Oracle_FND

### [Description](#description)

Functions that emulate the FND_GLOBAL and FND_PROFILE package's API using
custom variables.

The objective of this extension it to propose an solution to avoid rewritting
of calls to FND_GLOBAL and FND_PROFILE functions.

For more information about these Oracle features see the Oracle implementation at:
* [https://docs.oracle.com/cd/E18727_01/doc.121/e12897/T302934T462356.htm](https://docs.oracle.com/cd/E18727_01/doc.121/e12897/T302934T462356.htm) and
* [https://docs.oracle.com/cd/E18727_01/doc.121/e12897/T302934T457084.htm#I_prof_plsql](https://docs.oracle.com/cd/E18727_01/doc.121/e12897/T302934T457084.htm#I_prof_plsql)


### Installation

To install this extension, untar the oracle_fnd tarball anywhere you want then
you'll need to compile it with pgxs that mean that the `pg_config` tool must be
in your path.  Depending on your installation, you may need to install some devel
package. Once `pg_config` is in your path, do

        make
        sudo make install

### Configuration

The following custom variables must be loaded in the postgresql.conf file or using
the configuration file `oracle_fnd.conf` provided in this distribution through the
use of the `include` or `include_dir` in postgresql.conf

```
fnd_global.conc_login_id = -1
fnd_global.conc_program_id = -1
fnd_global.conc_request_id = -1
fnd_global.login_id = -1
fnd_global.prog_appl_id = -1
fnd_global.conc_program_id = -1
fnd_global.user_id = -1
fnd_global.resp_id = -1
fnd_global.resp_appl_id = -1

fnd_profil.username = ''
fnd_profil.user_id = -1
fnd_profil.resp_id = -1
fnd_profil.appl_shrt_name = ''
fnd_profil.resp_appl_id = -1
fnd_profil.form_name = ''
fnd_profil.form_id = -1
fnd_profil.form_appl_name = ''
fnd_profil.form_appl_id = -1
fnd_profil.logon_date = ''
fnd_profil.last_logon_date = ''
fnd_profil.login_id = -1
fnd_profil.conc_request_id = -1
fnd_profil.conc_program_id = -1
fnd_profil.conc_program_application_id = -1
fnd_profil.conc_login_id = -1
fnd_profil.conc_print_output = ''
fnd_profil.conc_print_style = ''
```

### Use of the extension

There is two schema created by the extension, `fnd_global` and `fnd_profile` which host the following functions and procedures.

#### FND_GLOBAL

* FND_GLOBAL.APPS_INITIALIZE (user_id bigint, resp_id bigint, resp_appl_id bigint)

This procedure initialize global variables and profile values in a database session.

Parameters:

	user_id 	The USER_ID number
	resp_id 	The ID number of the responsibility
	resp_appl_id 	The ID number of the application to which the responsibility belongs

For the moment it only sets the global variables USER_ID, RESP_ID and RESP_APPL_ID.

* FND_GLOBAL.USER_ID ()

Returns the user ID.

* FND_GLOBAL.LOGIN_ID ()

Returns the login ID (unique per session).

* FND_GLOBAL.CONC_LOGIN_ID

Returns the concurrent program login ID.

* FND_GLOBAL.PROG_APPL_ID ()

Returns the concurrent program application ID.

* FND_GLOBAL.CONC_PROGRAM_ID ()

Returns the concurrent program ID.

* FND_GLOBAL.CONC_REQUEST_ID

Returns the concurrent request ID.


#### FND_PROFILE

* FND_PROFILE.PUT (pname varchar, value varchar)

Puts a value to the specified user profile option. If the option does not exist,
you can also create it with PUT.

In Oracle all PUT operations are local, in other words, a PUT on the server affects only
the server-side profile cache, and a PUT on the client affects only the client-side cache.
By using PUT, you destroy the synchrony between server-side and client-side profile caches.
In this extension is only set the global variable, there is no server-side and client-side
profile caches.

Parameters:

	pname 	The (developer) name of the profile option you want to set.
	value 	The value to set in the specified profile option.

* FND_PROFILE.GET (pname varchar, INOUT value varchar)

Gets the current value of the specified user profile option, or NULL
if the profile does not exist. All GET operations are satisfied locally
in other words, a GET on the server is satisfied from the server-side
cache, and a GET on the client is satisfied from the client-side cache.
The server-side PL/SQL package FND_GLOBAL returns the values you need to
set Who columns for inserts and updates from stored procedures. You should
use FND_GLOBAL to obtain Who values from stored procedures rather than
using GET, which you may have used in prior releases of Oracle E-Business
Suite.

Parameters:

	pname 	The (developer) name of the profile option whose value you want to retrieve.
	value 	The current value of the specified user profile option as last set by PUT or as defaulted in the current user's profile.

* FND_PROFILE.VALUE (pname varchar)

VALUE works exactly like GET, except it returns the value of the specified
profile option as a function result.

Parameter:

	pname 	The (developer) name of the profile option whose value you want to retrieve.


### [Authors](#authors)

Gilles Darold
gilles@darold.net

### [License](#license)

This extension is free software distributed under the PostgreSQL
Licence.

        Copyright (c) 2022, MigOps Inc

