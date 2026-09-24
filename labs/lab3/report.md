# Inledning
Detta är den första laborationsuppgiften för kursen Data Communication and Networks (DA541A HT26).

# Uppgift 1 - Find your IP address, MAC address and DNS server address

## Fråga 1
> What are the IP address and MAC address for the active Internet connection on your computer?
```bash
$ ifconfig -a
enp3s0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.0.137  netmask 255.255.255.0  broadcast 192.168.0.255
        inet6 fe80::1d71:b5cc:c9f3:b1cd  prefixlen 64  scopeid 0x20<link>
        ether 8c:89:a5:0b:57:f7  txqueuelen 1000  (Ethernet)
        RX packets 1459047  bytes 1931682277 (1.9 GB)
        RX errors 0  dropped 4093  overruns 0  frame 0
        TX packets 462847  bytes 104787548 (104.7 MB)
        TX errors 0  dropped 3 overruns 0  carrier 0  collisions 0
        device interrupt 19  

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 29420  bytes 2958053 (2.9 MB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 29420  bytes 2958053 (2.9 MB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

wlp5s0: flags=4098<BROADCAST,MULTICAST>  mtu 1500
        ether 6c:71:d9:77:2c:45  txqueuelen 1000  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
```
Kör kommando för att hitta ethernet adapterns ipv4 och ipv6 adresser.
```bash
$ ifconfig enp3s0 | awk '/inet/ {print $1, $2}'
inet 192.168.0.137
inet6 fe80::1d71:b5cc:c9f3:b1cd
```
Och likadant för dess MAC adress.
```bash
$ ifconfig enp3s0 | awk '/ether/ {print $1, $2}'
ether 8c:89:a5:0b:57:f7
```
\newpage
## Fråga 2.1
> What is the configured DNS server IP address? 

Använder verktyget _resolvectl_.
```bash
$ resolvectl status enp3s0 | sed -n '4p'
Current DNS Server: 192.168.0.1
```
Detta pekar på min router.
Kollar in vilken DNS serveradress som min router pekar på.
![DNS server router settings](./resources/img/img0.png.png){width=50%}

Kör en _whois_ på adressen.
```bash
$ (whois 83.233.79.36; whois 83.233.79.37) | awk '/netname/ {print}'
netname:        BREDBAND2-NET-SE
netname:        BREDBAND2-NET-SE
```
"_BREDBAND2_" är min ISP (Internet Service Provider).

## Fråga 2.2
> What is this DNS server used for?

DNS (Domain Name System) översätter läsbara domännamn (ex: '_https://www.google.com_') till ip adresser (216.58.201.206) som används för att kontakta servern.

\newpage

# Uppgift 2 - Find mapping between domain name and IP address
## Fråga 3.1
> What is the DNS server IP address used for this name resolution?
```bash
$ nslookup www.mit.edu | awk '/Server/ {print}'
Server:		127.0.0.53
```
Detta är min ubuntu maskins lokala DNS server.

## Fråga 3.2
> What are the IP addresses for the host '_www.MIT.edu_'?
```bash
$ nslookup www.mit.edu | sed -n '4,$p'
Non-authoritative answer:
www.mit.edu	canonical name = www.mit.edu.edgekey.net.
www.mit.edu.edgekey.net	canonical name = e9566.dscb.akamaiedge.net.
Name:	e9566.dscb.akamaiedge.net
Address: 88.221.97.35
Name:	e9566.dscb.akamaiedge.net
Address: 2a02:26f0:9500:1398::255e
Name:	e9566.dscb.akamaiedge.net
Address: 2a02:26f0:9500:1399::255e
```
- IPv4 Adress: 88.221.97.35

- IPv6 Adress: 2a02:26f0:9500:1398::255e

- IPv6 Adress: 2a02:26f0:9500:1399::255e


## Fråga 3.3
> Is '_www.mit.edu_' an alias? 

Ja.
```bash
$ nslookup www.mit.edu | awk '/canonical/ {print}' | sed -n '1p'
www.mit.edu	canonical name = www.mit.edu.edgekey.net.
```
Och även '_www.mit.edu.edgekey.net_' är ett alias, eftersom...
```bash
$ nslookup www.mit.edu | awk '/canonical/ {print}' | sed -n '2p'
www.mit.edu.edgekey.net	canonical name = e9566.dscb.akamaiedge.net.
```

