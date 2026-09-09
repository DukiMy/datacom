# Mock Lab 1 — Network Traffic Analysis with Wireshark

## Data Communication and Networks — DA541A-style exercise

**Important:** This is a constructed practice lab, not an official HKR assignment.

## 1. Purpose

The purpose of this laboratory is to develop a practical understanding of network communication by observing real traffic using Wireshark.

After completing the lab, you should be able to:

* identify common network protocols;
* distinguish between MAC addresses, IP addresses, and port numbers;
* explain basic ARP, DNS, ICMP, TCP, and HTTPS communication;
* identify the TCP three-way handshake;
* relate captured packets to the TCP/IP and OSI models;
* interpret basic Wireshark captures;
* explain a sequence of network events in a written report.

---

# 2. Required software

You need:

* Wireshark
* a computer connected to a network
* a web browser
* a terminal

Linux commands will be used in the examples.

You may inspect your configuration with:

```bash
ip addr
ip route
ip neigh
```

For DNS:

```bash
dig example.com
```

or:

```bash
nslookup example.com
```

---

# 3. Preparation

Before starting Wireshark, determine the following information about your computer.

Record:

1. Your IPv4 address.
2. Your subnet prefix or subnet mask.
3. Your default gateway.
4. The MAC address of your active network interface.
5. The DNS server your computer uses.

Example:

```text
IPv4 address:     192.168.1.74
Subnet:           192.168.1.0/24
Default gateway:  192.168.1.1
MAC address:      3c:52:82:ab:14:7f
DNS server:       192.168.1.1
```

### Question 1

Explain the purpose of:

* an IP address;
* a MAC address;
* a default gateway;
* a DNS server.

---

# 4. Part A — ICMP and ping

Start Wireshark and select your active network interface.

Use this display filter:

```text
icmp
```

Then run:

```bash
ping -c 4 1.1.1.1
```

Stop the capture.

You should see packets resembling:

```text
192.168.1.74  →  1.1.1.1
ICMP Echo Request

1.1.1.1  →  192.168.1.74
ICMP Echo Reply
```

## Questions

### Question 2

What are the source and destination IP addresses of the first Echo Request?

### Question 3

What are the source and destination IP addresses of the corresponding Echo Reply?

### Question 4

Does ICMP use TCP or UDP port numbers?

Explain your answer.

### Question 5

Approximately how much time passes between the request and reply?

Compare this with the output from `ping`.

---

# 5. Part B — ARP

Clear the Wireshark capture and use:

```text
arp
```

Inspect the ARP traffic generated on your local network.

If necessary, inspect your neighbour table:

```bash
ip neigh
```

You may see traffic resembling:

```text
Who has 192.168.1.1?
Tell 192.168.1.74
```

followed by:

```text
192.168.1.1 is at aa:bb:cc:dd:ee:ff
```

## Questions

### Question 6

What problem does ARP solve?

### Question 7

Assume your computer wants to send a packet to:

```text
8.8.8.8
```

Your computer is:

```text
192.168.1.74/24
```

and your router is:

```text
192.168.1.1
```

Does your computer use ARP to discover the MAC address of `8.8.8.8`?

Explain precisely what happens.

### Question 8

Which MAC address is used as the Ethernet destination when your computer communicates with an Internet host outside the local subnet?

---

# 6. Part C — DNS

Start a new capture.

Use:

```text
dns
```

Then execute:

```bash
dig example.com
```

or open:

```text
https://example.com
```

Inspect the DNS request and response.

A simplified exchange might look like:

```text
Computer                        DNS server

   -------- query ------------>
        example.com A

   <------- response -----------
        example.com
        93.184.216.34
```

## Questions

### Question 9

What transport protocol is used for the DNS query you captured?

### Question 10

What is the destination port of the DNS request?

### Question 11

Find the DNS transaction ID.

Why is such an identifier useful?

### Question 12

What IP address was returned for the requested hostname?

### Question 13

Explain the difference between:

```text
example.com
```

and:

```text
93.184.216.34
```

in terms of DNS and IP networking.

---

# 7. Part D — TCP

Start another capture.

Use:

```text
tcp
```

Open a website using HTTPS.

For example:

```text
https://example.com
```

Find a new TCP connection.

You should be able to locate something similar to:

```text
Client                             Server

52718  -------- SYN ----------->   443

52718  <----- SYN, ACK ---------   443

52718  -------- ACK ----------->   443
```

## Questions

### Question 14

Identify:

* client IP;
* server IP;
* client port;
* server port.

### Question 15

What three packets constitute the TCP three-way handshake?

### Question 16

What is the purpose of the SYN flag?

### Question 17

What is the purpose of the ACK flag?

### Question 18

Why does the client normally use a temporary high-numbered port instead of port 443?

### Question 19

What identifies a TCP connection?

A complete answer should discuss the combination:

