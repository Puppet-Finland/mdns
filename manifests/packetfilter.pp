#
# == Class: mdns::packetfilter
#
# Manage mdns packet filtering rules
#
class mdns::packetfilter
(
    String $allow_ipv4_address,
    String $allow_ipv6_address
)
{

    Firewall {
        chain    => 'INPUT',
        action   => 'accept',
        provider => 'iptables',
        port     => 5353,
    }

    # IPv4 rules
    firewall { '016 ipv4 accept multicast':
        pkttype => 'multicast',
        port    => undef,
    }

    firewall { '016 ipv4 accept mdns udp port':
        proto  => 'udp',
        source => $allow_ipv4_address,
    }

    firewall { '016 ipv4 accept mdns tcp port':
        proto  => 'tcp',
        source => $allow_ipv4_address,
    }

    # IPv6 rules
    firewall { '016 ipv6 accept multicast':
        provider => 'ip6tables',
        pkttype  => 'multicast',
        port     => undef,
    }

    firewall { '016 ipv6 accept mdns udp port':
        provider => 'ip6tables',
        proto    => 'udp',
        source   => $allow_ipv6_address,
    }

    firewall { '016 ipv6 accept mdns tcp port':
        provider => 'ip6tables',
        proto    => 'tcp',
        source   => $allow_ipv6_address,
    }
}
