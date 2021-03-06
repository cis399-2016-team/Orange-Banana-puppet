class sshd {
	package {
		"openssh-server": ensure => installed;
	}

	case $operatingsystem {
		'Ubuntu': {
			$key_user = "ubuntu"
			$service_name = "ssh"
		}
		'Amazon': {
			$key_user = "ec2-user"
			$service_name = "sshd"
		}
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

	service { $service_name:
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
		user => $key_user,
		type => "ssh-rsa",
		key  => "AAAAB3NzaC1yc2EAAAADAQABAAABAQCx/EgedQlVAGuFLUNtrJfGYIB4ieO1YcrD3ssoOtVA97YgaLE5VA6J0aazUevfNzsbGhrocGM3QZnStrZdAAhd3fyx+SrPXxVldxwpX70jNJg0KoOUEL7hYpSI8bAqzXSkJhCrxrfZMfhrSPQcS4SyBn3DOTc9xce7D93QW7uO0feluY9BzXiScBgOdCHqlTvZroV4Me1pXZ6mPRWnOqwUMwBTFhcNDKbhsftSYmMtjWuucqjpWTHrRMxO4OGfJk/+IQjPgOxwMG8fZnhZ//OE7YL0thDN0hJ6Ko9I5azztepyOleU5lNgTAqGqRrayhspAby0/VM6/UKy7n+1sjdh",
	}

	ssh_authorized_key { "jstuemke-key-pair-oregon":
		user => $key_user,
		type => "ssh-rsa",
		key  => "AAAAB3NzaC1yc2EAAAADAQABAAABAQCPnelozzko4JcJxfgbm0Ib7h8C0dDpV5NvuKKuzVabFRSlc8MTXUz2aLAaiZzqMQQFdnxOLz0xJrQIpQIGRFiTvBfP1g5fCcHTRcjumv8e5qL+ARGbYgoCz+CMTsF71ZT4Y5U0nJaBuzgKiCNtXjG2Hma/pMT7dEWeUZiOymHihVzUkMa8kAiLkzRJB94ZCv8QeYyO7+cJsjbce4FwBQg+r9+Rwoj11eVj4fOvA1eOhp2d+S31E4GaaEfYrM3lRKQZQLLdygKxiHA3geHMJAJLQaiF3scfm/5NofTS6OxRsoC3q54Q6JXH104okrPYBt/EMRMEY3bO8FI364+LDU4J",
	}

}
