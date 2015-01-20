# == definition fluentd::configfile
define fluentd::configfile (
  $content,
  $ensure   = present,
  $priority = 50,
) {
  $base_name     = "${name}.conf"
  $conf_name     = "${priority}-${base_name}"
  $conf_path     = "${fluentd::config_dir}/config.d/${conf_name}"
  $wildcard_path = "${fluentd::config_dir}/config.d/*-${base_name}"

  if $ensure == 'absent' {
    file { $conf_path:
      ensure => $ensure,
      notify => Class['fluentd::service'],
    }
  } else {
    file { $conf_path:
      ensure  => $ensure,
      content => $content,
      owner   => $fluentd::daemon_user,
      group   => $fluentd::daemon_group,
      mode    => '0644',
      require => Class['fluentd::package'],
      notify  => Class['fluentd::service'],
    }
  }
}
