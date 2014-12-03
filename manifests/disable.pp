# == Class: hyperctl::disable
#
class hyperctl::disable {
  class { '::hyperctl':
    state => 'disable',
  }
}
