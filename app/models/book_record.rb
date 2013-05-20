# -*- encoding : utf-8 -*-
class BookRecord < ActiveRecord::Base

  attr_accessor :start_hour, :end_hour
  belongs_to  :order
  belongs_to  :resource, :polymorphic => true
  has_many :order_items, :as => :item, :dependent => :destroy

  scope :daily_book_records, lambda {|date| where(:alloc_date => date) }
  scope :court_book_records, lambda {|court_id| where(:court_id => court_id) }

  def start_date_time
    day = self.alloc_date.to_datetime
    Time.local(day.year, day.month, day.day, start_hour)
  end

  def end_date_time
    day = self.alloc_date.to_datetime
    if end_hour == 24
      Time.local(day.year,day.month,day.day,23,59)
    else
      Time.local(day.year,day.month,day.day,end_hour)
    end
  end

  def name
    resource.try(:name)
  end

  def hours
    end_hour - start_hour
  end


  def exist_conflict_record?
    conlict_record = conflict_record_in_time_span
    conlict_record && (original_book_reocrd.nil? && conlict_record.id != id  || original_book_reocrd.id != conlict_record.id)
  end

  def conflict_record_in_time_span
    conflict_record = self.class.where(:alloc_date => alloc_date,:court_id => court_id).where(["start_hour < :end_time AND end_hour > :start_time",
                                                                                                {:start_time => start_hour,:end_time => end_hour}])
    conflict_record = conflict_record.where("id<>#{self.id}") unless new_record?
    conflict_record.first
  end

  def start_hour
    self.start_time.hour
  end

  def end_hour
    self.end_time.hour
  end

  private

  def is_time_span_ready_to_order?
    if end_hour  <= start_hour
      order_errors << I18n.t('order_msg.book_record.invalid_time_span')
    elsif  !is_to_do_agent? and exist_conflict_record? 
      order_errors << I18n.t('order_msg.book_record.exist_time_span',:date => alloc_date.to_s(:db),:start_time => start_hour,:end_time => end_hour)
    elsif is_to_do_agent? && (conlict_record = conflict_record_in_time_span)
      if is_a_valid_agented_record?(conlict_record)
        I18n.t('order_msg.book_record.invalid_agent',:start_time => conlict_record.start_hour,
               :end_time => conlict_record.end_hour)
      end
    end
  end

end
