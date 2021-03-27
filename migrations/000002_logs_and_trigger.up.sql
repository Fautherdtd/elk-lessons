CREATE TABLE logs (
    id SERIAL PRIMARY KEY,
    post_id INT NOT NULL,
    operation VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE OR REPLACE FUNCTION add_to_logs() RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO logs(post_id,operation,created_at) values (NEW.id,'insert',NOW());
        RETURN NEW;
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO logs(post_id,operation,created_at) values (NEW.id,'update',NOW());
        RETURN NEW;
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO logs(post_id,operation,created_at) values (NEW.id,'delete',NOW());
        RETURN OLD;
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER t_log_posts AFTER INSERT OR UPDATE OR DELETE ON posts FOR EACH ROW EXECUTE PROCEDURE add_to_logs();