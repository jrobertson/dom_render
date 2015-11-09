# Introducing the dom_render gem

    require 'dom_render'


    class Html < DomRender

      def p(x)
        render_all x
      end

      def b(x)
        [:bold_on, render_all(x), :bold_off]
      end

    end



    s =<<EOF
    <p>this is test of the 
      <b>bold</b>
     text
    </p>
    EOF

    a = Html.new(s).to_a
    => ["this is test of the ", [:bold_on, ["bold"], :bold_off], " text"]

## Resources

* dom_render https://rubygems.org/gems/dom_render

dom_render domrender dom html engine
