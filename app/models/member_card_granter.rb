# -*- encoding : utf-8 -*-
class MemberCardGranter < ActiveRecord::Base
  default_scope where("`member_card_granters`.deleted_at is NULL")
  belongs_to :member
  belongs_to :granter,:class_name => "Member",:foreign_key => "granter_id"
  belongs_to :members_card, :foreign_key => "member_card_id"
end
