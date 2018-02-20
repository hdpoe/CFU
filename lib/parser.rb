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
    footer = ''

    document.each do |line|
      result.concat(parse_line(line))
      footer = "}\n" if line[:type] == :class
    end
    result.concat(footer)
    result
  end

  def parse_line(line) 
    result = ''
    if line[:type] == :class 
      if line[:items][:visibility] == :every
        result.concat('public class ')
      end
    end
    result.concat(line[:id] + " {\n")
    result
  end
end
