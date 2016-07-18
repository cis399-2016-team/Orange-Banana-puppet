class apache {
	package {
		"apache2": ensure => installed;
	}

	file { "/etc/apache2/apache2.conf":
		source  => [
			# from modules/apache2/files/apache2.conf
			"puppet:///modules/apache2/apache2.conf",
		],
		mode    => 444,
		owner   => root,
		group   => root,
		# package must be installed before configuration file
		require => Package["apache2"],
	}

	service { "apache2":
		# automatically start at boot time
		enable     => true,
		# restart service if it is not running
		ensure     => running,
		# "service apache2 status" returns useful service status info
		hasstatus  => true,
		# "service apache2 restart" can restart service
		hasrestart => true,
		# package and configuration must be present for service
		require    => [ Package["apache2"],
			   File["/etc/apache2/apache2.conf"] ],
		#changes to configuration cause service restart
		subscribe  => File["/etc/apache2/apache2.conf"],
	}
}
