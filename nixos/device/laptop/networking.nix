{ config, pkgs, ... }:

{
  networking.interfaces.w.ipv4.addresses = [ 
    # Format: "IP_ADDRESS/NETMASK_CIDR"
    { address = "192.168.0.40"; prefixLength = 24; } 
  ];

  networking.defaultGateway = "192.168.0.1";

  networking.nameservers = [ 
    "192.168.0.1" 
    "8.8.8.8" 
  ];
  # networking = {
  # useDHCP = false; # отключаем DHCP для всех интерфейсов
  # wireless.enable = true;

  # interfaces.wlan0 = {
  #   ipv4.addresses = [
  #     {
  #       address = "192.168.0.40";
  #       prefixLength = 24;
  #     }
  #   ];
  # };

  # defaultGateway = "192.168.0.1";
  # nameservers = [ "192.168.0.1" "8.8.8.8" ];
  # }
}