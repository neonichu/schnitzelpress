module Schnitzelpress
  class Config
    include Mongoid::Document
    include Mongoid::Timestamps
    identity :type => String
    store_in :config

    field :blog_title, :type => String, :default => "A New Schnitzelpress Blog"
    field :blog_description, :type => String, :default => ""
    field :blog_footer, :type => String, :default => "powered by [Schnitzelpress](http://schnitzelpress.org)"
    field :blog_feed_url, :type => String, :default => "/blog.atom"

    field :author_name, :type => String, :default => "Joe Schnitzel"

    field :disqus_id, :type => String
    field :google_analytics_id, :type => String
    field :gauges_id, :type => String
    field :twitter_id, :type => String

    field :podcast_category, :type => String
    field :podcast_subcategory, :type => String
    field :podcast_logo, :type => String
    field :podcast_owner, :type => String, :default => "joe@schnitzelpress.org"
    field :podcast_keywords, :type => String

    field :cache_timestamp, :type => DateTime

    validates :blog_title, :author_name, :podcast_owner, :presence => true

    class << self
      def instance
        @@instance ||= find_or_create_by(:id => 'schnitzelpress')
      end

      def forget_instance
        @@instance = nil
      end

      def get(k)
        instance.send(k)
      end

      def set(k, v)
        instance.update_attributes!(k => v)
        v
      end
    end
  end
end
