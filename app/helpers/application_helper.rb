# encoding: utf-8
module ApplicationHelper
  def currency(num)
    number_to_currency num, {:unit=>"€"}
  end

  def invoice_number(num)
    "%08d" % num
  end
end

