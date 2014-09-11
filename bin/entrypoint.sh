#!/bin/bash

#set -eu

appHelp () {
	echo "Available options:"
	echo " app:start          - Starts the rails server "
	echo " app:help           - Displays the help (default)"
	echo " [command]          - Execute the specified linux command eg. bash."
}

appStart () {
    echo "Starting rails application ..."

    foreman export supervisord /tmp -a app -u ruby -l "/app/log" -f "/app/Procfile.production"
    sed -i s:bundle:`which bundle`: /tmp/app.conf
    #sudo cp /config/supervisord.conf /etc/supervisor/conf.d/
    sudo cp /tmp/app.conf /etc/supervisor/conf.d/
    exec sudo /usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf
}



case "$1" in
	app:start)
		appStart
		;;
	app:help)
		appHelp
		;;
	*)
		if [ -x $1 ]; then
			$1
		else
			prog=$(which $1)
			if [ -n "${prog}" ] ; then
				shift 1
				$prog $@
			else
				appHelp
			fi
		fi
		;;
esac