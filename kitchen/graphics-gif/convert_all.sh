#!/bin/bash

for gif in *.gif;
do
	convert -flatten "$gif" "../${gif%.gif}.png"
done

