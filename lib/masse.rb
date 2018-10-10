# frozen_string_literal: true

module Masse extend self
  VERSION = "1.0.0"

  def [](*errors)
    normalized_errors = errors.map(&method(:normalize_error))

    Module.new do
      define_singleton_method(:===) do |raised|
        normalized_errors.any? { |err| err === raised }
      end
    end
  end

  private

  Compatible = -> obj { obj.respond_to?(:===) }

  def normalize_error(err)
    case err
    when String, Regexp
      -> raised { err === raised.to_s }
    when Compatible
      err
    else
      raise ArgumentError,
        "Got unsupported argument: #{err.class}. Supported types are: " \
        "Exception, String, Regexp or anything responding to #===."
    end
  end
end
