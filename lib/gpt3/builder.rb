# frozen_string_literal: true

require 'k_log'
require "ruby/openai"

require 'gpt3/builder/version'
require 'gpt3/builder/gpt3_builder'

module Gpt3
  module Builder
    # raise Gpt3::Builder::Error, 'Sample message'
    class Error < StandardError; end

    # Your code goes here...
  end
end

if ENV['KLUE_DEBUG']&.to_s&.downcase == 'true'
  namespace = 'Gpt3Builder::Version'
  file_path = $LOADED_FEATURES.find { |f| f.include?('gpt3/builder/version') }
  version = Gpt3::Builder::VERSION.ljust(9)
  puts "#{namespace.ljust(35)} : #{version.ljust(9)} : #{file_path}"
end
