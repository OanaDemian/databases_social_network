require 'post_repository'

RSpec.describe PostRepository do
  def reset_posts_table
    seed_sql = File.read('spec/seeds_posts.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
    connection.exec(seed_sql)
  end
  
  describe PostRepository do
    before(:each) do 
      reset_posts_table
    end
  
    it 'returns all users posts' do
      repo = PostRepository.new
      posts = repo.all

      expect(posts.length).to eq 7
      expect(posts[0].id).to eq'1'
      expect(posts[0].title).to eq 'title 1'
      expect(posts[0].content).to eq 'content 1'
      expect(posts[0].views).to eq '100'
      expect(posts[0].user_account_id).to eq'1'
      expect(posts[1].id).to eq'2'
      expect(posts[1].title).to eq 'title 2'
      expect(posts[1].content).to eq 'content 2'
      expect(posts[1].views).to eq '200'
      expect(posts[1].user_account_id).to eq'3'
    end

    it 'finds a post by id' do
      repo = PostRepository.new
      find_post = repo.find(1)
      expect(find_post.title).to eq 'title 1'
      expect(find_post.views).to eq '100'
      expect(find_post.content).to eq 'content 1'
      expect(find_post.user_account_id).to eq '1'
    end

    it 'creates a new post' do
      repo = PostRepository.new
      post = Post.new
      post.title = 'title 8'
      post.content = 'content 8'
      post.views = '350'
      post.user_account_id = '2'

      repo.create(post) # => nil

      expect(repo.all.length).to eq 8
      expect(repo.all.last.title).to eq 'title 8'
      expect(repo.all.last.content).to eq 'content 8'
      expect(repo.all.last.views).to eq '350'
      expect(repo.all.last.user_account_id).to eq '2'
    end

    it 'creates another new post' do
      repo = PostRepository.new
      post = Post.new
      post.title = 'title 9'
      post.content = 'content 9'
      post.views = '50'
      post.user_account_id = '3'

      repo.create(post) # => nil

      expect(repo.all.length).to eq 8
      expect(repo.all.last.title).to eq 'title 9'
      expect(repo.all.last.content).to eq 'content 9'
      expect(repo.all.last.views).to eq '50'
      expect(repo.all.last.user_account_id).to eq '3'
    end

    it 'deletes a post by id' do
      repo = PostRepository.new
      expect(repo.find(1).title).to eq 'title 1'
      repo.delete(1) # => nil
      expect(repo.all.length).to eq 6
      expect(repo.all.first.title).to eq 'title 2'
    end

    it 'deletes a post by user_account_id' do
      repo = PostRepository.new
      expect(repo.find(1).user_account_id).to eq '1'
      repo.delete_by_user_account(1)  # => nil
      expect(repo.all.length).to eq 4
      expect(repo.all.first.title).to eq 'title 2'
    end
  end
end