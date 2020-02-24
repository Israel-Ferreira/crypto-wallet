module ApplicationHelper
  def attr_name(object, attribute)
    object.human_attribute_name(attribute)
  end
  
  def singular_or_plural(object)
    if object.size > 1
      object.model_name.human(count: object.size)
    else
      object.model_name.human
    end
  end
  
  def nome_aplicacao
    "Crypto Wallet"
  end
end