\newpage

## Fråga 4.1 
> What are the DNS servers responsible for domain names in mit.edu?
```bash
$ nslookup -type=NS mit.edu | sed -n '5,13p' | sort
mit.edu	nameserver = asia1.akam.net.
mit.edu	nameserver = asia2.akam.net.
mit.edu	nameserver = eur5.akam.net.
mit.edu	nameserver = ns1-173.akam.net.
mit.edu	nameserver = ns1-37.akam.net.
mit.edu	nameserver = use2.akam.net.
mit.edu	nameserver = use5.akam.net.
mit.edu	nameserver = usw2.akam.net.
```

## Fråga 4.2
> Find out these DNS server IP addresses (by using nslookup respectively on the name servers found in A).
```bash
$ nslookup asia1.akam.net | sed -n '4,$p' | awk '/Address:/ {print}'
Address: 95.100.175.64

$ nslookup asia2.akam.net | sed -n '4,$p' | awk '/Address:/ {print}'
Address: 95.101.36.64

$ nslookup eur5.akam.net | sed -n '4,$p' | awk '/Address:/ {print}'
Address: 23.74.25.64

$ nslookup ns1-173.akam.net | sed -n '4,$p' | awk '/Address:/ {print}'
Address: 193.108.91.173
Address: 2600:1401:2::ad

$ nslookup ns1-37.akam.net | sed -n '4,$p' | awk '/Address:/ {print}'
Address: 193.108.91.37
Address: 2600:1401:2::25

$ nslookup use2.akam.net | sed -n '4,$p' | awk '/Address:/ {print}'
Address: 96.7.49.64

$ nslookup use5.akam.net | sed -n '4,$p' | awk '/Address:/ {print}'
Address: 2.16.40.64
Address: 2600:1403:a::40

$ nslookup usw2.akam.net | sed -n '4,$p' | awk '/Address:/ {print}'
Address: 184.26.161.64
```

## Fråga 5.1
> Which DNS server is used for this name resolution?

DNS servern som används har adress '_8.8.8.8_'.
```bash
$ nslookup www.hkr.se 8.8.8.8
Server:		8.8.8.8
Address:	8.8.8.8#53

Non-authoritative answer:
Name:	www.hkr.se
Address: 194.47.45.20
```
Servern administreras av Google.
```bash
$ whois 8.8.8.8 | awk '/OrgName/ {print}'
OrgName:        Google LLC
```
## Fråga 5.2
> Do you find the IPv6 address for '_https://www.hkr.se/_'?

Finns ingen publicerad IPv6 adress för '_https://www.hkr.se/_' så vidt jag kan se.

## Fråga 6 
> In most case, the domain names  are simple to remember and short. Does the long name for 220.135.143.45 cause any inconvenient for its users? Why or why not?
```bash
$ nslookup 220.135.143.45
45.143.135.220.in-addr.arpa	name = 220-135-143-45.hinet-ip.hinet.net.

Authoritative answers can be found from:
```
Att ange adresser i dess numeriska format är besvärligt då människor behöver semantisk mening för att underlätta för minnet att återkalla adressen.

\newpage

## Fråga 7
> where is the mail to '_sandra.roos@hkr.se_' sent?
```
$ nslookup -type=mx hkr.se
Server:		127.0.0.53
Address:	127.0.0.53#53

Non-authoritative answer:
hkr.se	mail exchanger = 10 hkr-se.mail.protection.outlook.com.

Authoritative answers can be found from:
```
Mail till '_sandra.roos@hkr.se_' skickas till '_hkr-se.mail.protection.outlook.com_'.

