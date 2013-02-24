# -*- encoding : utf-8 -*-
require 'spec_helper'

describe MembersCard do
  describe "associations" do
    it { should belong_to :card   }
    it { should belong_to :member }
    it { should have_many :orders }
  end
end
