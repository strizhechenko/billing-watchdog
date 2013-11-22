#!/bin/bash

. /cfg/config

login="username"
password="userpass"
secret="naspass"

params="User-Name=$login,User-Password=$password"
server=${app['radius.AUTH_IP']}:${app['radius.AUTH_PORT']}

auth_user() {
	echo "$params" | radclient -s "$server" auth "$secret"
}

init() {
	return 0
}

check() {
	auth_user || auth_user
}

fix() {
	/etc/init.d/radiusd restart
}

main() {
	init
	check && return 0 || fix
	check || return 1
}

main
