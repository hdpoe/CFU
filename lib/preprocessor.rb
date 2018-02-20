module Preprocessor
  FLAGS = %w(-i -o -l)
  FLAG_DEF = {
    '-i' => :source_file,
    '-o' => :target_file,
    '-l' => :lang
  }

  def parse_args(provided_args) 
    raise MalformedArgsError, 'No arguments provided' if provided_args.empty?
    raise MalformedArgsError, 'Invlalid argument provided' if provided_args.any? do |arg|
      arg[0] == '-' && !FLAGS.include?(arg)
    end 
    return { source_file: provided_args.first }  if provided_args.length == 1
    raise MalformedArgsError, 'Require -i flag to indicate which file to parse' unless provided_args.include?('-i')
    args = {}
    provided_args.each_with_index do |arg, i|
      if FLAGS.include?(arg)
        args[FLAG_DEF[arg]] = provided_args[i + 1] 
        raise MalformedArgsError, "Missing args for #{arg} flag" if FLAGS.include?(provided_args[i + 1])
      end
    end
    args
  end
end
