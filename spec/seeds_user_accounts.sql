TRUNCATE TABLE posts, user_accounts RESTART IDENTITY;

INSERT INTO user_accounts (email_address, username) VALUES ('a_user@gmail.com', 'user A');
INSERT INTO user_accounts (email_address, username) VALUES ('b_userB@yahoo.com', 'user B');
INSERT INTO user_accounts (email_address, username) VALUES ('c_userC@hotmail.com', 'user C');

