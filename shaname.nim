#[
-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

]## Nim Shaname Utility
# Copyright (c) 2018 Torro
# 
# See the file "copying.txt" included in this
# directory for details about the copyright.

import parseopt, strutils, algorithm, sha1, os

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

iQIzBAEBCgAdFiEEQQU+fteL+xbxiVcx5jn1x5OxYLQFAlr5yzUACgkQ5jn1x5Ox
YLQcAA/+IfJVU5nVg5KthHCzydMD9cgEdo/KW8BNiDEUkHClPfEapyLduRrQRnr5
VWrP4zv2Y6vgHj0xdKtvwMu2K5YFwVwCC2YWWWqKmK/4isVacgHO5ld1dc0NtrgF
22aCqiF6tGyrIeQpc/dLemt8+0XXSGisQkQcFu15g2GARfF1CG0TaQFHpxEhywTH
DWGNmLyUZqnaeao84ZDnycJ72Ij0rvSOeHOm4yIPraMrUPN8SCTEWrSSHe4JyJNi
ShASwOqc37rFilqKzdETrUPfZAJ6F7k0IMV1/8lJlYhzXCBFVHui0WU5iGMC/Wu8
7XgFmObcu+T0ALuGsDzcv61q3U1EBoXqwIA8H7ICKy59GqzxFGEXsY+p7LFamoRM
VadV7iGmw9IhP9D+Ts4iSdCpBExAuQJmC3AgoQZmax2KWOjFKaAlBK0+6AlHnCEC
UqChTDv2nlwxgSr3qeJULoV+OjkP11pFKjf+Dupou25pt5V3hwJVPPaqYiAS9inq
KJ3BlUkFDbMwxS53ew8l9oyNmK20XnWUPu0+8CD2NAfMF/S9rbEbESpMWu6Arf3u
4sQIU/VzQ8LwBvuGovAqJTl5gw7PNBHvtS+JfHiZH8D/L/n02LKpkd0dZkOuBA24
ZiImSxfH2xgo2Ur3Nd/v5qvQuBQxf4WwTEXiN2GFgOywelzB7ww=
=EF/Z
-----END PGP SIGNATURE-----
]#