## Fråga 8.1
> What IP addresses do you find for the web server https://www.google.com/
```bash
$ nslookup www.google.com
Server:		127.0.0.53
Address:	127.0.0.53#53

Non-authoritative answer:
Name:	www.google.com
Address: 142.251.155.119
Name:	www.google.com
Address: 142.251.150.119
Name:	www.google.com
Address: 142.251.153.119
Name:	www.google.com
Address: 142.251.151.119
Name:	www.google.com
Address: 142.251.157.119
Name:	www.google.com
Address: 142.251.154.119
Name:	www.google.com
Address: 142.251.152.119
Name:	www.google.com
Address: 142.251.156.119
Name:	www.google.com
Address: 2001:4860:4829:7700::
Name:	www.google.com
Address: 2001:4860:4828:7700::
Name:	www.google.com
Address: 2001:4860:482c:7700::
Name:	www.google.com
Address: 2001:4860:482d:7700::
Name:	www.google.com
Address: 2001:4860:4827:7700::
Name:	www.google.com
Address: 2001:4860:482b:7700::
Name:	www.google.com
Address: 2001:4860:482a:7700::
Name:	www.google.com
Address: 2001:4860:4826:7700::

$ nslookup www.google.com 8.8.8.8
Server:		8.8.8.8
Address:	8.8.8.8#53

Non-authoritative answer:
Name:	www.google.com
Address: 142.251.154.119
Name:	www.google.com
Address: 142.251.157.119
Name:	www.google.com
Address: 142.251.152.119
Name:	www.google.com
Address: 142.251.150.119
Name:	www.google.com
Address: 142.251.155.119
Name:	www.google.com
Address: 142.251.156.119
Name:	www.google.com
Address: 142.251.151.119
Name:	www.google.com
Address: 142.251.153.119
Name:	www.google.com
Address: 2001:4860:4829:7700::
Name:	www.google.com
Address: 2001:4860:4827:7700::
Name:	www.google.com
Address: 2001:4860:482d:7700::
Name:	www.google.com
Address: 2001:4860:482a:7700::
Name:	www.google.com
Address: 2001:4860:482b:7700::
Name:	www.google.com
Address: 2001:4860:4826:7700::
Name:	www.google.com
Address: 2001:4860:4828:7700::
Name:	www.google.com
Address: 2001:4860:482c:7700::

$ nslookup www.google.com 208.67.222.222
Server:		208.67.222.222
Address:	208.67.222.222#53

Non-authoritative answer:
Name:	www.google.com
Address: 142.251.153.119
Name:	www.google.com
Address: 142.251.154.119
Name:	www.google.com
Address: 142.251.155.119
Name:	www.google.com
Address: 142.251.156.119
Name:	www.google.com
Address: 142.251.157.119
Name:	www.google.com
Address: 142.251.150.119
Name:	www.google.com
Address: 142.251.151.119
Name:	www.google.com
Address: 142.251.152.119
Name:	www.google.com
Address: 2001:4860:4829:7700::
Name:	www.google.com
Address: 2001:4860:482a:7700::
Name:	www.google.com
Address: 2001:4860:482b:7700::
Name:	www.google.com
Address: 2001:4860:482c:7700::
Name:	www.google.com
Address: 2001:4860:482d:7700::
Name:	www.google.com
Address: 2001:4860:4826:7700::
Name:	www.google.com
Address: 2001:4860:4827:7700::
Name:	www.google.com
Address: 2001:4860:4828:7700::
```

## Fråga 8.2
> Explain your understanding on the load balancing technique based on DNS service.

Termen 'load balancing' beskriver en process där beläggningstrycket fördelas mellan flera processerare, i detta fall: flera DNS servrar.
Utfifrån resultatet av kommandot i fråga 8.1 så ser jag totalt sexton stycken ip-adresser, där hälften är IPv4 adresser och hälften IPv6 adresser.

 Dessa adresser kommer i olika ordning för varje gång man kör '_nslookup_'.
```bash
$ diff <(nslookup www.google.com) <(nslookup www.google.com)
9a10,13
> Address: 142.251.151.119
> Name:	www.google.com
> Address: 142.251.154.119
> Name:	www.google.com
14c18
< Address: 142.251.151.119
---
> Address: 142.251.155.119
18,20c22
< Address: 142.251.155.119
< Name:	www.google.com
< Address: 142.251.154.119
---
> Address: 2001:4860:4828:7700::
22c24
< Address: 2001:4860:4829:7700::
---
> Address: 2001:4860:482a:7700::
26c28
< Address: 2001:4860:482a:7700::
---
> Address: 2001:4860:4826:7700::
28c30
< Address: 2001:4860:482b:7700::
---
> Address: 2001:4860:4827:7700::
30c32
< Address: 2001:4860:4826:7700::
---
> Address: 2001:4860:4829:7700::
35,36d36
< Name:	www.google.com
< Address: 2001:4860:4827:7700::
```
Bortsett från ordningen så är listorna av adresser likadana.
```bash
$ diff <(nslookup www.google.com | sort) <(nslookup www.google.com 8.8.8.8 | sort)

# Ingen skillnad på listan av adresser till googles servrar.
3d2
< Address:	127.0.0.53#53
19a19
> Address:	8.8.8.8#53
37c37
< Server:		127.0.0.53
---
> Server:		8.8.8.8
```
```bash
diff <(nslookup www.google.com | sort) <(nslookup www.google.com 208.67.222.222 | sort)

# Ingen skillnad på listan av adresser till googles servrar.
3d2
< Address:	127.0.0.53#53
19a19
> Address:	208.67.222.222#53
37c37
< Server:		127.0.0.53
---
> Server:		208.67.222.222
```
```bash
diff <(nslookup www.google.com 8.8.8.8 | sort) <(nslookup www.google.com 208.67.222.222 | sort)

# Ingen skillnad på listan av adresser till googles servrar.
19c19
< Address:	8.8.8.8#53
---
> Address:	208.67.222.222#53
37c37
< Server:		8.8.8.8
---
> Server:		208.67.222.222
```

