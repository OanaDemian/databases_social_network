require 'user_account_repository'
require 'database_connection'
require 'post_repository'

RSpec.describe 'UserAccountRepository' do
  def reset_user_accounts_table
    seed_sql = File.read('spec/seeds_user_accounts.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
    connection.exec(seed_sql)
  end
  
  describe UserAccountRepository do
    before(:each) do 
      reset_user_accounts_table
    end

  it 'lists all the user accounts' do
    repo = UserAccountRepository.new
    user_accounts = repo.all
    expect(user_accounts.length).to eq 3
    expect(user_accounts[0].id).to eq '1'
    expect(user_accounts[0].email_address).to eq 'a_user@gmail.com'
    expect(user_accounts[0].username).to eq'user A'
    expect(user_accounts[1].id).to eq '2'
    expect(user_accounts[1].email_address).to eq 'b_userB@yahoo.com'
    expect(user_accounts[1].username).to eq 'user B'
  end

  it 'Get a single user_account' do
    repo = UserAccountRepository.new
    user_account = repo.find(3) 
    expect(user_account.id).to eq '3'
    expect(user_account.email_address).to eq 'c_userC@hotmail.com'
    expect(user_account.username).to eq 'user C'
  end

  it 'creates a new user_account' do

    repo = UserAccountRepository.new
    user_account = UserAccount.new
    user_account.email_address = 'd_user@microsoft.com'
    user_account.username = 'user D'
    repo.create(user_account) # => nil
    
    expect(repo.all.length).to eq 4
    expect(repo.all.last.email_address).to eq 'd_user@microsoft.com'
    expect(repo.all.last.username).to eq 'user D'
  end

  it 'deletes an user account' do
    repo = UserAccountRepository.new
    posts_associated_with_account = PostRepository.new
    posts_associated_with_account.delete_by_user_account(1)
    repo.delete(1) # => nil
    expect(repo.all.length).to eq 2
    expect(repo.all[0].email_address).to eq 'b_userB@yahoo.com'
    expect(repo.all[0].username).to eq 'user B'

  end

end
end