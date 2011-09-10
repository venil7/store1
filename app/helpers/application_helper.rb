# encoding: utf-8
module ApplicationHelper
  def currency(num)
    number_to_currency num, {:unit=>"€"}
  end
end

