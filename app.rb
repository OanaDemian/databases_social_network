require_relative 'lib/user_account_repository'
require_relative 'lib/database_connection'
require_relative 'lib/user_account'


DatabaseConnection.connect('social_network_test')
account_user = UserAccountRepository.new

account_user.all.each do |record|
  puts "#{record.id} - #{record.email_address} - #{record.username}"
end