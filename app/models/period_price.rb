# -*- encoding : utf-8 -*-
class PeriodPrice < ActiveRecord::Base
  include Clientable

  has_many :periodable_period_prices
  scope :of_datetype, lambda {|date_type| where(:period_type => date_type)}
  scope :within_time_span, lambda { |start_time, end_time| where("start_time BETWEEN :start_time AND :end_time OR :start_time BETWEEN start_time AND end_time",
                                                                 { :start_time => start_time.sec_offset,:end_time =>  end_time.sec_offset}) }
  scope :within_hour_span, lambda { |start_hour, end_hour| where("start_time BETWEEN :start_time AND :end_time OR :start_time BETWEEN start_time AND end_time",
                                                                 { :start_time => start_hour * 3600,:end_time =>  end_hour * 3600}) }


  validates :name,  :presence => {:message => "时段名称不能为空！"}, :uniqueness => { :message => "名称不能重复" }
  validates :price, :numericality => {:message => "时段价格必须为数字！"}
  validate :validate_start_time_end_time
  #validate :no_overlap_allowed
  validates_presence_of :start_time, :end_time, :message => "时段开始时间和结束时间不能空"


  def validate_start_time_end_time
    self.errors.add(:start_time, "开始时间应小于结束时间") if self.start_time >= self.end_time 
  end

  def no_overlap_allowed
    existing_pp = self.class.where({ :period_type => self.period_type, :client_id => self.client_id })
    self.errors.add(:start_time, "时段冲突， 请调整开始或者结束时间") if existing_pp.any?{ |pp| pp.overlaps? self }
  end

  def overlaps?(other_time_range)
    self != other_time_range && (start_time - other_time_range.end_time) * (other_time_range.start_time - end_time) > 0
  end

  def end_hour
    end_time / 3600
  end

  def start_hour
    start_time / 3600
  end

end

