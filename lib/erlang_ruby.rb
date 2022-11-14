require_relative "erlang_ruby/version.rb"
require_relative "erlang_ruby/terms.rb"
require_relative "erlang_ruby/utils.rb"

module ErlangRuby
  class Decoder
    def self.perform(data)
      decoder_data = data.dup
      version, rest_of_data = Utils.read_first(decoder_data)
      raise "Cannot understand this version" if version != 131

      ruby_term, _ = ErlangRuby::Terms.build(rest_of_data)
      ruby_term.decode
    end
  end
end
