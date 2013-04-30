module ElasticBoard
  class Summary
    
    attr_accessor :connection
    
    def initialize(*servers)
      if servers.first.is_a?(ElasticSearch::Client)
        self.connection = servers.first
      else
        self.connection = ElasticSearch.new(servers)
      end
    end
    
    # ===================
    # = State Functions =
    # ===================
    
    def cluster_state
      @cluster_state ||= self.connection.cluster_state
    end
    
    # ==================
    # = Node Functions =
    # ==================
    
    def nodes_info
      @nodes_info ||= self.connection.nodes_info
    end
    
    def nodes
      nodes = [ ]
      nodes_info['nodes'].each do |key, node_details|
        nodes << {
          :name    => node_details['name'],
          :address => extract_ip_from_address(node_details['transport_address'])
        }
      end
      
      return nodes
    end
    
    # ===================
    # = Index Functions =
    # ===================
    
    def index_status
      @index_status ||= self.connection.index_status
    end
    
    def indices
      index_status['indices']
    end
    
    # ====================
    # = Health Functions =
    # ====================
    
    def cluster_health
      @cluster_health ||= self.connection.cluster_health
    end
    
    def cluster_name
      cluster_health['cluster_name']
    end
    
    def cluster_status
      cluster_health['status']
    end
    
    def number_of_nodes
      cluster_health['number_of_nodes']
    end
    
    def active_shards
      cluster_health['active_shards']
    end
    
    def active_primary_shards
      cluster_health['active_primary_shards']
    end
    
    def number_of_nodes
      cluster_health['number_of_nodes']
    end
    
    def unassigned_shards
      cluster_health['unassigned_shards']
    end
    
    private
    
    def extract_ip_from_address(address)
      address.match(/\s*\[\/(.*)\]/)[1]
    end
    
  end
end