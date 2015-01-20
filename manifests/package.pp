# == Class: fluentd::package
#
# This class exists to coordinate all software package management related
# actions, functionality and logical units in a central place.
#
#
# === Parameters
#
# This class does not provide any parameters.
#
#
# === Examples
#
# This class may be imported by other classes to use its functionality:
#   class { 'fluentd::package': }
#
# It is not intended to be used directly by external resources like node
# definitions or other modules.
#
class fluentd::package {
  
  anchor { 'fluentd::package::begin': }
  anchor { 'fluentd::package::end': }

  case $::osfamily {
    'redhat': {
      class{'fluentd::package::redhat':
        ensure       => $fluentd::ensure,
        manage_repo  => $fluentd::manage_repo,
        package_name => $fluentd::package_name,
        require      => Anchor['fluentd::package::begin'],
        before       => Anchor['fluentd::package::end'],
      }
    }
    default: {
      package { $fluentd::package_name:
        ensure => $fluentd::ensure,
      }
    }
  }
  
}
