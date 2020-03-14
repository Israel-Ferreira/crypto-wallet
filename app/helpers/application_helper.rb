module ApplicationHelper
  def attr_name(object, attribute)
    if defined? object.human_attribute_name(attribute)
      object.human_attribute_name(attribute)
    else
      object.class.human_attribute_name(attribute)
    end
  end
  
  def singular_or_plural(object, count=1)
    if count > 1
      object.model_name.human(count: object.size)
    else
      object.model_name.human
    end
  end
  
  def nome_aplicacao
    "Crypto Wallet"
  end
end
