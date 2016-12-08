# frozen_string_literal: true
module ApplicationHelper
  def nested_comment(comment)
    comment.map do |comment, sub_comment|
      render(comment) + content_tag(:div, nested_comment(sub_comment), class: 'nested_comment')
    end.join.html_safe
  end
end
