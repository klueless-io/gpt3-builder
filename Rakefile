# frozen_string_literal: true

# source: https://stephenagrice.medium.com/making-a-command-line-ruby-gem-write-build-and-push-aec24c6c49eb

GEM_NAME = 'gpt3-builder'

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'gpt3/builder/version'

RSpec::Core::RakeTask.new(:spec)

require 'rake/extensiontask'

desc 'Compile all the extensions'
task build: :compile

Rake::ExtensionTask.new(GEM_NAME) do |ext|
  ext.lib_dir = 'lib/gpt3/builder'
end

desc 'Publish the gem to RubyGems.org'
task :publish do
  system 'gem build'
  system "gem push #{GEM_NAME}-#{Gpt3::Builder::VERSION}.gem"
end

desc 'Remove old *.gem files'
task :clean do
  system 'rm *.gem'
end

task default: %i[clobber compile spec]
