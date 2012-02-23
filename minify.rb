#!/usr/bin/env ruby

exit 1 unless ARGV.length > 0

in_string = false;
str = IO.read(ARGV[0])

header=%{<!doctype html>
<html>
  <head>
    <title>Aleph you - @seanseefried</title>
    <meta charset="utf-8" />
  </head>
  <body>
    <canvas id="c"></canvas>
    <script>
      var b = document.body;
      var c = document.getElementsByTagName('canvas')[0];
      var a = c.getContext('2d');
      document.body.clientWidth; // fix bug in webkit: http://qfox.nl/weblog/218
    </script>
<!--start--><script>}

footer=%{</script>
</body>
</html>}


oneline= str.gsub(/^[\s]*/,"").
         gsub(/\/\/.*/,"").
         gsub(/\\$/,"").
         gsub(/[\s]*\n/,"").

         gsub(/.*<\!--start--><script>/,"").
         gsub(/<\/script><\/body><\/html>/,"")

puts oneline

File.open("/tmp/test.html","w") do |f|
  f.write(header + oneline + footer);
  f.close
end

# system("scp /tmp/test.html 'mco:/home/sseefried/domains/seanseefried.com/public/js1k/index.html'")
system('open -a "/Applications/Google Chrome.app" /tmp/test.html')

# (0..str.length - 1).each do |i|
#   in_string = !in_string if str[i] == "\""[0]
#   printf("%s",str[i].chr) unless str[i].chr =~ /\s/ && !in_string
# end
