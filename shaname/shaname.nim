#[
-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

]## Nim Shaname Utility
# Copyright (c) 2018 Torro
# 
# See the file "copying.txt" included in this
# directory for details about the copyright.

import parseopt, strutils, algorithm, os
import std/sha1

const
  Version = "0.1.0"
  Usage = "shaname v" & Version & ", rename files to their sha1sums" & """


Usage: shaname FILE [FILE]...

  -h, --help        shows this help
  -v, --version     shows the version

Copyright (c) 2018 Torro
"""

var
  filenames: seq[string] = @[]
  extension: string
  newfilename: string

proc writeHelp() =
  stdout.write(Usage)
  stdout.flushFile()
  quit(0)

proc writeVersion() =
  stdout.write(Version & "\n")
  stdout.flushFile()
  quit(0)

for kind, key, val in getopt():
  case kind
  of cmdArgument:
    filenames.add(key)
  of cmdLongOption, cmdShortOption:
    case key
    of "help", "h": writeHelp()
    of "version", "v": writeVersion()
  of cmdEnd: assert(false)
if filenames.len == 0:
  writeHelp()
else:
  for filename in filenames:
    extension = split(filename, '.').reversed()[0]
    newfilename = $(secureHashFile(filename)) & "." & extension

    moveFile(filename, newfilename)


#[
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEQQU+fteL+xbxiVcx5jn1x5OxYLQFAlr7+f4ACgkQ5jn1x5Ox
YLR0Yg//bUQlnwTRab3dH/wPoyWp5UwJhY//ngltqSyC01dLjwH5j+x5uAn1jCa5
XPy8yf9vaykIn/tkju9YeCqDdCSiCqLnDN+cpRvOVUftepYZ/tocwulL6B0s9Fuo
yv5YKtvsqDtyGbh4HpJbGJXXGTLMeHHA9MtAcVKdLlCZm8l7d1KBhM4CAs2Pza9v
oWt/k5L8Dv2fh/fBkxArBSRqJlC7VWADp39JrXTSIVr9q/75Po+s3V8LkxbGpnpy
xyji9SvBsBtCq5Kbc+JP3rq2/PqlzugcrGhrRiow3OWWQyu1vb6mN32asKa7iM85
EdvLmH4Jg4o8w/E5h/7ilAaGDcCFyo/D6PO/xNPmiKHOB4B3uznunyacfl8r6bts
h+73rDTeTbJyOGyOEc6KNDgamuO3A23QCJTdtZJGw6DICZPNHCTl4tP96luEv1zm
e7lONdVXbotgCA49CpgOR8RJxIO7u62VdPXyjJYilKK5pRbY6kPXGnknGRqHcoSx
E6cbDK/30soUtRzwNoF9UQHsDhWF8+CDZJuMLKnMHCsSFCJ28sMcMnrPmeVn8KEA
rWIzWKLVk4Fw1jVXlac5myZchhjpmblMytaZnm95z2mARuk2bJrRsFmr+IEEPBJT
8q1dKOE3HksjP4sH6MAWfxQXApjispaOaxUOc9vNG0d9Qo0f00Y=
=+UiO
-----END PGP SIGNATURE-----
]#