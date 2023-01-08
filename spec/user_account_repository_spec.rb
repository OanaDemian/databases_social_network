require 'user_account_repository'
require 'database_connection'

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
    expect(user_accounts[1].email_address).to eq 'b_user@gmail.com'
    expect(user_accounts[1].username).to eq 'user B'
  end
end
end