# frozen_string_literal: true

module Opal
  module Rake
    class Mapper
      class Slim < Mapper
        def run(source, out_path)
          @src = source
          @dst = "#{Rake.dist[out_path]}/#{basename(source, '.slim')}"
          add_rule do
            File.binwrite(@dst, ::Slim::Template.new(@src).render)
          end
        end
      end
    end
  end
end
