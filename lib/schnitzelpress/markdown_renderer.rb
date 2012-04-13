module Schnitzelpress
  class EnclosureRenderer < Redcarpet::Render::HTML
    attr_reader :enclosures

    def initialize
      super()
      self.reset
    end

    def image(link, title, alt_text)
      if link.match(/m4a$|mp3$/)
      then
        @enclosures.push(link)
      end

      return ''
    end

    def reset
      @enclosures = []
    end
  end

  class MarkdownRenderer < Redcarpet::Render::HTML
    include Redcarpet::Render::SmartyPants

    def block_code(code, language)
      CodeRay.highlight(code, language)
    end

    def image(link, title, alt_text)
      oembed = OEmbed::Providers.get(link)
      %q(<div class="embedded %s %s">%s</div>) % [oembed.type, oembed.provider_name.parameterize, oembed.html]
    rescue OEmbed::NotFound
      if link.match(/m4a$|mp3$/)
      then
        %q(<audio controls="controls"><source type="audio/mp3" src="%s" /></audio>) % [link]
      else
        %q(<img src="%s" title="%s" alt="%s"/>) % [link, escape_html(title), escape_html(alt_text)]
      end
    end

    def escape_html(html)
      Rack::Utils.escape_html(html)
    end
  end
end
