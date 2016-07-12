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
		key  => "MIIEpQIBAAKCAQEAsfxIHnUJVQBrhS1DbayXxmCAeInjtWHKw97LKDrVQPe2IGixOVQOidGms1Hr3zc7Gxoa6HBjN0GZ0ra2XQAIXd38sfkqz18VZXccKV+9IzSYNCqDlBC+4WKUiPGwKs10pCYQq8a32TH4a0j0HEuEsgZ9wzk3PcXHuw/d0Fu7jtH3pbmPQc14knAYDnQh6pU72a6FeDHtaV2epj0VpzqsFDMAUxYXDQym4bH7UmJjLY1rrnKo6Vkx60TMTuDhnyZP/iEIz4DscDBvH2Z4Wf/zhO2C9LYQzdISeiqPSOWs87XqcjpXlOZTYEwKhqka2sobKQG8tP1TOv1Csu5/tbI3YQIDAQABAoIBAExkjQvNjgjW2k9aAyPyvV4fE2UpQfwbEi2J1cbZoah16cz1QoPpqSfMPXGgCs5O5WaXiM8VVfBkjsJbO+Ck3/JyEkDNQmupUwSu3/5+Ii8XJvDVAo6ttVAFwN0aZ1OnxZWi5OrlqwllIkviDyyJ2VWT5azCRQyVdEm84KbKiLEegpeAf4o7Jc1sQh/gkux4DC5UQw1PRu9GImHrPVdnZPFjMqWXYu4db8lwsRA1EZ+FMff4dvYPBtD8J0qrhaOWzSidUWUAKBHl0aOREp1c0yItYnGxfIpLApf/9M9J5rWZSPb1Yyb7O3PxcrjWauPQpfemBFkkAIaxHmYJ2foy/kUCgYEA97yY3kkSOEyeKqrmDqE4qhCv+73reqi+nmFNTXMzjXvSShMZiccXKWPJ23edpXqceblNe2m8TrvbO6YOyX+z43IOnrx4GQjFnr7KyXm9owYeCTy/0qCjRDA7DTS1O1aZz+eXaJ0l+SJMd7MlBQ5ZPiIcBG05gMbWLXD/m8TS2h8CgYEAt+wVrcVCavEZVATRK1AIaENl0ipzQk2crvYLTQaB40uqLvLIdmXosfgJbeMH7PRqODvDtRj5AheDe2Rmz0crI4R8jJ5bBlUPymv++0+M37LMoVyNhDEjAMDciyQi/h5OfYoKrIcUEWfmYElDMrEiGMo/uA0m2jE6SQEF6BArvn8CgYEA06beV7LIDS9wRfXCHSeiWLFvGL2WjDHUwU1SFORiW/M4oy6UOADPCf6GO6mDFxiczOYCi3i3d/DJCboCkiY3Uw9j7DwKwyCabdiFOgJ3gOs+CBhNri6trhkiqlKor2x6doRe9/KiuamS+QUlkJ9EoW/UzfdfFGVMIICU8MkEd3MCgYEAowad1LDUBYz+IW4/pf/D4/9Rwq+kCLJY3vDy5WyON1Y7XHARZnlAgHfWi9PAk7W2bW/0MpMXLVaAUiCVzMdNoqbt64r2Li+51nhRxJsnyKVpIuKyAem4GBPbqW33on5knnx8p574F9Gb798gtE80ZPro7hCiTqdx/YHtpVyoGasCgYEAybIBsGI/FWKHqaDxVtwcWKXLZrI1Wh0GAwiBJH0ESZUh7UL0d6BCDn03Q+oLEvq2r9+M43SQXM8Zu6okE73CJbpUoXoYscE5V0vl84lkHIwEulvc021nmdmI7yGUdlT02hFyL/nzzo79EXwjO+ZIkorq8z/5tbhOwfFW2GshA60=",
	}

}
