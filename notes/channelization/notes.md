## The set out
How can several independent lines of communication share the same transmission medium?
What are the four basic types of multiplexing?
How can a range of frequencies be used to increase the data transmission rate.

### Multiplexing. Sharing resources cost less.
```
┌────────────┐┌────────────┐┌────────────┐
│ Computer 1 ││ Computer 2 ││ Computer 3 │
└──────┬─────┘└──────┬─────┘└──────┬─────┘
       └─────────────┼─────────────┘ Multiplexing.
                     │ How does one combine signals on one medium?
              ┌──────┴─────┐
              │  Building  │
              └────────────┘
```
### Channelization.
```
┌────────────┐┌────────────┐┌────────────┐
│ Computer 1 ││ Computer 2 ││ Computer 3 │
└──────┬─────┘└──────┬─────┘└──────┬─────┘
       └─────────────┼─────────────┘
                     │ Channelization
              ┌─┬────┼───┬─┐ How does one organize and share
              │ c1  c2  c3 │ different communication signals on
              │  Building  │ the same medium?
              └────────────┘
```
Modulation of signals need to be introduced to get this working.
There are four main categories of modulation techniques that help channelize signals.

- Frequency Division Multiplexing (FDM)
    - Simultaneous transmission on different EM bands.
- Wavelength Division Multiplexing (WDM)
    - Simultaneous transmission on different optical wavelengths.
- Time Division Multiplexing (TDM)
    - Sequential transmission of different signals.
        - Synchronous TDM.
            - Signals differentiate by schedule.
        - Statistical TDM.
            - Signals differentiate by identifiers.
- Code Division Multiplexing (CDM)
    - Signals overlap in time and frequency. Code distinguishes the recipients.

### Demultiplexing.
```
┌────────────┐┌────────────┐┌────────────┐
│ Computer 1 ││ Computer 2 ││ Computer 3 │
└──────┬─────┘└──────┬─────┘└──────┬─────┘
       └─────────────┼─────────────┘
                     │ 
              ┌─┬────┼───┬─┐ Demultiplexing.
              │ c1  c2  c3 │ How does one split the signals?
              │  Building  │
              └────────────┘
```
### No multiplexing, channelization or demultiplexing.
Less cost efficient.
```
┌────────────┐┌────────────┐┌────────────┐
│ Computer 1 ││ Computer 2 ││ Computer 3 │
└──────┬─────┘└──────┬─────┘└──────┬─────┘
       │             │             │
       │             │             │ Multiple computers and lines.
       │      ┌──────┴─────┐       │
       └──────┤  Building  ├───────┘
              └────────────┘
```
## Frequency Division Multiplexing
A good example are radio waves that share the same space to send signals on different frequencies.
These Frequencies are susceptible to interference. A buffer of about 20 KHz is used between the bands that transmit a certain signal.

### Hierarchical FDM
Frequencies are multiplexed into larger groups. One large group can take thousands of phone signals. That group later gets demultiplexed into several smaller groups. And this continues on untill each phone gets their own signal.

## Wavelength Division Multiplexing
This works in by the same principle as FDM. But instead of modulation radiofrequencies, one modulates wavelengths of light.
Multiplexing and demultiplexing is done by prisms that combine and separate wavelengths of light, to and from one single beam.

## Time Division Multiplexing
The chief alternative of FDM. Signals are sent sequentially, meaning that the multiplexors take turns sending each signal, and demultiplexors divide the signals according to the agreed schedule.

### Synchronous TDM
TDM is a wide concept. Implementations may differ.
Some use round-robin ordering, some use prioritized ordering and some do not.
_Synchronous time ordering_ send data without any delays between the different data signals.
Often used by analogue telephone systems.

### Hiearchical TDM
Instead of having a hierarchy of frequencies like in hierarchical FDM, here you have groupings based on time.
A supergroup has a large amount of Mbps, then that supergroup is divided into smaller groups (by a demultiplexor) which also divide the total amount of bytes per time unit. Eventually, the division goes down to individial timeperiods per device.
Additional framing bits are added by the multiplexor, this gives a greater bit rate than all the signals combined.

### Problems with synchronous TDM
TDM works efficiently when data arrives at a fixed rate. For example multiple phone calls create streams of 64 Kbps each.
In other forms of datacommunication, data arrives in bursts. TDM is not optimised for handling this kind of data. The issue of bursting data causes unfilled slots in the stream. These slots are wasted.

### Statistical TDM
This multiplexing technique solves the problem with unused slots.
Instead of waiting for a senders data, the slot is given to the next sender in line. See [round-robin ordering](https://en.wikipedia.org/wiki/Round-robin_scheduling).
The downside is that each slot needs an identifier. The overall tradeoff is acceptable. Especially since when one only one user is active on the line, that user can take advantage of all the bandwidth.
This easily compensates for the extra overhead in the form of identifying bits.

## Inverse multiplexing
This is the process of combining multiple smaller bandwidth links into one large bandwidth link. Ten 10 Mbps streams can be multiplexed into one 100 Mbps stream. A demultiplexing process does not seem to be needed.
This is often more economical than having one large capacity circuit.

## Code Division Multiplexing (CDM)
This takes advantage of a mathematical phenomenon called [orthogonality](https://en.wikipedia.org/wiki/Orthogonality_(mathematics)), which says that two elements on a vector space are orthogonal if their multiplied directional values are 0 when summed.

The chip sequences need to have this property, and they are chosen independently of the message being sent.

The bonus of using CDM is that it incurs no delay for the users when the amount of transmissions scale.

The malus of using CDM is that the chipsequence becomes large quickly, and this incurs a lot of overhead. The requirement of having no delays when the amount of transmissions scale has to be great.


- [Round-Robin scheduling](https://en.wikipedia.org/wiki/Round-robin_scheduling) 

