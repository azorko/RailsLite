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
      params = {}
      params_arr = URI::decode_www_form(www_encoded_form)
      params_arr.each do |key, val|
        current = params
        key_arr = parse_key(key)
        key_arr[0..-2].each do |key|
          current[key] ||= {}
          current = current[key]
        end
        current[key_arr[-1]] = val
      end
      params
    end

    # this should return an array
    # user[address][street] should return ['user', 'address', 'street']
    def parse_key(key)
      key.split(/\]\[|\[|\]/)
    end
  end
end
