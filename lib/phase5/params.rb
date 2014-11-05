require 'uri'
require 'byebug'

module Phase5
  class Params
    # use your initialize to merge params from
    # 1. query string -> 
    # 2. post body -> what an example? 
    # 3. route params -> what's an example?
    #
    # You haven't done routing yet; but assume route params will be
    # passed in as a hash to `Params.new` as below:
    def initialize(req, route_params = {})
      # p "qs - #{req.query_string}"
#       p "body - #{req.body}"
      parsed_query_string = (req.query_string ? parse_www_encoded_form(req.query_string) : {})
      parsed_body = (req.body ? parse_www_encoded_form(req.body) : {})
      @params = parsed_query_string.merge!(route_params).merge!(parsed_body)
    end

    def [](key)
      @params[key.to_s]
    end

    def to_s
      @params.to_json.to_s
    end

    class AttributeNotFoundError < ArgumentError; end;

    private
    # this should return deeply nested hash
    # argument format
    # user[address][street]=main&user[address][zip]=89436
    # should return
    # { "user" => { "address" => { "street" => "main", "zip" => "89436" } } }
    def parse_www_encoded_form(www_encoded_form)
      params = Hash.new { |h, k| h[k] = {} }
      params_arr = URI::decode_www_form(www_encoded_form)
      params_arr.each do |key, val|
        key_arr = parse_key(key)
        key_arr.each do |key|
          params.each do 
        end
        # key_hash = create_nested_hash(key_arr, val)
      end
      params
    end
    
    # def create_nested_hash(key_arr, val)
#       hash = {}
#       return val if key_arr.empty?
#       hash[key_arr.shift] = create_nested_hash(key_arr, val)
#     end

    # this should return an array
    # user[address][street] should return ['user', 'address', 'street']
    def parse_key(key)
      key.split(/\]\[|\[|\]/)
    end
  end
end
