# ElasticBoard

An ElasticSearch status board as a Rack middleware for Ruby applications.

## Installation

Add this line to your application's Gemfile:

    gem 'elastic_board'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install elastic_board

## Usage

The status board uses the [Rubberband Gem](https://github.com/grantr/rubberband) and an instance of `ElasticSearch::Client`

Load it in your `config.ru` file with an instance of `ElasticSearch::Client`

    map '/elasticboard' do
      run ElasticBoard::Application.new(
        :connection => (ElasticSearch.new("localhost:9200") rescue nil)
      )
    end
    
If you use something like Escargot and ActiveRecord in your application, you can re-use the connection like so:

    map '/elasticboard' do
      run ElasticBoard::Application.new(
        :connection => (Escargot.connection rescue nil)
      )
    end
    
From there, just go to `/elasticboard` and check it out.

Note: `rescue nil` is a nice safety in the event that your app is unable to connect to ElasticSearch, it will still boot.  If you don't leave ES running on your development machine, this will let your app continue to boot regardless of whether or not ES is running.  ElasticBoard will handle a nil connection gracefully.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request