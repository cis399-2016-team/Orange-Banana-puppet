node ip-10-0-6-11 {
	cron { "puppet update":
		command => "cd /etc/puppet && git pull -q origin master",
		user    => root,
		minute  => "*/5",
	}
	include sshd
}

node ip-10-0-6-245 {
	include sshd
	include apache
	include useraccounts
}

node ip-10-0-6-192 {
	include sshd
	include apache
}
