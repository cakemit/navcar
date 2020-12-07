module ApplicationHelper
  # formats a number#float to BRZ currency standard
  def price_mask_real(price)
    number_to_currency(price, unit: 'R$ ', separator: ',', delimiter: '.')
  end

  # returns a date as string formatted to dd-mmm-yyyy (01-Jan-2020)
  def date_mask(date)
    date.strftime("%d-%b-%Y")
  end

  # customizes title of each view
  def full_title(page_title = '')
    base_title = 'Navcar'
    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end
end
