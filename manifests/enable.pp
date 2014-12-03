# == Class: hyperctl::enable
#
class hyperctl::enable {
  class { '::hyperctl':
    state => 'enable',
  }
}
