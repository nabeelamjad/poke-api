# Only to generate proper ruby file name convention

files = Dir.glob('*')

def replace_name(input)
  input.gsub(/\.(?=[^.]*\.)/, '_').downcase
end

files.each do |file|
  fopen = File.open(file)

  new_body = fopen.each_line.map do |x|
    if x =~ /require_relative 'pog/i
      x = x.sub('require', 'require_relative').downcase.tr('.', '_')
    end
    x
  end.join

  File.open(file, 'w') {|f| f.puts new_body }
end

files.each {|f| File.rename(f, replace_name(f))}
