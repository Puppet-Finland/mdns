#
# == Class: mdns::packetfilter
#
# Manage mdns packet filtering rules
#
class mdns::packetfilter
(
    $allow_ipv4_address,
    $allow_ipv6_address
)
{

    Firewall {
        chain    => 'INPUT',
        action   => 'accept',
    }

    # IPv4 rules
    firewall { '016 ipv4 accept multicast':
        provider => 'iptables',
        pkttype  => 'multicast',
    }

    firewall { '016 ipv4 accept mdns port':
        provider => 'iptables',
        proto    => 'udp',
        port     => 5353,
        source   => $allow_ipv4_address,
    }

    # IPv6 rules
    firewall { '016 ipv6 accept multicast':
        provider => 'ip6tables',
        pkttype  => 'multicast',
    }

    firewall { '016 ipv6 accept mdns port':
        provider => 'ip6tables',
        proto    => 'udp',
        port     => 5353,
        source   => $allow_ipv6_address,
    }
}
