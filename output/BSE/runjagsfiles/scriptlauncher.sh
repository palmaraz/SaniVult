#!/bin/sh
	i=$1
	'/usr/bin/jags' < sim.$i/script.cmd > sim.$i/jagsoutput.txt 2>&1 &

	echo $! > sim.$i/jagspid.txt
	