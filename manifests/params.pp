# == Class: fluentd::params
#
# This class exists to
# 1. Declutter the default value assignment for class parameters.
# 2. Manage internally used module variables in a central place.
#
# Therefore, many operating system dependent differences (names, paths, ...)
# are addressed in here.
#
#
# === Parameters
#
# This class does not provide any parameters.
#
#
# === Examples
#
# This class is not intended to be used directly.
#
#
# === Links
#
# * {Puppet Docs: Using Parameterized Classes}[http://j.mp/nVpyWY]
#
class fluentd::params {

  #### Default values for the parameters of the main module class, init.pp

  # ensure
  $ensure = 'present'

  # service status
  $status = 'running'

  # User and Group for the files and user to run the service as.
  $daemon_user  = 'td-agent'
  $daemon_group = 'td-agent'
  
  # config
  $config_vers  = '1',
  $config_dir   = '/etc/td-agent'
  $config_name  = "${config_dir}/td-agent.conf"
  $purge_config = true
  $purge_ignore = undef
  
  # repo management
  $manage_repo = true
  $yum_key_url = 'http://packages.treasure-data.com/redhat/RPM-GPG-KEY-td-agent'

  #### Internal module values

  # packages
  case $::osfamily {
    'redhat': {
      $package_name = 'td-agent'
    }
    default: {
      $package_name = 'td-agent'
    }
  }

  # service parameters
  case $::osfamily {
    'redhat': {
      $service_name       = 'td-agent'
      $service_hasrestart = true
      $service_hasstatus  = true
      $service_pattern    = $service_name
    }
    default: {
      $service_name       = 'td-agent'
      $service_hasrestart = true
      $service_hasstatus  = true
      $service_pattern    = $service_name
    }
  }

}