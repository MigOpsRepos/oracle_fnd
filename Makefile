EXTENSION  = oracle_fnd
EXTVERSION = $(shell grep default_version $(EXTENSION).control | \
	       sed -e "s/default_version[[:space:]]*=[[:space:]]*'\([^']*\)'/\1/")

PGFILEDESC = "oracle_fnd - Oracle global profile variables API for PostgreSQL"

PG_CONFIG = pg_config

DOCS = $(wildcard README*)

DATA = $(wildcard updates/*--*.sql) $(EXTENSION)--$(EXTVERSION).sql

PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)

