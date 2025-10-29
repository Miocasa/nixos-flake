{ config, pkgs, ... }:

{
  networking.interfaces.enp1s0.ipv4.addresses = [ 
    # Format: "IP_ADDRESS/NETMASK_CIDR"
    { address = "192.168.0.40"; prefixLength = 24; } 
  ];

  networking.defaultGateway = "192.168.0.1";

  networking.nameservers = [ 
    "192.168.0.1" 
    "8.8.8.8" 
  ];
}