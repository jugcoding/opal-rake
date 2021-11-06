# frozen_string_literal: true

module Opal
  module Rake
    module Build
      module_function

      def config=(config)
        config.each { |params| Rake.mappers[params[0]].run(*params[1..]) }
      end
    end
  end
end
