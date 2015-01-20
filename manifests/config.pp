# Class: fluentd::config()
#
#
class fluentd::config ( $config_vers = $fluentd::config_vers ) {
    file { 'fluentd_config_name':
        ensure  => 'file',
        path    => $fluentd::config_name,
        owner   => $fluentd::daemon_user,
        group   => $fluentd::daemon_group,
        mode    => '0640',
        content => template('fluentd/fluentd.conf.erb'),
        notify  => Class['fluentd::service'],
    }

    file { 'fluentd_config_dir':
        ensure  => 'directory',
        path    => $fluentd::config_dir,
        owner   => $fluentd::daemon_user,
        group   => $fluentd::daemon_group,
        mode    => '0750',
        recurse => $fluentd::purge_config,
        purge   => $fluentd::purge_config,
        ignore  => $fluentd::purge_ignore,
    }
}
