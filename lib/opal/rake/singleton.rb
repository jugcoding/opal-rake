# frozen_string_literal: true

using Rainbow

module Opal
  module Rake
    class << self
      include ::Rake::DSL

      attr_reader :config, :dist, :mappers, :targets

      def initialize
        @mappers = {}
        @targets = {
          compile: [],
          setup: [],
          default: [:compile]
        }
      end

      def config=(config)
        initialize

        Mapper.initialize
        Setup.config = config[:setup]
        Build.config = config[:build]

        install_tasks
      end

      def dist=(config)
        @dist = config
        @dist.each do |key, value|
          next if key == :root

          @dist[key] = "#{@dist[:root]}/#{value}"
        end
      end

      def mkdir_dist
        @dist.each_value { |dir| FileUtils.mkdir_p dir }
      end

      def install_tasks
        @targets.each do |name, dependencies|
          task name => dependencies
        end

        task(:reset) { reset_setup }
        task(:setup) { reset_setup }
        task(:server) { run_server }
      end

      def run_server
        sh 'bundle exec foreman start -f Procfile.dev'
      end

      def reset_setup
        sh "rm -rI #{dist[:root]}" if File.exist? dist[:root]
        sh 'rm -rI ./node_modules' if File.exist? './node_modules'

        mkdir_dist
        ::Rake::Task[:setup].invoke
        ::Rake::Task[:compile].invoke
      end

      def sh(cmd)
        puts cmd.green
        system(cmd)
      end
    end
  end
end
