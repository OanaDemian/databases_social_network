TRUNCATE TABLE posts RESTART IDENTITY; 

INSERT INTO posts (title, content, views, user_account_id) VALUES ('title 1', 'content 1', 100, 1);
INSERT INTO posts (title, content, views, user_account_id) VALUES ('title 2', 'content 2', 200, 3);
INSERT INTO posts (title, content, views, user_account_id) VALUES ('title 3', 'content 3', 300, 2);
INSERT INTO posts (title, content, views, user_account_id) VALUES ('title 4', 'content 4', 300, 3);
INSERT INTO posts (title, content, views, user_account_id) VALUES ('title 5', 'content 5', 100, 2);
INSERT INTO posts (title, content, views, user_account_id) VALUES ('title 6', 'content 6', 200, 1);
INSERT INTO posts (title, content, views, user_account_id) VALUES ('title 7', 'content 7', 400, 1);