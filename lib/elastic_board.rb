require "elastic_board/summary"
require "sinatra/base"

module ElasticBoard
  
  class Application < Sinatra::Base
    
    # Setup paths for public and views
    dir = File.dirname(File.expand_path(__FILE__))
    set :views,  "#{dir}/elastic_board/views"
    set (respond_to?(:public_folder) ? :public_folder : :public), "#{dir}/elastic_board/public"
    
    # Connection to ElasticSearch
    attr_accessor :connection
    
    # Initializer Override to get options
    def initialize(options = { })
      self.connection = options[:connection]
      super
    end
    
    # ===================
    # = Sinatra Helpers =
    # ===================
    
    helpers do
      def path_prefix
        request.env['SCRIPT_NAME']
      end
      
      def url_path(*path_parts)
        [path_prefix, path_parts].join('/').squeeze('/')
      end
      
      def script_tag(*path_parts)
        %(<script src="#{url_path(%w(js) + path_parts)}"></script>)
      end
      
      def stylesheet_tag(*path_parts)
        %(<link href="#{url_path(%w(css) + path_parts)}" rel="stylesheet">)
      end
      
      def header_badge(summary)
        case summary.cluster_status
        when 'green'
          { :class => 'badge-success', :message => 'All Systems Go' }
        when 'yellow'
          { :class => 'badge-warning', :message => 'Having Some Problems' }
        when 'red'
          { :class => 'badge-important', :message => 'Everything is in Flames' }
        end
      end
    end
    
    # ==================
    # = Sinatra Routes =
    # ==================
    
    get '/' do
      @summary = ElasticBoard::Summary.new(self.connection)
      
      erb :index
    end
    
  end
  
end