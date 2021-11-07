# frozen_string_literal: true

module Opal
  module Rake
    class Mapper
      class Opal < Mapper
        def opts(user_opt)
          {
            single: false,
            out: :js,
            dst_filename: "#{File.basename(@src, '.rb')}.js",
          }.merge(user_opt)
        end

        def run
          @app_folder = File.dirname(@src)
          add_file(dependencies) do
            builder = ::Opal::Builder.new
            builder.append_paths('.', @app_folder)
            build = builder.build(@src, source_map_enabled: true)
            File.binwrite(@dst, build.to_s)
          end
        end

        protected

        def dependencies
          if @opts[:single]
            @src
          else
            Dir["#{@app_folder}/**/*.rb"]
          end
        end
      end
    end
  end
end
