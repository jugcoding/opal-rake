# frozen_string_literal: true

module Opal
  module Rake
    class Mapper
      class Browserify < Mapper
        def opts(user_opt)
          {
            out: :js,
            dst_filename: File.basename(@src),
          }.merge(user_opt)
        end

        CMD = './node_modules/.bin/browserify'
        def run
          add_rule do
            system "#{CMD} #{@src} -o #{@dst}"
          end
        end
      end
    end
  end
end
