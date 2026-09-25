# The TCP/IP model.
- TCP stands for Transport Control Protocol.
Inherently based on connections between nodes.

- IP stands for Internet Protocol.
Inherently a connectionless protocol.

* Standardized by RFC 1122.
* There are mentions of RFC 1123 also.

## The five layer TCP/IP model.
+-------------------------------+
| Application layer             | <- Describes the application data.
+-------------------------------+
| Transport layer               | <- Describes the application endpoint (port nr).
+-------------------------------+
| Internet layer                | <- Describes the host that should receive the packet (IP address). 
+-------------------------------+
| Networking layer / link layer | <- Describes the the next device in the link (MAC address).
+-------------------------------+
| Physical layer                | <- Describes the physical medium that the bits travel through.
+-------------------------------+

# The four layer model of the same TCP/IP model.

                           +------+           Application layer
                           | DATA |             A query or a request only understood by the 
                           |      |             receiving application.
                  +--------+------+           Transport layer
                  | UDP    | UDP  |             Which application endpoint should receive it?
                  | HEADER | DATA |             E.g. the port number that will receive the data.
         +--------+--------+------+           Internet layer
         | IP     |    IP DATA    |             Which host should receive the packet.
         | HEADER |               |             Potentially goes across multiple networks.
+--------+--------+--------+------+--------+  Network interface layer
| FRAME  |     ETHERNET FRAME     | FRAME  |    How it is delivered across this one link to the 
| HEADER |          DATA          | FOOTER |    next device. E.g. an ethernet frame adressed to
+--------+------------------------+--------+    a MAC address.
                                                The computer sends an ARP message to the network,
                                                in which the router replies. The router later ...

# The creation of ethernet frames.
1. The computer sends an ARP message on the LAN, and the router replies with its MAC address.
    Q.1. Does the computer send an ARP message every single time? Or is it stored in some session 
         in order to be reused? Are there LAN's configured with multiple routers. And does the computer
         send an ARP every time in such a configuration?

    A.1. It keeps the address at the so called neighbor cache.
         Accessible throught the command ```ip neigh```.
            ```
            ip neigh
            192.168.0.1 dev enp3s0 lladdr 20:23:51:ef:7a:2c REACHABLE 
            ```

2. The computer uses that reply to create an ethernet frame adressed to the routers MAC address.
3. The router receives the frame and creates a new one for the next hop, usually the ISP's router.

