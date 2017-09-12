require 'unirest'
require "pry"
class PingboardClient
  attr_accessor :client_id, :client_secret, :token

  def initialize
    @base_uri = "https://app.pingboard.com"
    @client_id = "ed8dad3f7ae75ac338c48422abc8aa90b2847bd415d58e151bd8edf6b206d17e"
    @client_secret = "37ffa04049a14ba1c3d26eba52c78f1e116c5195fa3cd7e0a3ed459e6708fe54"
    @groups = {}
    # TODO isn't there a more rubyish way to do this?
    if @client_id.nil? || @client_id.empty?
      raise ArgumentError, "client_id is not defined. Check PINGBOARD_CLIENT_ID env var"
    end

    if @client_secret.nil? || @client_secret.empty?
      raise ArgumentError, "client_secret is not defined. Check PINGBOARD_CLIENT_SECRET env var"
    end

    # Unirest.timeout(120)
  end

  def get_by_email(email)
    token = get_token
    token = "321e09fb5769010dd36b351305e3756c8d58685d636390a75a8f46b474c686c5"
    response = Unirest.get "#{@base_uri}/api/v2/search/users?q=email?q=#{email}",
                            headers:{ "Authorization" => "Bearer #{token}" }
    if response.code != 200
      return nil
    end

    # should be the first one on exact email match
    candidate = response.body['hits']['hits'][0]
    if candidate['_source']['email'].eql?(email)
      return candidate['_source']
    end

    nil
  end

  # get all users
  def get_users
    token = get_token
    token = "321e09fb5769010dd36b351305e3756c8d58685d636390a75a8f46b474c686c5"
    response = Unirest.get "#{@base_uri}/api/v2/users?page_size=1000",
                           headers:{ "Authorization" => "Bearer #{token}" }
    binding.pry
    if response.code != 200
      return nil
    end
    response.body['users']
  end

  def get_token
    response = Unirest.post "https://app.pingboard.com/oauth/token?grant_type=client_credentials",
                            headers:{ "Content-Type" => "application/x-www-form-urlencoded" },
                            parameters:{ :client_id => @client_id, :client_secret => @client_secret }
    binding.pry
    response.body['access_token']
  end

  def get_group_by_id(group_id)
    if @groups[group_id]
      return @groups[group_id]
    end

    token = get_token
    response = Unirest.get "#{@base_uri}/api/v2/groups/#{group_id}",
                            headers:{ "Authorization" => "Bearer #{token}" }

    if response.nil?
      return nil
    end

    if response.body['groups']
      # cache responses
      @groups[group_id] = response.body['groups'][0]
      return response.body['groups'][0]
    end

    nil
  end
end
