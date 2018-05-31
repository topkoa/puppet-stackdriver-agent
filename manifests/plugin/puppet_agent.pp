# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker
#
# == Class: stackdriver::plugin::puppet_agent
#
# Enable Custom Exec Agent Plugin for Stackdriver Agent
#
# KEY -- Your EXEC SCRIPT should output something similar to this:
# Example:
#   PUTVAL "hostname-12345/check_puppet-get_last_run/gauge-last_run_seconds" interval=60 1527190805:761
#           -------------- ------------ ------------ ----- ----------------              ---------- ---
#           \Hostname      \Plugin      \PluginType  \Type \TypeInstance                 \timestamp \Value
#
# === Parameters
# ---
#
# [*config*]
# - Default - /opt/stackdriver/collectd/etc/collectd.d/puppet_agent.conf
# - Plugin configuration file
#
# [*plugin*]
# - Default - undef 
# - Plugin name, see KEY above for proper output from EXEC script mapping. 
#
# [*plugin_instance*]
# - Default - undef 
# - Plugin Instance name, see KEY above for proper output from EXEC script mapping. 
#
# [*type*]
# - Default - guage 
# - Types.  gauge, delta, or cumulative 
# - https://cloud.google.com/monitoring/api/v3/metrics-details#metric-kinds
#
# [*type_instance*]
# - Default - undef 
# - Type Instance name, see KEY above for proper output from EXEC script mapping. 
#
# [*sd_metric_type*]
# - Default - undef 
# - What custom metric should get this data? Ex: custom.googleapis.com/puppet/last_run_total_events_success  
#
# === Usage
# ---
#
# ==== Puppet Code
#
#  Enable Puppet Agent plugin via Puppet CODE:
#
#  include '::stackdriver::plugin::puppet_agent'
#
# ==== Hiera
#
#  Enable Exec Custom plugin via Hiera:
#
#  stackdriver::plugins:
#   - 'puppet_agent'
#
class stackdriver::plugin::puppet_agent(

  $config           = '/opt/stackdriver/collectd/etc/collectd.d/puppet_agent.conf',
  $plugin           = 'check_puppet', 
  $plugin_instance  = 'get_last_run', 
  $type             = 'gauge',
  $type_instance    = undef, 
  $sd_metric_type   = undef, 
  $custom_rules     = [{},],

) {

  Class['stackdriver'] -> Class[$name]

  validate_array  ( $custom_rules )

  contain "${name}::config"

  # Install package
  #ensure_resource('package', 'yajl', {
  #  'ensure'  => 'present',
  #})

}

