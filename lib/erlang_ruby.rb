require "erlang_ruby/version"
require "erlang_ruby/terms"
require "erlang_ruby/utils"

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
