# frozen_string_literal: true

module Opal
  module Rake
    module Setup
      module_function

      extend ::Rake::DSL

      TASKS = %i[npm npm_dev].freeze
      def config=(config)
        config.each do |key, value|
          TASKS.include?(key) ? add_task(key, value) : send(key, value)
        end
      end

      def add_task(key, values)
        Rake.targets[:setup] << key

        task key do
          values.each { |v| send(key, v) }
        end
      end

      def directory(names)
        names.each { |f| FileUtils.mkdir_p f }
      end

      def config(config)
        Rake.config.merge(config)
      end

      def dist(config)
        Rake.dist = config
      end

      def npm_dev(package)
        npm(package, '--save-dev')
      end

      def npm(package, opts = nil)
        Rake.sh "npm install #{opts} #{package}"
      end
    end
  end
end