```text
source IP
source port
destination IP
destination port
protocol
```

---

# 8. Part E — TCP sequence numbers

Select one TCP connection.

Right-click a packet and choose:

```text
Follow
→ TCP Stream
```

Then inspect several TCP packets.

You may see:

```text
Packet 1:
Seq = 1
Len = 517

Packet 2:
Ack = 518
```

## Question 20

Explain why the acknowledgement number is `518`.

### Question 21

What problem do TCP sequence numbers solve?

Discuss at least:

* packet ordering;
* lost data;
* retransmission.

---

# 9. Part F — HTTPS and TLS

Filter:

```text
tls
```

Inspect the beginning of the HTTPS connection.

You may observe packets such as:

```text
Client Hello
Server Hello
Encrypted Application Data
```

## Questions

### Question 22

What TCP port is normally used by HTTPS?

### Question 23

Can you read the complete HTTP request directly in Wireshark when normal HTTPS is used?

Why or why not?

### Question 24

Which information is still visible even though the application data is encrypted?

For example, consider:

* IP addresses;
* MAC addresses;
* TCP ports;
* packet size;
* packet timing;
* DNS queries.

### Question 25

Does HTTPS hide the destination IP address from an observer on the network?

Explain.

---

# 10. Part G — Follow the entire communication

Now consider the following scenario:

You open:

```text
https://example.com
```

Arrange the following events into a reasonable order:

```text
A. TCP handshake
B. DNS lookup
C. HTTP request
D. ARP lookup for the gateway
E. TLS handshake
F. IP packets sent toward the server
```

### Question 26

Write the correct sequence and explain each stage.

A simplified model might resemble:

```text
User enters hostname
        │
        ▼
       DNS
        │
        ▼
Determine destination IP
        │
        ▼
Determine next hop
        │
        ▼
       ARP
        │
        ▼
      TCP
        │
        ▼
      TLS
        │
        ▼
      HTTP
```

---

# 11. Part H — Relating packets to network layers

Place each item in the appropriate TCP/IP layer:

```text
Ethernet
ARP
IPv4
ICMP
TCP
UDP
DNS
HTTP
TLS
```

Use the following model:

| TCP/IP layer | Protocols |
| ------------ | --------- |
| Application  | ?         |
| Transport    | ?         |
| Internet     | ?         |
| Link         | ?         |

### Question 27

Complete the table.

### Question 28

Consider this packet:

```text
Ethernet II
    IPv4
        TCP
            TLS
                Application Data
```

Explain the concept of **encapsulation** using this packet as your example.

---

# 12. Analysis question

Consider this capture:

```text
No.   Source          Destination     Protocol   Info

1     192.168.1.74    192.168.1.1     ARP        Who has 192.168.1.1?
2     192.168.1.1     192.168.1.74    ARP        192.168.1.1 is at aa:bb:cc:dd:ee:ff

3     192.168.1.74    192.168.1.1     DNS        Query A www.example.org
4     192.168.1.1     192.168.1.74    DNS        Response A 203.0.113.20

5     192.168.1.74    203.0.113.20    TCP        53214 → 443 [SYN]
6     203.0.113.20    192.168.1.74    TCP        443 → 53214 [SYN, ACK]
7     192.168.1.74    203.0.113.20    TCP        53214 → 443 [ACK]

8     192.168.1.74    203.0.113.20    TLS        Client Hello
9     203.0.113.20    192.168.1.74    TLS        Server Hello
```

### Question 29

Describe what happened from packet 1 through packet 9.

Your answer should explain **why**, rather than merely repeat the packet descriptions.

---

# 13. Submission

Submit one PDF laboratory report.

Suggested structure:

```text
1. Introduction
2. Method
3. Results
4. Analysis
5. Discussion
6. Conclusion
```

Include relevant screenshots from Wireshark.

Do **not** fill the report with screenshots without explanation.

Each screenshot should support some statement you make.

---

# Example laboratory report

## 1. Introduction

The purpose of the laboratory was to study practical network communication using Wireshark. Traffic generated by ICMP, ARP, DNS, TCP, and TLS was captured and analysed.

Particular attention was given to the relationship between different network layers and to the sequence of operations occurring when a computer communicates with a remote Internet server.

## 2. Method

Wireshark was started on the computer's active network interface.

The computer had the following network configuration:

```text
IPv4 address:     192.168.1.74
Subnet:           192.168.1.0/24
Default gateway:  192.168.1.1
```

Traffic was generated using `ping`, `dig`, and a web browser.

Wireshark display filters were used to isolate different protocols:

```text
icmp
arp
dns
tcp
tls
```

## 3. ICMP results

The command:

```bash
ping 1.1.1.1
```

generated ICMP Echo Request and Echo Reply packets.

The first request had:

```text
Source:       192.168.1.74
Destination:  1.1.1.1
```

