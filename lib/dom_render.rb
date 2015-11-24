#!/usr/bin/env ruby

# file: dom_render.rb

require 'rexle'


class DomRender

  attr_reader :to_a

  def initialize(x)
    
    doc = if x.kind_of? Rexle then
      x
    else
      Rexle.new x.gsub(/\n/,'')
    end
    
    @to_a = render doc.root
  end

  def render(x)
    
    style = x.attributes.has_key?(:style) ? fetch_style(x.attributes) : {}
    args = [x]
    args.concat([x.attributes, style])
    
    r = method(x.name.to_sym).call(*args)
    
    if r.last.empty? then
      r[0..-2]
    else
      r
    end
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
  
  private
  
  def fetch_style(attributes={})
    
    attributes[:style].split(';').inject({}) do |r, x| 
      k, v = x.split(':',2)
      r.merge(k.to_sym => v)
    end

  end
  
end