Eftersom det enda som skiljer är ordningen på listan av servrar så gör jag antagandet att servern högst upp på listan är den minst belaggda/avlägsna. 
Detta leder mig till ett ytterligare antagande att det är den högst belägna servern som svarar på anrop från klienter och slutligen att detta är effekten som utgör beläggningsfördelningen (load balanncing).
\newpage

# Uppgift 3 - Handle the DNS cache
Börjar med att läsa manpage för '_systemd-resolved_'.
```bash
$ man 8 systemd-resolved
```
Och relevanta manpages under rubriken '_SEE ALSO_'.
```bash
$ man 8 systemd-resolved | sed -n '316,318p'
SEE ALSO
       systemd(1), resolved.conf(5), dnssec-trust-anchors.d(5), nss-resolve(8), resolvectl(1), resolv.conf(5),
       hosts(5), systemd.network(5), systemd-networkd.service(8)
```
Hittar verktyget '_resolvectl_' och tillvalet '_statistics_'.

## Fråga 9
> How many domain names have been cached on your computer.
```bash
$ sudo resolvectl statistics
Transactions
                       Current Transactions:     0
                         Total Transactions: 48656

Cache
                         Current Cache Size:     5
                                 Cache Hits: 12378
                               Cache Misses: 23641

Failure Transactions
                             Total Timeouts:     3
         Total Timeouts (Stale Data Served):     0
                    Total Failure Responses:  2739
Total Failure Responses (Stale Data Served):     0

DNSSEC Verdicts
                                     Secure:     0
                                   Insecure:     0
                                      Bogus:     0
                              Indeterminate:     0
```
```bash
$ resolvectl statistics | awk '/Current Cache Size/ {print}'
                         Current Cache Size:     5

$ sudo resolvectl show-cache
Scope protocol=dns ifindex=2 ifname=enp3s0
www.hkr.se IN A 194.47.45.20
github.githubassets.com IN A 185.199.109.215
github.githubassets.com IN A 185.199.111.215
github.githubassets.com IN A 185.199.108.215
github.githubassets.com IN A 185.199.110.215
prod-images.merino.prod.webservices.mozgcp.net IN A 34.111.211.209
connectivity-check.ubuntu.com IN AAAA 2620:2d:4002:1::1057
connectivity-check.ubuntu.com IN AAAA 2620:2d:4000:1::1100
connectivity-check.ubuntu.com IN AAAA 2620:2d:4002:1::1058
connectivity-check.ubuntu.com IN AAAA 2620:2d:4002:1::1061
connectivity-check.ubuntu.com IN AAAA 2620:2d:4000:1::1101
connectivity-check.ubuntu.com IN AAAA 2620:2d:4000:1::1099
connectivity-check.ubuntu.com IN AAAA 2620:2d:4002:1::198
connectivity-check.ubuntu.com IN AAAA 2620:2d:4002:1::196
connectivity-check.ubuntu.com IN AAAA 2620:2d:4002:1::1062
connectivity-check.ubuntu.com IN AAAA 2620:2d:4002:1::1060
connectivity-check.ubuntu.com IN AAAA 2620:2d:4002:1::1064
connectivity-check.ubuntu.com IN AAAA 2620:2d:4002:1::197
ads-img.mozilla.org IN A 151.101.1.91

Scope protocol=dns
No entries.

```
Svaret är fem domän namn.
