class Date
  def weekday?
    (1..5).to_a.include? self.wday
  end

  def weekend?
    !weekday?
  end

end

class Time
  def sec_offset
    Integer(self - self.beginning_of_day)
  end
end
