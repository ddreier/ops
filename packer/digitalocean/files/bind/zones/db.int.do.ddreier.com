;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     dns.int.do.ddreier.com. admin.int.do.ddreier.com. (
                              3         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
; Name Servers - NS Records
        IN      NS      ns.int.do.ddreier.com.
; Name Servers - A Records
ns     IN      A       10.132.1.1