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

	service { "ssh":
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
		user => "ubuntu",
		key  => "AAAAB3NzaC1yc2EAAAADAQABAAABAQCx/EgedQlVAGuFLUNtrJfGYIB4ieO1YcrD3ssoOtVA97YgaLE5VA6J0aazUevfNzsbGhrocGM3QZnStrZdAAhd3fyx+SrPXxVldxwpX70jNJg0KoOUEL7hYpSI8bAqzXSkJhCrxrfZMfhrSPQcS4SyBn3DOTc9xce7D93QW7uO0feluY9BzXiScBgOdCHqlTvZroV4Me1pXZ6mPRWnOqwUMwBTFhcNDKbhsftSYmMtjWuucqjpWTHrRMxO4OGfJk/+IQjPgOxwMG8fZnhZ//OE7YL0thDN0hJ6Ko9I5azztepyOleU5lNgTAqGqRrayhspAby0/VM6/UKy7n+1sjdh",
	}

}
