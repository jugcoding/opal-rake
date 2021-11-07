# frozen_string_literal: true

module Opal
  module Rake
    module Build
      module_function

      def config=(config)
        config.each do |p|
          Rake.mappers[p[0]].new(p[0], p[1], p[2])
        end
      end
    end
  end
end
