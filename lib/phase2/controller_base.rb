module Phase2
  class ControllerBase
    attr_reader :req, :res

    # Setup the controller
    def initialize(req, res)
      @req = req
      @res = res
      @already_built_res = false
    end

    # Helper method to alias @already_built_res
    def already_built_response?
      @already_built_res
    end

    # Set the res status code and header
    def redirect_to(url)
      @res.status = 302
      @res["Location"] = url
      raise "Cannot render content twice." if @already_built_res
      @already_built_res = true
    end

    # Populate the res with content.
    # Set the res's content type to the given type.
    # Raise an error if the developer tries to double render.
    def render_content(content, type)
      @res.content_type = type
      @res.body = content
      raise "Cannot render content twice." if @already_built_res
      @already_built_res = true
    end
  end
end
