# -*- encoding : utf-8 -*-
require 'spec_helper'
require 'ostruct'

include ActionView::Helpers::FormOptionsHelper 

describe "SiteSetting" do
  before :all do
    @setting = OpenStruct.new(YAML.load(IO.read("#{Rails.root}/config/site_setting.yml"))[Rails.env])
  end

  it "should load default settings" do
    expect(SiteSetting.minimum_warn_amount).to eq(@setting.minimum_warn_amount)
  end

  it "should raise error if key not exist" do
    lambda {SiteSetting.to_options("not_exist")}.should raise_error(ArgumentError)
  end

  it "should raise if value with key not array" do
    lambda {SiteSetting.to_options("minimum_warn_amount")}.should raise_error(ArgumentError)
  end


  it "cert type should return valid html snipplets" do
    SiteSetting.to_options("cert_type").should eq(options_for_select(@setting.cert_type))
  end


  it "default value should considered" do
    SiteSetting.to_options("cert_type", @setting.cert_type.last).should eq(options_for_select(@setting.cert_type, @setting.cert_type.last))
  end
end
