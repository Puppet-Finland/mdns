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

    # IPv4 rules
    firewall { '016 ipv4 accept multicast':
        provider => 'iptables',
        chain => 'INPUT',
        pkttype => 'multicast',
        action => 'accept',
    }

    firewall { '016 ipv4 accept mdns port':
        provider => 'iptables',
        chain => 'INPUT',
        proto => 'udp',
        port => 5353,
        source => "$allow_ipv4_address",
        action => 'accept',
    }

    # IPv6 rules
    firewall { '016 ipv6 accept multicast':
        provider => 'ip6tables',
        chain => 'INPUT',
        pkttype => 'multicast',
        action => 'accept',
    }

    firewall { '016 ipv6 accept mdns port':
        provider => 'ip6tables',
        chain => 'INPUT',
        proto => 'udp',
        port => 5353,
        source => "$allow_ipv6_address",
        action => 'accept',
    }
}
