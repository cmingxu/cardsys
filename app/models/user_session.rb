# -*- encoding : utf-8 -*-
class UserSession < Authlogic::Session::Base
  
  before_destroy :reset_persistence_token
  before_create  :reset_persistence_token

  def reset_persistence_token
    record.reset_persistence_token
  end   

  def to_key
    now = Time.now
    ["#{now.to_i}","#{now.usec}","#{Process.pid}"]
  end

end
