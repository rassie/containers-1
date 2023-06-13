#!/usr/bin/env bash

globalTests+=(
    ca-certificates-update
)

globalExcludeTests+=(
	# nanoservcer/windowsservercore: updating local store with additional certificates is not implemented
	[:nanoserver_ca-certificates-update]=1
	[:windowsservercore_ca-certificates-update]=1
)
