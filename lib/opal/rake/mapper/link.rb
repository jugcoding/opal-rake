# frozen_string_literal: true

module Opal
  module Rake
    class Mapper
      class Link < Mapper
        def opts(user_opt)
          {
            out: :root,
            dst_filename: File.basename(@src),
          }.merge(user_opt)
        end

        def run
          add_rule do
            sh "ln -rs #{@src} #{@dst}"
          end
        end
      end
    end
  end
end
