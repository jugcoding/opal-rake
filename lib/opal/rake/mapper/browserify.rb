# frozen_string_literal: true

module Opal
  module Rake
    class Mapper
      class Browserify < Mapper
        CMD = './node_modules/.bin/browserify'
        def run(source, out_path = :js)
          @src = source
          @dst = "#{Rake.dist[out_path]}/#{basename(source)}"
          add_rule do
            system "#{CMD} #{@src} -o #{@dst}"
          end
        end
      end
    end
  end
end
