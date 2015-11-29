#!/usr/bin/env ruby

# file: dom_render.rb

require 'rexle'

module InspectArray
      
  def scan(a, i=0)
    
    if a.first.is_a? Symbol
      
        puts a.inspect    
        
    else
      
      puts ('  ' * i) + '['

      a.each.with_index do |row, j|

        if row.is_a? String or row.is_a? Symbol then
          print ('  ' * (i+1)) + row.inspect
          print ',' unless a.length - 1 == j
          puts
        elsif row.first.is_a? Symbol or row.first.is_a? String
          puts ('  ' * (i+1)) + '['
          puts ('  ' * (i+2)) + row.inspect[1..-2]
          print ('  ' * (i+1)) + ']'
          print ',' unless a.length - 1 == j
          puts
        else
          scan(row,i+1)
          print ',' unless a.length - 1 == j
          puts
        end
      end

      print indent = ('  ' * i) + ']'
    end
  end
  
end

class DomRender
  include InspectArray
  
  attr_reader :to_a

  def initialize(x)
    
    raise "DomRender#initialize: supplied parameter cannot be nil" unless x
    
    doc = if x.kind_of? Rexle then
      x
    else
      Rexle.new x.gsub(/\n/,'')
    end
    
    @a = render doc.root
  end

  def render(x)
    
    style = x.attributes.has_key?(:style) ? fetch_style(x.attributes) : {}
    args = [x]
    args.concat([x.attributes, style])
    
    r = method(x.name.to_sym).call(*args)
    
    return unless r and r.length > 0

    if r.last.nil? or r.last.empty? then
      r[0..-2].flatten(1)
    else
      r
    end
  end

  def render_all(x)

    len = x.children.length - 1

    r = x.children.map.with_index do |obj,i|

      if obj.is_a? String then
        if obj.strip.length > 0 then
          i == 0 ? obj.lstrip.sub(/\s+$/,' ') : obj.sub(/^\s+/,' ')          
        else
          ''
        end
      elsif obj.is_a? Rexle::Element
        render obj
      end

    end

    r.compact

  end
  
  def to_a(inspect: false, verbose: false)
    
    if inspect or verbose then
      scan @a
      puts
    else
      @a
    end

  end
  
  private
  
  def fetch_style(attributes={})

    attributes[:style].split(';').inject({}) do |r, x|

      k, v = x.split(':',2)
      r.merge(k.to_sym => v)
    end

  end
  
  # expands a CSS shorthand for a margin or padding property
  # e.g. "1em 1.5em" #=> ['1em','1.5em','1em','1.5em']
  #
  def expand_shorthand(s)

    a = s.scan(/\d+(?:\.\d+)?\s*(?:em|px)?/)

    case a.length
    when 1 then [a[0]] * 4
    when 2 then [a[0],a[-1],a[0],a[-1]]
    when 4 then a
    else
      (a + [0,0,0,0]).take 4
    end
    
  end
    
end