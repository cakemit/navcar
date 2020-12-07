module ApplicationHelper
  def price_mask_real(price)
    number_to_currency(price, unit: 'R$ ', separator: ',', delimiter: '.')
  end

  def full_title(page_title = '')
    base_title = 'Navcar'
    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end
end
