# Definition: network::if::static
#
# Creates a normal interface with static IP address.
#
# Parameters:
#   $ensure         - required - up|down
#   $ipaddress      - required
#   $netmask        - required
#   $gateway        - optional
#   $hwaddr_enable  - optional
#   $macaddress     - optional - defaults to macaddress_$title
#   $mtu            - optional
#   $ethtool_opts   - optional
#   $peerdns        - optional
#   $dns1           - optional
#   $dns2           - optional
#   $domain         - optional
#
# Actions:
#
# Requires:
#
# Sample Usage:
#  # normal interface - static (minimal)
#  network::if::static { 'eth0':
#    ensure     => 'up',
#    ipaddress  => '10.21.30.248',
#    netmask    => '255.255.255.128',
#    macaddress => $::macaddress_eth0,
#    domain     => 'is.domain.com domain.com',
#  }
#
define network::if::static (
  $ensure,
  $bootproto = 'static',
  $ipaddress,
  $netmask,
  $gateway = '',
  $hwaddr_enable = true,
  $macaddress = '',
  $mtu = '',
  $ethtool_opts = '',
  $peerdns = false,
  $dns1 = '',
  $dns2 = '',
  $domain = '',
) {

  # Validate our data
  if ! is_ip_address($ipaddress) {
    fail("${ipaddress} is not an IP address.")
  }

  if ! is_mac_address($macaddress) {
    $macaddy = getvar("::macaddress_${title}")
  } else {
    $macaddy = $macaddress
  }

  network::if::base { $title:
    ensure          => $ensure,
    ipaddress       => $ipaddress,
    netmask         => $netmask,
    gateway         => $gateway,
    hwaddr_enable   => $hwaddr_enable,
    macaddress      => $macaddy,
    bootproto       => $bootproto,
    mtu             => $mtu,
    ethtool_opts    => $ethtool_opts,
    bonding_opts    => '',
    peerdns         => $peerdns,
    dns1            => $dns1,
    dns2            => $dns2,
    domain          => $domain,
  }
}
