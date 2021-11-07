# frozen_string_literal: true

module Opal
  module Rake
    class Mapper
      class Slim < Mapper
        def opts(user_opt)
          {
            out: :root,
            dst_filename: File.basename(@src, '.slim'),
          }.merge(user_opt)
        end

        def run
          add_rule do
            File.binwrite(@dst, ::Slim::Template.new(@src).render)
          end
        end
      end
    end
  end
end
