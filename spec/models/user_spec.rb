# -*- encoding : utf-8 -*-
require 'spec_helper'

describe User do
  it "should include module Clientable" do
    User.ancestors.should include(Clientable)
  end

  it "should valide belong to specfic client if not site admin account" do
    u = User.new
    u.valid?
    u.errors[:client_id].should_not be_empty
  end

  it "should pass validation on client_id if site admin account" do
    u = User.new :role => User::SITE_ADMIN
    u.save.should be_true
  end
end
