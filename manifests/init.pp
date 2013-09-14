#
# == Class: mdns
#
# Manage things related to multicast DNS such as firewall rules.
#
# == Parameters
#
# [*allow_ipv4_address*]
#   IPv4 address from which to allow packets to UDP port 5353. Packets of 
#   multicast type are always allowed. Default value is '127.0.0.1'.
# [*allow_ipv6_address*]
#   The same as above but for IPv6. Default value is '::1'.
#
# == Examples
#
# class { 'mdns':
#   allow_ipv4_address => '192.168.0.0/24',
# } 
#
# == Authors
#
# Samuli Seppänen <samuli.seppanen@gmail.com>
#
# == License
#
# BSD-license
# See file LICENSE for details
#
class mdns
(
    $allow_ipv4_address = '127.0.0.1',
    $allow_ipv6_address = '::1'
)
{

# Rationale for this is explained in init.pp of the sshd module
if hiera('manage_mdns', 'true') != 'false' {

    class { 'mdns::packetfilter':
        allow_ipv4_address => $allow_ipv4_address,
        allow_ipv6_address => $allow_ipv6_address,
    }
}
}
