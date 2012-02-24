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
         gsub(/\/\*.*/,"").
         gsub(/\\$/,"").
         gsub(/[\s]*\n/,"").
         gsub(/.*<\!--start--><script>/,"").
         gsub(/<\/script><\/body><\/html>/,"")


[[ "g", "funs"        ],
 [ "l", "all"         ],
 [ "m", "mod"         ],
 [ "n", "xPan"        ],
 [ "o", "yPan"        ],
 [ "p", "theta"       ],
 [ "q", "heartMap"    ],
 [ "s", "scale"       ],
 [ "t", "tile"        ],
 [ "v", "pixBuf"      ],
 [ "A", "aleph"       ],
 [ "I", "img"         ],
 [ "O", "isOneHeart"  ],
 [ "P", "pan"         ],
 [ "R", "render"      ],
 [ "S", "sgn"         ],
 [ "Z", "zoom"        ]
 ].each do |short_name,long_name|
  oneline = oneline.gsub(/#{long_name}/,short_name)
end

puts oneline

File.open("/tmp/test.html","w") do |f|
  f.write(header + oneline + footer);
  f.close
end

if ARGV.length >= 2
  s = ARGV[1]
  system('open -a "/Applications/Firefox.app" /tmp/test.html') if (s == "-f" || s == "--firefox")
  system('open -a "/Applications/Google Chrome.app" /tmp/test.html') if (s == "-c" || s == "--chrome")
  if (s == '-d' || s == '--deploy')
    system('scp /tmp/test.html mco:/home/sseefried/domains/seanseefried.com/public/js1k/index.html')
  end
end
