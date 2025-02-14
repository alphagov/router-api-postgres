/**
 * This file contains custom functions which can't be  represented in db/schema.rb
 * The database schema is held in db/schema.rb – this file just supplements it.
 * See Rakefile for how this file gets imported.
 */

CREATE FUNCTION notify_event() RETURNS TRIGGER AS $$
  BEGIN
    PERFORM pg_notify('notify', NOW()::text);
    RETURN NULL;
  END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER routes_notify_event AFTER INSERT OR UPDATE OR DELETE ON routes FOR EACH ROW EXECUTE PROCEDURE notify_event();

CREATE TRIGGER backends_notify_event AFTER INSERT OR UPDATE OR DELETE ON backends FOR EACH ROW EXECUTE PROCEDURE notify_event();

CREATE TRIGGER users_notify_event AFTER INSERT OR UPDATE OR DELETE ON users FOR EACH ROW EXECUTE PROCEDURE notify_event();
