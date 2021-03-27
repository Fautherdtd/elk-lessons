SELECT 
        logs.id as logs_id, logs.post_id as logs_post_id, logs.operation as logs_operation,
        post.id, post.title, post.description, post.body, post.category, post.verifed, post.factor
FROM logs
        LEFT JOIN posts post ON post.id = logs.post_id
WHERE logs.id > :sql_last_value ORDER BY logs.id;