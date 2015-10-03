describe CassetteExplorer::Server do
  describe '.from_command_line' do
    it 'should accept the path of the fixures as first argument' do
      expect(CassetteExplorer::Server).to receive(:new).with(path: 'some/path')
      CassetteExplorer::Server.from_command_line(['some/path'])
    end

    it 'should accept the shorthand relative_urls -r' do
      expect(CassetteExplorer::Server).to receive(:new)
        .with(path: 'some/path', relative_urls: true)
      CassetteExplorer::Server.from_command_line(['some/path', '-r'])
    end

    it 'should not create a server with an invalid argument' do
      expect(CassetteExplorer::Server).to_not receive(:new)
      CassetteExplorer::Server.from_command_line(['some/path', '--potato'])
    end

    it 'should not create a server without a path' do
      expect(CassetteExplorer::Server).to_not receive(:new)
      CassetteExplorer::Server.from_command_line(['-r'])
    end
  end

  describe '#run', type: :feature do
    before :all do
      VCR.use_cassette 'first_cassette', record: :new_episodes do
        Typhoeus.get('http://store.steampowered.com/app/8870/') # Bioshock Infinite
        Typhoeus.get('http://store.steampowered.com/app/8930/') # Civilization V
      end

      VCR.use_cassette 'second_cassette', record: :new_episodes do
        Typhoeus.get('http://store.steampowered.com/app/250900/') # Binding of Isaac: Rebirth
      end

      VCR.use_cassette 'with_path/third_cassette', record: :new_episodes do
        Typhoeus.get('http://store.steampowered.com/app/42910/') # Magicka
      end

      VCR.use_cassette 'fourth_cassette', record: :new_episodes do
        Typhoeus.get('http://store.steampowered.com/app/42910/') # Magicka again
      end

      @server = CassetteExplorer::Server.new(path: 'spec/fixtures/vcr_cassettes')
      @thread = @server.run(false)
    end

    after :all do
      @thread.kill
    end

    it 'should list all the cassettes on the index' do
      visit '/'
      expect(page).to have_content 'http://store.steampowered.com/app/8870/'
      expect(page).to have_content 'http://store.steampowered.com/app/8930/'
      expect(page).to have_content 'http://store.steampowered.com/app/250900/'
      expect(page).to have_content 'http://store.steampowered.com/app/42910/'
    end

    it 'should display the content of the page if given the parameters' do
      visit '/?' + URI.encode_www_form(url: 'http://store.steampowered.com/app/8870/', file: '/first_cassette.yml')
      expect(page).to have_content 'Indebted to the wrong people, with his life on the line, veteran of the U.S. Cavalry and now hired gun, '
    end
  end
end
