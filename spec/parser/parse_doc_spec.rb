require_relative '../../lib/parser.rb'

describe 'Parser::parse_doc' do
  include Parser

  let(:input_document) do
    {
      id: 'Hello',
      type: :class,
      items: {
        visibility: :every
      }
    }
  end

  it 'returns a string that indicates the class skeleton' do
    result_doc = parse_doc([input_document])
    expect(result_doc).to eq "public class Hello {\n}\n"
  end
end
