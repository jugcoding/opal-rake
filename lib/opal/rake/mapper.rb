# frozen_string_literal: true

using Rainbow

module Opal
  module Rake
    class Mapper
      include ::Rake::DSL

      class << self
        def initialize
          @subclasses.each do |klass|
            singleton = klass.new
            Rake.mappers[singleton.key] = singleton
          end
        end

        def inherited(subclass)
          super(super)

          @subclasses ||= []
          @subclasses << subclass
        end
      end

      def key
        self.class.name.split('::').last.downcase.to_sym
      end

      def run(_params, _output_folder)
        raise 'not implemented'
      end

      protected

      def add_rule(&compiler)
        Rake.targets[:compile] << @dst

        rule @dst => @src do
          log
          compiler.call
          optimize
          register_asset
        end
      end

      def log
        puts "compile: #{@src.blue} => #{@dst.green}"
      end

      def optimize; end

      def register_asset; end

      def basename(filename, ext = '', new_ext = nil)
        "#{File.basename(filename, ext)}#{new_ext}"
      end
    end
  end
end
