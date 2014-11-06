require_relative '../phase5/controller_base'

module Phase6
  class ControllerBase < Phase5::ControllerBase
    # use this with the router to call action_name (:index, :show, :create...)
    def invoke_action(name)
      name = name.to_s
      send(name)
      render(name) unless @already_built_res
    end
  end
end
