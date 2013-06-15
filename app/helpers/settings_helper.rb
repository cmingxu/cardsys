# -*- encoding : utf-8 -*-
module SettingsHelper
  def setting_boolean_options(default=true)
    options_for_select [["是", true], ["否", false]], default
  end

  def setting_month_begining_options
    options_for_select (1..31).collect{|day| ["#{day}号", day] }
  end

  def setting_tagable(client, field)
    array = client.send(field) if client.respond_to?(field)
    array = [] unless array
    str = %Q{
      #{text_field_tag field, nil, :class => "taginput"}
      <a class="btn" id="#{field}_btn">添加</a>
      <div id="#{field}_container" style="display: #{array.size > 0 ? 'block' : 'none'}" class="tagable">
        <ul class="tags-list">
    }   
    str += array.collect{|item| 
      %Q{ 
        <li class="tag">
          <span>#{item}</span>
          #{hidden_field_tag "client[#{field}][]", item, :class => "tag-hidden-field"}
          <a class="close-tag">x</a>
        </li> }
    }.join 
    str += "</ul></div>"
  end
end
