# frozen_string_literal: true

module Opal
  module Rake
    class Mapper
      class Sass < Mapper
        def opts(user_opt)
          {
            out: :css,
            dst_filename: File.basename(@src, '.sass'),
          }.merge(user_opt)
        end

        def run
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
