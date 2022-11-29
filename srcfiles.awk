BEGIN {
  print "\\newwrite\\src\\immediate\\openout\\src=SRCFILEs.txt.tmp"
  print "\\def\\ProvidesPackage#1[#2]{\\immediate\\write\\src{\\filename : #2}}"
  print "\\def\\ProvidesFile#1[#2]{\\immediate\\write\\src{\\filename : #2}}"
}
BEGINFILE {
  printf "%s%s%s", "\\def\\filename{", FILENAME, "}"
}
/\\def\\fileversion/ {
  print
}
/^\\Provides/ {
  print
  getline
  print
}
END {
  print "\\immediate\\closeout\\src"
  print "\\bye"
}
