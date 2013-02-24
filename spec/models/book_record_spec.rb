# -*- encoding : utf-8 -*-
require 'spec_helper'

describe BookRecord do
  it { should belong_to :order }
  it { should belong_to :resource }
end
