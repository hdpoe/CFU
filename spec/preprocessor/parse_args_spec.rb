require_relative '../../lib/preprocessor.rb'
require_relative '../../lib/errors/malformed_args_error.rb'

describe 'Preprocessor::parse_args' do
  include Preprocessor
  let(:input_file) { 'example-file.cgt' }
  let(:output_file) { 'output_file.code' }
  let(:target_language) { 'target_language' }
  context 'with an acceptable arguments' do
    let(:args) { ['-i', input_file, '-o', output_file, '-l', target_language] }
    it 'will parse arguments and return a hash of the argumements' do
      resulting_args = parse_args(args)
      expect(resulting_args.kind_of?(Hash)).to eq true
      expect(resulting_args[:source_file]).to eq input_file
      expect(resulting_args[:target_file]).to eq output_file
      expect(resulting_args[:lang]).to eq target_language
    end
  end

  context 'with a single argument' do
    let(:args) { [input_file] }
    it 'will return a hash with a key value pair of source_file: <name of file to act on>' do
      resulting_args = parse_args(args)
      expect(resulting_args.kind_of?(Hash)).to eq true
      expect(resulting_args[:source_file]).to eq input_file
    end
  end

  context 'with malformed arguments' do
    let(:malformed_args_1) { [] }
    let(:malformed_args_2) { ['-i', input_file, '-o', '-l' ] }
    let(:malformed_args_3) { ['-o', output_file, '-l', target_language] }
    let(:malformed_args_4) { ['-i', input_file, '-q', 'nonsense' ]}
    it 'throws a MalformedArgs error' do 
      expect { parse_args(malformed_args_1) }.to raise_error(MalformedArgsError)
      expect { parse_args(malformed_args_2) }.to raise_error(MalformedArgsError)
      expect { parse_args(malformed_args_3) }.to raise_error(MalformedArgsError)
      expect { parse_args(malformed_args_4) }.to raise_error(MalformedArgsError)
    end
  end
end
