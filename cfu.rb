require './lib/preprocessor'
require './lib/tokenizer'
require './lib/parser'
require_relative './lib/errors/malformed_args_error.rb'
include Preprocessor
include Tokenizer
include Parser

def display_help
  puts 'A help menu goes here'
end

args = {}
begin
  args = parse_args(ARGV)
rescue MalformedArgsError => e
  puts e.message
  display_help
end

tokenized_doc = tokenize_doc(File.read(args[:source_file]))

output = parse_doc(tokenized_doc)

puts output
