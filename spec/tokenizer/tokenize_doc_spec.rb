require_relative '../../lib/tokenizer.rb'

describe 'Tokenizer::tokenize_doc' do
  include Tokenizer
  let(:doc) { File.read('./spec/example-docs/simple-doc.cgt') }
  let(:class_type) { :class }
  let(:class_name) { 'hello' }
  it 'tokenizes a cgt document' do
    tokenized_doc = tokenize_doc(doc)
    expect(tokenized_doc.kind_of?(Array)).to eq true
    expect(tokenized_doc.length).to eq 1
    expect(tokenized_doc.first[:id]).to eq class_name
    expect((tokenized_doc.first[:type])).to eq class_type
    expect((tokenized_doc.first[:items].kind_of?(Hash))).to eq true
  end
end
