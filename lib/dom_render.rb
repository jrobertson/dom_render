#!/usr/bin/env ruby

# file: dom_render.rb

require 'rexle'


class DomRender

  attr_reader :to_a

  def initialize(s)
    @to_a = render Rexle.new(s).root
  end

  def render(x)
    method(x.name.to_sym).call(x)
  end

  def render_all(x)

    len = x.children.length - 1

    x.children.map.with_index do |obj,i|

      if obj.is_a? String then
        i == 0 ? obj.lstrip.sub(/\s+$/,' ') : obj.rstrip.sub(/^\s+/,' ')
      elsif obj.is_a? Rexle::Element
        render obj
      end

    end

  end
end
