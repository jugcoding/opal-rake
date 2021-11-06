# frozen_string_literal: true

using Rainbow

module Opal
  module Rake
    class << self
      include ::Rake::DSL

      attr_reader :dist, :mappers, :targets

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

        task(:cleanup) { cleanup }
        task(:server) { run_server }
      end

      def run_server
        sh 'bundle exec foreman start'
      end

      def cleanup
        sh "rm -rI #{dist[:root]}"
        sh 'rm -rI ./node_modules'

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
