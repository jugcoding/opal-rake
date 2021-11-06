# frozen_string_literal: true

module Opal
  module Rake
    class Mapper
      class Opal < Mapper
        def run(source, out_path = :js)
          @src = source
          @dst = "#{Rake.dist[out_path]}/#{basename(source, '.rb', '.js')}"
          add_rule do
            builder = ::Opal::Builder.new
            builder.append_paths('.', './app')
            build = builder.build(@src, source_map_enabled: false)
            File.binwrite(@dst, build.to_s)
          end
        end
      end
    end
  end
end
