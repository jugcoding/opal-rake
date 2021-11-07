# frozen_string_literal: true

using Rainbow

module Opal
  module Rake
    class Mapper
      include ::Rake::DSL

      class << self
        def initialize
          @subclasses.each do |klass|
            Rake.mappers[key(klass)] = klass
          end
        end

        def key(klass)
          klass.name.split('::').last.downcase.to_sym
        end

        def inherited(subclass)
          super(super)

          @subclasses ||= []
          @subclasses << subclass
        end
      end

      def initialize(key, source, opts)
        @key = key
        @src = source
        @opts = opts(opts || {})

        @opts[:dst_path] = Rake.paths[@opts[:out]]
        @dst = [@opts[:dst_path], @opts[:dst_filename]].join('/')

        run
      end

      protected

      def add_rule(&compiler)
        Rake.targets[:compile] << @dst

        rule @dst => @src do
          compile(&compiler)
        end
      end

      def add_file(deps, &compiler)
        Rake.targets[:compile] << @dst

        file @dst => deps do
          compile(&compiler)
        end
      end

      def compile(&compiler)
        log
        compiler.call
        optimize
        register_asset
      end

      def log
        puts "compile: #{@src.blue} => #{@dst.green}"
      end

      def optimize; end

      def register_asset; end
    end
  end
end
