module ApplicationHelper
  def data_br(data_us)
    data_us.strftime("%d/%m/%Y")
  end
  
  def locale(locale)
    I18n.locale == :en ? "Inglês - EUA" :  "Português do Brasil"
  end
  
  def nome_aplicacao
    "Crypto Wallet"
  end
end
