require "bundler/setup"
require "sinatra/base"
require "rubberband"
require "elastic_board"

map '/elasticboard' do
  run ElasticBoard::Application.new(:connection => (ElasticSearch.new("localhost:9200") rescue nil))
end