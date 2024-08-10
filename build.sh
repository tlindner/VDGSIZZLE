#!/bin/sh -x

lwasm sizzle.asm --decb -osizzle.bin --list=sizzle.lst
decb dskini VS.DSK
decb copy -t s.bas VS.DSK,S.BAS
decb copy -2b sizzle.bin VS.DSK,SIZZLE.BIN
