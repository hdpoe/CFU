module Parser

  TOKEN_MAP = {
    class_field: 'static',
    class_method: 'static',
    every: 'public',
    only: 'private',
    neighbor: 'protected',
  }

  def parse_doc(document)
    result = ''

    document.each do |line|
      result.concat(parse_line(line))
      'public static '
    end
  end

  def parse_line(line) 
  end
end
