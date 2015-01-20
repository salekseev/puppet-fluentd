# Class: fluentd::package::redhat
#
# This module manages fluentd package installation on RedHat based systems
#
# Parameters:
#
# There are no default parameters for this class.
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# This class file is not called directly
class fluentd::package::redhat (
  $manage_repo    = true,
  $package_ensure = 'present',
  $package_name   = 'td-agent',
  $key            = $fluentd::params::yum_key_url,
) {

  if $manage_repo {
    yumrepo { 'treasuredata':
      descr    => 'Treasure Data',
      baseurl  => 'http://packages.treasuredata.com/redhat/$basearch',
      gpgkey   => $key,
      gpgcheck => 1,
      before   => Package[$package_name],
    }
  }

  package { 'fluentd':
    ensure => $ensure,
    name   => $package_name,
  }

}
