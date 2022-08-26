require 'account_repo'
require 'timeline_post_repo'

RSpec.describe AccountRepository do

    def reset_accounts_table
        seed_sql = File.read('spec/seeds_accounts.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network2' })
        connection.exec(seed_sql)
    end
  
    before(:each) do 
        reset_accounts_table
    end
  
    it 'get all accounts' do
        repo = AccountRepository.new
        accounts = repo.all

        expect(accounts.length).to eq 4
        expect(accounts[0].id).to eq '1'
        expect(accounts[0].username).to eq 'Jamesbeaumont26'
        expect(accounts[0].email_address).to eq 'jamesbeaumont26@gmail.com'

        expect(accounts[1].id).to eq '2'
        expect(accounts[1].username).to eq 'LeoHetsch'
        expect(accounts[1].email_address).to eq 'leohetsch@hotmail.co.uk'

        expect(accounts[3].id).to eq '4'
        expect(accounts[3].username).to eq 'RoiDriscoll123'
        expect(accounts[3].email_address).to eq 'RoiDriscoll@hotmail.co.uk'
    end

    it 'returns username details based on id' do
        repo = AccountRepository.new

        username = repo.find(1)

        
        expect(username.first.username).to eq 'Jamesbeaumont26'
        expect(username.first.email_address).to eq 'jamesbeaumont26@gmail.com'
    end

    it 'creates new name and then returns all usernames' do
        repo = AccountRepository.new

        account = Account.new
        account.username = 'James Beaumont the second'
        account.email_address = 'jamesbeaumonthesecond@hotmail.com'

        repo.create(account)

        all_accounts = repo.all

        expect(all_accounts).to include(
            have_attributes(username: account.username, email_address: account.email_address)
        )
    end 

    it 'deletes username' do
        repo = AccountRepository.new
        account = repo.find(1)

        repo.delete(account.first.username)

        all_accounts = repo.all
        expect(all_accounts.first.username).to eq 'LeoHetsch'
    end
end

RSpec.describe TimelinePostRepository do
    
    def reset_timeline_table
        seed_sql = File.read('spec/seeds_timeline_posts.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network2' })
        connection.exec(seed_sql)
    end
  
    before(:each) do 
        reset_timeline_table
    end

    it 'returns all posts' do
        repo = TimelinePostRepository.new
        timelines = repo.all

        expect(timelines.length).to eq 2

        expect(timelines[0].id).to eq '1'
        expect(timelines[0].title).to eq 'First post'
        expect(timelines[0].content).to eq 'This is my first post ever'
        expect(timelines[0].views).to eq '15'
        expect(timelines[0].username_id).to eq '2'

        expect(timelines[1].id).to eq '2'
        expect(timelines[1].title).to eq 'James` First post'
        expect(timelines[1].content).to eq 'This is my first post ever'
        expect(timelines[1].views).to eq '25'
        expect(timelines[1].username_id).to eq '1'
    end

    it 'creates new post' do
        repo = TimelinePostRepository.new

        timeline = TimelinePost.new
        timeline.title = 'James Beaumont the second has posted'
        timeline.content = 'James Beaumont the second has made a timeline post'

        repo.create(timeline)

        all_timelines = repo.all

        expect(all_timelines).to include(
            have_attributes(title: timeline.title, content: timeline.content)
        )
    end

    it 'returns timeline post details based on id' do
        repo = TimelinePostRepository.new

        timeline = repo.find(1)

        expect(timeline.first.title).to eq 'First post'
        expect(timeline.first.content).to eq 'This is my first post ever'

        timeline2 = repo.find(2)

        expect(timeline2.first.title).to eq 'James` First post'
        expect(timeline2.first.content).to eq 'This is my first post ever'
    end

    it 'deletes post' do
        repo = TimelinePostRepository.new
        timeline = repo.find(1)

        repo.delete(timeline.first.title)

        all_timelines = repo.all
        expect(all_timelines.first.title).to eq 'James` First post'
    end
end