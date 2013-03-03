class Date
  def weekday?
    (1..5).to_a.include? self.wday
  end

  def weekend?
    !weekday?
  end
end
