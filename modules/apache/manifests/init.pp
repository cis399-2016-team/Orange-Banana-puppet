class apache {
	case $operatingsystem {
		"Ubuntu":{
			$apacheconf = "/etc/apache2/apache2.conf"
			$package = "apache2"
		}
		"Amazon":{
			$apacheconf = "/etc/httpd/httpd.conf"
			$package = "httpd"
		}
	}

	package { 
		$package: ensure => installed; 
	}

	file { "$apacheconf":
		source  => [
			# from modules/apache/files/apache2.conf
			"puppet:///modules/apache/apache2.conf",
		],
		mode    => 444,
		owner   => root,
		group   => root,
		# package must be installed before configuration file
		require => Package[$package],
	}

	file { "/var/www/html/index.html":
		source => [
			# from modules/apache/files/index.html
			"puppet:///modules/apache/index.html",
		],
		recurse => true,
		ensure => "/var/www/html",
		mode    => 444,
		owner   => root,
		group   => root,

	}

	service { "$package":
		# automatically start at boot time
		enable     => true,
		# restart service if it is not running
		ensure     => running,
		# "service apache2 status" returns useful service status info
		hasstatus  => true,
		# "service apache2 restart" can restart service
		hasrestart => true,
		# package and configuration must be present for service
		require    => [ Package[$package],
			   File[$apacheconf] ],
		#changes to configuration cause service restart
		subscribe  => File[$apacheconf],
	}
}
