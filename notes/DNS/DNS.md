# Domain Name System (DNS) notes
    The Domain Name System maps domain names (www.google.com) to information such 
    as IP-addresses (142.251.142.238).

    The service works on the application layer.

    The use case is to have human-memorable addresses instead of generic
    IP-addresses.

## There are several DNS servers at different network layers.
    - The local computer may have a local resolver and cache. On my Ubuntu 
      system, systemd-resolved listens at 127.0.0.53 .
    - The router may forward DNS queries from devices on the home network and 
      may cache answers.
    - The Internet Service Provider has one.
    - Authoritative DNS servers hold the DNS records for particular domains 
      and provide answers to resolvers.

## Name resolution note:
    Entering the address 'http://example.com/page' does not send the whole 
    string to the DNS server. Only 'example.com' needs resolution.
    The rest ('/page') is used as a http request.

## Hierarchical structure - Domains and Zones.
    +------------+       -
    |root domain |       : root domain
    |     .      |       :
    +------------+       -
    |      |  |  |       : Top level domains
    +----+ |  |  |       :
    |.com| |  |  |       :
    +----+ |  |  +----+  :
           |  |  |.net|  :
      +----+  |  +----+  :
      |.org|  |          :
      +----+  +----+     :
      |       |.se |     :
      |       +----+     -
      |                  : ZONE CNAME                    
      +----------------+ :
      |en.wikipedia.org| :
      +----------------+ -

    www.hkr.se
    ^   ^   `- Top level domain
    |   `- Domain name
    `- Computer name - HTTP server in this case.
    
    Thirteen root servers spread across the world.
    They keep the top level domains (.com, .net, .org ...)

# Recursive question.
    User runs: resolvectl query www.hkr.se

    1. resolvectl asks the local systemd-resolved service to resolve the name.
    2. systemd-resolved checks whether it already has an answer cached.
    3. If it needs an external answer, it sends DNS queries for address records
       (A for IPv4 and AAAA for IPv6) to its configured upstream DNS server.
    4. On your previously shown setup, that upstream server was your router,
       192.168.0.1. The router may answer from its cache or forward the question
       to another resolver, such as one operated by your ISP.
    5. The recursive resolver obtains an answer, potentially consulting the
       DNS hierarchy, and returns it along the chain.
    6. systemd-resolved returns the address to resolvectl.


# Iterative question
    1. Can you give me the address to 'www.hkr.se'?
    2. Possible answwers:
        - yes
        - no
        - Check with ...

# Iterative resolution of an A record for www.hkr.se

    1. Resolver → root server:
       "What is the A record for www.hkr.se?"
       Root → resolver:
       "Ask the name servers for .se."          [referral]

    2. Resolver → .se name server:
       "What is the A record for www.hkr.se?"
       .se → resolver:
       "Ask the name servers for hkr.se."        [referral]

    3. Resolver → hkr.se authoritative server:
       "What is the A record for www.hkr.se?"
       Server → resolver:
       "Here is the answer."                     [answer]

    The record may be cached, so it maybe doesnt need to ask the question.

# Caching in DNS servers

    

