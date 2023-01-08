CREATE TABLE user_accounts (
  id SERIAL PRIMARY KEY,
  email_address text,
  username text
);
CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  title text,
  content text,
  views int,
  user_account_id int,
  constraint fk_user_account foreign key(user_account_id)
    references user_accounts(id)
    on delete cascade
);


INSERT INTO user_accounts (email_address, username) VALUES ('a_user@gmail.com', 'user A');
INSERT INTO user_accounts (email_address, username) VALUES ('b_userB@yahoo.com', 'user B');
INSERT INTO user_accounts (email_address, username) VALUES ('c_userC@hotmail.com', 'user C');

INSERT INTO posts (title, content, views, user_account_id) VALUES ('title 1', 'content 1', 100, 1);
INSERT INTO posts (title, content, views, user_account_id) VALUES ('title 2', 'content 2', 200, 3);
INSERT INTO posts (title, content, views, user_account_id) VALUES ('title 3', 'content 3', 300, 2);
INSERT INTO posts (title, content, views, user_account_id) VALUES ('title 4', 'content 4', 300, 3);
INSERT INTO posts (title, content, views, user_account_id) VALUES ('title 5', 'content 5', 100, 2);
INSERT INTO posts (title, content, views, user_account_id) VALUES ('title 6', 'content 6', 200, 1);
INSERT INTO posts (title, content, views, user_account_id) VALUES ('title 7', 'content 7', 400, 1);


