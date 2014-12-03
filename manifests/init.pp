# == Class: hyperctl
#
class hyperctl(
  $state = $::hyperctl::state,
) inherits hyperctl::params {
  validate_re($state, '^enable$|^disable$')

  $prog = 'hyperctl'

  file { 'hyperctl-init':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template($::hyperctl::params::init_erb),
    path    => $::hyperctl::params::init_path,
    notify  => Service['hyperctl'],
  }

  $conf_options = {
    'HYPERCTL_SET' => $state,
  }

  file { 'hyperctl-conf':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template($::hyperctl::params::conf_erb),
    path    => $::hyperctl::params::conf_path,
    notify  => Service['hyperctl'],
  }

  service { 'hyperctl':
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
  }
}
