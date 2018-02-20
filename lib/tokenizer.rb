module Tokenizer

  TOKEN_MAP = {
    'C' => :class,
    'F' => :class_field,
    'M' => :class_method,
    'f' => :field,
    'm' => :method,
    'o' => :only,
    'r' => :restricted,
    'e' => :every,
    'n' => :neighbor,
    'g' => :get,
    'w' => :write,
    'i' => :int,
    'c' => :char,
    'y' => :byte,
    'a' => :array
  }
  def tokenize_doc(document)
    result = []
    document.each_line do |line|
      next if line.empty? || line[0] == '#'
      result << tokenize_line(line) 
    end
    result
  end

  def tokenize_line(source_line)
    line = {}
    source_line.gsub!(/\s+/, '')
    declaration, return_modifiers, id, params = source_line.split(';')
    line[:type] = TOKEN_MAP[declaration[0]]
    line[:id] = id
    line[:items] = map_tokens(declaration, return_modifiers, params)
    line
  end

  def map_tokens(declaration, return_modifiers, args)
    token_body = {}
    token_body[:visibility] = TOKEN_MAP[declaration[1]]

    if TOKEN_MAP[declaration[0]] == :method ||
        TOKEN_MAP[declaration[0]] == :class_method
      token_body[:return_type] = TOKEN_MAP[return_modifiers[0]] 
      token_body[:parameters] = map_params(args)
    elsif TOKEN_MAP[declaration[0]] == :field ||
      TOKEN_MAP[declaration[0]] == :class_field
      token_body[:read] = TOKEN_MAP[return_modifiers[0]]
      token_body[:write] = TOKEN_MAP[return_modifiers[1]]
    end

    token_body
  end

  def map_prams(args)
    args.split(',').collect do |arg|
      { id: arg.split(':')[0], data_type: arg.split(':')[1] }
    end
  end
end
