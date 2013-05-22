# -*- encoding : utf-8 -*-
class CourtBookRecord < BookRecord
  def court
    resource
  end

  def price(members_card = nil)
    members_card.present? ? members_card.card.total_money_in_time_span(self) : court.calculate_amount_in_time_span(alloc_date, start_time, end_time)
  end

  def description
    court.name + "(" + alloc_date.strftime("%Y-%m-%d  ") + start_time.strftime("%H") + ":00 - " + end_time.strftime("%H") + ":00" + ")"
  end

  def period_prices
    court.period_prices.of_datetype(court.client.date_type(alloc_date)).within_time_span(start_time, end_time)
  end

end
