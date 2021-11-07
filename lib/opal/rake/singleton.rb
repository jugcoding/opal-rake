# frozen_string_literal: true

using Rainbow

module Opal
  module Rake
    class << self
      include ::Rake::DSL

      attr_reader :config, :paths, :mappers, :targets

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

      def paths=(config)
        @paths = config
      end

      def mkdir_paths
        @paths.each_value { |dir| FileUtils.mkdir_p dir }
      end

      def install_tasks
        @targets[:setup].push(:mkdir_paths, :compile)

        @targets.each do |name, dependencies|
          task name => dependencies
        end

        task(:reset) { reset }
        task(:full_reset) { full_reset }
        task(:mkdir_paths) { mkdir_paths }
      end

      def run_server
        sh 'bundle exec foreman start -f Procfile.dev'
      end

      def full_reset
        sh "rm -rI #{paths[:root]}" if File.exist? paths[:root]
        sh 'rm -rI ./node_modules' if File.exist? './node_modules'

        ::Rake::Task[:setup].invoke
      end

      def reset
        sh "rm -rI #{paths[:root]}" if File.exist? paths[:root]

        ::Rake::Task[:mkdir_paths].invoke
        ::Rake::Task[:compile].invoke
      end

      def sh(cmd)
        puts cmd.green
        system(cmd)
      end
    end
  end
end
