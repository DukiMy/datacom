## The set-out
How do two devices coordinate the delivery of a sequence of bits? Bits can be delivered sequentially or in paralell. It can be done synchronously, asynchronously or isochronously.

## Fundamental categories of transmission modes
- Serial transmissions.
    - Asynchronous.
    - Synchronous.
    - Isochronous.

- Paralell transmissions.

### Paralell transmission
Multiple wires transmit bits that ultimately belong together.
- High throughput. A transmission in N wires send N bits at the same time that a serial transmission sends 1 bit.
- Matches underlying hardware that also is designed in paralell circuuits.

Problems are caused by wires that differ in length. Even 1 millimeter in difference can cause issues due to signals that belong together not arriving together.

### Serial transmission
Everything is sent on one wire. This is the least complex mode, and is the most often used in computer networks.

### Conversion between transmission modes
Most serial circuits need a chip that converts data in paralell mode to data in serial mode. This is called a UART (Universal Asynchronous Receiver and Transmitter).

## Transmission order 
A set of bytes and a set of bits can be sent in orders that are independent of eachother.
A system that orders its data by its most significant bit first is called "_big endian_", and "_little endian_" for data ordered by its least significant bit first. 

![Fig. 1: Visualisation of bit and byte order.](/home/durim/Education/hkr-uni/datacom/notes/transmission-modes/resources/img/msb_lsb.png)

Byte order can be in little endian while bit order can be in big endian for the same piece of data. The important thing is that both communicating systems agree on how to order the data.

## Timing in serial transmissions
- Asynchronous (Not timed together) transmissions can have arbitrary delays.
- Synchronous (timed together) transmissions happen without interuption.
- Isochronous (equal time) transmissions occurs with regular and fixed gaps between the data.

### Serial Asynchronous transmission
This timing mode is well suited for transmissions which can not be predicted to arrive at a certain time.

- A user giving input.
- Random generation of data.

The downside is that the computer expends resources in waiting for input. This can be solved by sending bits that signal the start and end of a transmission.

```
+15v ┬   ┌─┐   ┌─┐   ┌─┐ ┌─┐   ┌─┐
  0v ┼   │ │   │ │   │ │ │ │   │ │
-15v ┴───┘ └───┘ └───┘ └─┘ └───┘ └──────
      1 1 0 1 1 0 1 1 0 1 0 1 1 0 ^ ^ 
      ^ ^                         │ │ 
   idle|start                  stop|idle
```

### Serial synchronous transmission
This mode supposes a constant transmission. 

```
+15v ┬┌─┐   ┌─┐   ┌─┐ ┌─┐   ┌─┐
  0v ┼│ │   │ │   │ │ │ │   │ │
-15v ┴┘ └───┘ └───┘ └─┘ └───┘ └...
       0 1 1 0 1 1 0 1 0 1 1 0 . . .
```

When comparing the two figures above, it is easily observable that the _serial asynchronous mode_ carries more overhead.

The downside with _serial synchronous mode_ is that the sender must send data continuously. What do we do when there is no more data to send but you do not want the overhead of the _serial asynchronous mode_?
The concept of framing needs to be introduced. The data is sent in a frame that can define idle gaps between the data.

### Serial isochronous transmission
This transmission mode is well suited for transmitting live voice and video data. The constant stream of data, coming in exact intervals work well with the mediaplayers that must play the content at a certain bitrate. 

## Simplex, half-duplex and full-duplex transmissions
These concepts explain the directionality of the data transmissions.

- Simplex - One directional transmission.
    - An optical fiber - Due to each end only having the ability to shine or detect light pulses.
- Full-duplex - Bi-directional and simultaneous transmission.
    - Can be constructed with two simplex devices.
- Half-duplex - Bi-direction but sequential. A pair of devices that must take turns to communicat. A pair of com-radios for example.

## DCE and DTE equipment.
DCE and DTE are abbreviations for _Data Communications Equipment_ and _Data Terminal Equipment_.

A service provider could ask a phone company to install DCE on their premises, and then let the consumer use an arbitrary device for comminicating through the DCE.

The first thing that comes to mind is the way that the early internet used phone lines for communication.
Phone companies offered DCE's (56k modems) to serviceproviders and consumers who then would attach an arbitrary DTE (computer) for communicating over already existing infrastructre.

Possible interfaces between a DCE and DTE.
```
┌────┐         
│User│         
└─┬──┘         
  │ Keyboard, mouse, ...
  │ ┌─────────────┐
  └─┤Data Terminal│
    │  Equipment  │
    └─┬───────────┘
      │ RS-232, RS-449 interfaces
      │┌─────────────────────────────────┐
      └┤Data Circuit-terminating euipment│
       └─┬───────────────────────────────┘
         │ Communications network. V.90, DSL, Cable interfaces.
       ┌─┴───────────────────────────────┐
      ┌┤Data Circuit-terminating euipment│
      │└─────────────────────────────────┘
      │ RS-232, RS-449 interfaces
    ┌─┴───────────┐
    │Data Terminal│
  ┌─┤  Equipment  │
  │ └─────────────┘
  │ Keyboard, mouse, ...
┌─┴──┐         
│User│         
└────┘         
```
- [RS-232 standard interface](https://en.wikipedia.org/wiki/RS-232)
- [RS-449 standard interface](https://en.wikipedia.org/wiki/RS-449)
- [X.21 standard interface](https://en.wikipedia.org/wiki/X.21)
















