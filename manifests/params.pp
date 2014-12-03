# this class should be considered private
class hyperctl::params {
  $state = 'enable'

  case $::osfamily {
    'redhat': {
      case $::operatingsystemmajrelease {
        6: {
          $init_path = '/etc/init.d/hyperctl'
          $init_erb  = "${module_name}/init/hyperctl.el6.erb"
          $conf_path = '/etc/sysconfig/hyperctl'
          $conf_erb  = "${module_name}/conf/hyperctl.el6.erb"
        }
        default: {
          $platform = "${::operatingsystem} ${::operatingsystemmajrelease}"
          fail("Module ${module_name} is not supported on ${platform}")
        }
      }
    }
    default: {
      fail("Module ${module_name} is not supported on ${::operatingsystem}")
    }
  }
}
