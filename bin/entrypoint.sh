#!/bin/bash

set -eu

sudo cp /config/supervisord.conf /etc/supervisor/conf.d/

appHelp () {
	echo "Available options:"
	echo " app:start          - Starts the rails server "
	echo " app:rake <task>    - Execute a rake task."
	echo " app:help           - Displays the help (default)"
	echo " [command]          - Execute the specified linux command eg. bash."
}

appStart () {
    echo "Starting rails application ..."

    su - rails <<"EOF"
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
foreman export supervisord /tmp -a app -u rails -l "/home/rails/shared/log" -f "/home/rails/rails-app/Procfile"
EOF

    mkdir -p /home/rails/shared/log
    chown rails:rails /home/rails/shared/log

    rm -rf /home/rails/rails-app/log
    ln -s /home/rails/shared/log /home/rails/rails-app/log

    ln -s /home/rails/shared/config/application.yml /home/rails/rails-app/config/application.yml

    cp /tmp/app.conf /etc/supervisor/conf.d/
    exec sudo /usr/bin/supervisord -c /etc/supervisor/supervisord.conf
}

case "$1" in
	app:start)
		appStart
		;;
	app:rake)
		shift 1
		appRake $@
		;;
	app:help)
		appHelp
		;;
    ssh:start)
        sshStart
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