The reply reversed these addresses.

ICMP does not use TCP or UDP ports. ICMP operates directly above IP and identifies different message types using ICMP-specific fields instead.

The measured round-trip time was approximately:

```text
18 ms
```

This corresponded closely to the value reported by the `ping` utility.

## 4. ARP analysis

Before packets could leave the local network, the computer needed the MAC address corresponding to its next hop.

Because `1.1.1.1` does not belong to the local `192.168.1.0/24` subnet, the computer did not attempt to discover the MAC address belonging to `1.1.1.1`.

Instead, it sent traffic to its default gateway:

```text
192.168.1.1
```

ARP was therefore used to discover the gateway's MAC address.

This demonstrates an important distinction:

```text
IP destination:
1.1.1.1

Ethernet destination:
MAC address of 192.168.1.1
```

The IP destination remains the final remote host, while the Ethernet frame is addressed to the next device on the local network.

## 5. DNS analysis

A DNS query was generated for `example.com`.

The request used UDP destination port:

```text
53
```

The DNS server returned an IPv4 address corresponding to the hostname.

DNS therefore provides a mapping between human-readable names and network addresses.

Without DNS, the application could theoretically contact the same server using its IP address directly, but users would need to remember numerical addresses.

## 6. TCP connection establishment

After the destination address was known, the client established a TCP connection.

The captured sequence was:

```text
Client                     Server

      SYN ---------------->
          <------------- SYN + ACK
      ACK ---------------->
```

The client used a temporary local port while the server listened on port:

```text
443
```

The connection could therefore be identified using:

```text
192.168.1.74:53214
        ↕
203.0.113.20:443
```

The SYN packet initiated the connection and synchronised TCP sequence numbers.

The SYN+ACK indicated that the server accepted the connection and acknowledged the client's request.

The final ACK completed connection establishment.

## 7. TLS and HTTPS

After TCP connection establishment, a TLS handshake was observed.

The packets included:

```text
Client Hello
Server Hello
```

After negotiation, subsequent application traffic appeared primarily as encrypted TLS application data.

This means Wireshark could observe that communication occurred but could not normally display the HTTP message contents.

However, encryption did not conceal all metadata.

The observer could still see information such as:

```text
source IP address
destination IP address
TCP ports
packet lengths
packet timing
```

HTTPS therefore protects the content of communication but does not make the communication itself invisible.

## 8. Encapsulation

The captured HTTPS traffic demonstrated encapsulation.

Application data was transported inside TLS.

TLS data was transported inside TCP.

TCP segments were transported inside IP packets.

IP packets were transported inside Ethernet frames.

Conceptually:

```text
Ethernet frame
└── IP packet
    └── TCP segment
        └── TLS record
            └── Application data
```

Each networking layer provides services to the layer above it while adding information required by its own layer.

## 9. Complete communication sequence

When `https://example.com` was opened, the communication could be summarized as:

```text
DNS resolution
      ↓
Determine destination IP
      ↓
Routing decision
      ↓
ARP for local next-hop MAC address
      ↓
TCP three-way handshake
      ↓
TLS handshake
      ↓
Encrypted HTTP communication
```

DNS first resolved the hostname into an IP address.

The routing table determined whether the destination was local or required the default gateway.

ARP supplied the local MAC address necessary to deliver Ethernet frames to the next hop.

TCP then established reliable transport.

TLS established an encrypted channel.

Finally, HTTP application data was exchanged through the encrypted connection.

## 10. Discussion

The laboratory demonstrates that accessing a website involves several separate protocols working together.

A user generally sees only a URL and webpage, but underneath this operation DNS provides name resolution, Ethernet provides local delivery, IP provides addressing and routing, TCP provides reliable communication, and TLS provides encryption.

Wireshark makes these interactions observable and shows that the TCP/IP model represents real communication rather than merely a theoretical abstraction.

## 11. Conclusion

The laboratory provided practical experience with several fundamental Internet protocols.

ICMP demonstrated basic IP communication, ARP demonstrated local address resolution, DNS demonstrated hostname resolution, TCP demonstrated reliable connection establishment, and TLS demonstrated encrypted application communication.

The capture also illustrated encapsulation and the division of networking responsibilities across multiple protocol layers.

---

# Self-assessment

You are in good shape for this kind of lab if you can answer these without looking them up:

1. What does ARP translate between?
2. Why does a computer need a default gateway?
3. What is the difference between a MAC address and an IP address?
4. Why does DNS normally use port 53?
5. What are SYN, SYN-ACK, and ACK?
6. Why does a TCP client need its own port number?
7. What does `/24` mean?
8. Why can Wireshark see TCP headers but not normal HTTPS contents?
9. What is encapsulation?
10. What happens between typing a URL and receiving the webpage?

If those ten questions become comfortable, the introductory practical networking material should be considerably easier.

