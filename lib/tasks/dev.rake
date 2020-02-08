namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      tasks = [
        {command: "db:drop", start_msg: "Apagando o banco de dados", end_msg: "Banco de dados apagado com sucesso" },
        {command: "db:create", start_msg: "Criando o banco de dados", end_msg: "Banco de dados criado com sucesso" },
        {command: "db:migrate", start_msg: "Migrando o BD", end_msg: "Migração realizada com sucesso" },
      ]
      
      tasks.each do |task| 
        show_spinner(task[:start_msg], task[:end_msg]) { %x(rails #{task[:command]}) } 
      end
      %x(rails dev:add_mining_types )
      %x(rails dev:add_coins)
    else
      puts "Você não está no ambiente de desenvolvimento"
    end
  end
  
  
  desc "Cadastra as Moedas"
  task add_coins: :environment do
    show_spinner("Cadastrando Moedas", "Moedas Cadastradas com Sucesso") do
      coins = [
        { description: "Bitcoin", acronym: "BTC",url_image: "http://pngimg.com/uploads/bitcoin/bitcoin_PNG47.png", mining_type: MiningType.find_by(acronym: 'PoW') },
        { description: "Ethereum", acronym: "ETH",url_image: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b7/ETHEREUM-YOUTUBE-PROFILE-PIC.png/600px-ETHEREUM-YOUTUBE-PROFILE-PIC.png", mining_type: mining_type_sample()},
        { description: "Dash", acronym: "DASH", url_image: "https://assets.coingecko.com/coins/images/19/large/dash-logo.png?1548385930", mining_type: mining_type_sample()},
        { description: "Iota", acronym: "IOT", url_image: "https://img2.gratispng.com/20180712/tkc/kisspng-iota-cryptocurrency-logo-internet-of-things-tether-aren-5b481f06b57ae1.5360095415314531907434.jpg", mining_type: mining_type_sample() },
        { description: "ZCash", acronym: "ZEC", url_image: "https://images.cointelegraph.com/images/240_aHR0cHM6Ly9zMy5jb2ludGVsZWdyYXBoLmNvbS9zdG9yYWdlL3VwbG9hZHMvdmlldy8yOWYxNDY5Nzg1NjI0MWFmMTQyMGU0MWJiOTNlNDY0Mi5wbmc=.png", mining_type: mining_type_sample() }
      ]
      
      
      coins.each { |coin| Coin.find_or_create_by!(coin) }
    end
  end
  
  desc "Cadastra os tipos de mineração"
  task add_mining_types: :environment do
    show_spinner("Cadastrando Tipos de Mineração", "Tipos de Mineração Cadastrados com Sucesso") do
      mining_types = [
        { description: "Proof of Work", acronym: "PoW" },
        { description: "Proof of Stake", acronym: "PoS"},
        { description: "Proof of Capacity", acronym: "PoC"}
      ]
      
      
      mining_types.each { |mt| MiningType.find_or_create_by!(mt) }
    end
  end
  
  
  
  
  
  private
    def show_spinner(start_msg,end_msg)
      spinner = TTY::Spinner.new("[:spinner] #{start_msg} ...")
      spinner.auto_spin
      if block_given?
        yield
        spinner.success("(#{end_msg})")
      else
        spinner.error("(ERRO: Não foi passado o bloco)")
      end
    end
    
    
    def mining_type_sample()
      MiningType.all.sample()
    end
end
