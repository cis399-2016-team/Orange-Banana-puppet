class sshd {
	package {
		"openssh-server": ensure => installed;
	}
	
	file { "/etc/ssh/sshd_config":
		source  => [
			# from modules/sshd/files/sshd_config
			"puppet:///modules/sshd/sshd_config",
		],
		mode    => 444,
		owner   => root,
		group   => root,
		# package must be installed before configuration file
		require => Package["openssh-server"],
	}

	service { "sshd":
		# automatically start at boot time
		enable     => true,
		# restart service if it is not running
		ensure     => running,
		# "service sshd status" returns useful service status info
		hasstatus  => true,
		# "service sshd restart" can restart service
		hasrestart => true,
		# package and configuration must be present for service
		require    => [ Package["openssh-server"],
			   File["/etc/ssh/sshd_config"] ],
		#changes to configuration cause service restart
		subscribe  => File["/etc/ssh/sshd_config"],
	}
	
	ssh_authorized_key { "CIS399":
		user => "ubuntu" 
	}
}
