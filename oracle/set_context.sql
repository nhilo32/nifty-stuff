
-- creates a view that takes arguments

CREATE TABLE T (x INT);
INSERT INTO T 
  SELECT ROWNUM x FROM dual
  CONNECT BY LEVEL <= 10;

COMMIT;

SELECT * FROM T;

CREATE OR REPLACE CONTEXT ctx USING ctx_api;

CREATE OR REPLACE PACKAGE ctx_api AS

  PROCEDURE set_filter(val IN VARCHAR2, val2 in varchar2);
  
END ctx_api;
/

CREATE OR REPLACE PACKAGE BODY ctx_api IS

  PROCEDURE set_filter(val IN VARCHAR2, val2 in varchar2) IS
  BEGIN
    dbms_session.set_context('CTX', 'user_id', val);
    dbms_session.set_context('CTX', 'role_id', val2);
  END set_filter;

END ctx_api;
/

CREATE OR REPLACE VIEW vw AS 
  SELECT * FROM T
  WHERE  x = sys_context('CTX', 'user_id');
  
EXEC ctx_api.set_filter(333, 27);

SELECT * FROM nir.vw;


DBMS_SESSION.CLEAR_CONTEXT (p_context_namespace, DBMS_SESSION.unique_session_id);
DBMS_SESSION.set_context ('DMLIIS_SEARCH_CONTEXT', 'CURRENTOWNER', p_current_owner, 
	USER, DBMS_SESSION.unique_session_id);

SELECT * FROM DBA_CONTEXT;
