def reset_tables
  seed_users_sql = File.read('spec/seeds_user_accounts.sql')
  seed_posts_sql = File.read('spec/seeds_posts.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_users_sql)
  connection.exec(seed_posts_sql)
end