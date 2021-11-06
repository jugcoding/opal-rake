# frozen_string_literal: true

module Opal
  module Rake
    class Mapper
      class Sass < Mapper
        def run(source, out_path = :css)
          @src = source
          @dst = "#{Rake.dist[out_path]}/#{basename(source, '.sass')}"
          add_rule do
            sass = File.read(@src)
            css = SassC::Engine.new(sass, syntax: :sass, style: :compressed).render
            File.binwrite(@dst, css)
          end
        end
      end
    end
  end
end
