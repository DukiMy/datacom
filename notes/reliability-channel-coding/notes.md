# Chapter 8 - Reliability and Channel Coding.

## Main question to answer.
How can we communicate reliably when the transmission channel 
sometimes corrupts our data?

### Detection
The central idea is to add redundancy that can check the validity 
of the transmission.
 - Codewords (encoded bit patterns)
 - Checksums
 - ...

### Retransmission
Once detected, a retransmission request is sent.
 - ARQ - Automatic Repeat Request

### Reconstruct original message
Once detected, redundant information can be used to reconstruct the 
original message.
 - FEC - Forward Error Correction

# Questions to be asked for each method.
| What redundancy? | Which errors detected/corrected | What errors slip through |
| :--------------- | :------------------------------ | :----------------------- |
| Redundancy | Detect_correct | undetected |
| Redundancy | Detect_correct | undetected |


## Introduction
Discussed here are errors and control techniques that can be used to 
catch them.

## Three main sources of transmission errors
 - Interference
    Interference from other radiating devices.

 - Distortion
    Dispersion in optical fibers.
    Capacitance and inductance in copper wires.

 - Attenutation
    A signal becoming weaker.

## Suggestion - Shannons theorem
 - Increase signal to noise ratio.
    Increase signal.
    Redice noise.

## Effect of transmission errors on data.
| Type of error | Description |
| :-------------- | :--------------- |
| Single bit error | A spike in transmisssion signal indicates a single bit error. |
| Burst error      | Longer duratio burst in transmission indicates multiple bit error. |
| Erasure          | The signal is not clearly 1 or 0, resulting in an erasure. |

Burst errors are defined from the start of the corruption to the end of the corruption.
Even uncorrupted bits in-between are counted.

# Channel Coding
Techniques for correcting corrupted data.
Two broad categories exist.

## ARQ - Automatic Repeat Request

    ┌──────────────┐  ┌──────────────┐
    │ ┌──SOURCE─┐  │  │ ┌─CONSUMER   │
    └─┼─────────┼──┘  └─┼────────────┘
      ⇑         ⇓       ⇑             
    ┌─┼─────────┼──┐  ┌─┼────────────┐
    │ │TRANSMITTER │  │ ⇑  RECEIVER  │
    │ │         │  │  │ ACK          │
    │ │┌────────┼─┐│  │┌┼───────────┐│
    │ ││encode CRC││  ││ check CRC  ││
    │ │└────────┼─┘│  │└┼────────┬──┘│
    │ │         │  │  │ ⇑       NACK │
    └─┼─────────┼──┘  └─┼────────┼───┘
      ⇑         └ ⇒ ⇒ ⇒ ┘        ⇓    
      └⇐ ⇐  RETRANSMIT PLEASE⇐ ⇐ ┘     


## FEC - Forward Error Correction

    ┌──────────────┐  ┌──────────────┐
    │ ORIGINAL MSG │  │ ORIGINAL MSG │
    └──────────┬───┘  └──────────┬───┘
               ⇓                 ⇑    
    ┌──────────┼───┐  ┌──────────┼───┐ 
    │ ENCODER  ⇓   │  │ DECODER  ⇑   │
    │┌─────────┴──┐│  │┌─────────┴──┐│
    ││ accept msg ││  ││ deliver msg││
    │└─────────┬──┘│  │└─────────┬──┘│
    │          ⇓   │  │          ⇑   │
    │┌─────────┴──┐│  │┌─────────┴──┐│
    ││ Add extra  ││  ││ check and  ││
    ││ bits       ││  ││ correct    ││
    │└─────────┬──┘│  │└─────────┬──┘│
    │          ⇓   │  │          ⇑   │
    │┌─────────┴──┐│  │┌─────────┴──┐│
    ││ encode word││  ││ decode word││
    │└─────────┬──┘│  │└─────────┬──┘│
    │          ⇓   │  │          ⇑   │
    └──────────┼───┘  └──────────┼───┘
               └ ⇒ ⇒ ⇒ ⇒ ⇒ ⇒ ⇒ ⇒ ┘

    Hamming code [15, 9]
    ╒═══════════════╕ ╒═══════════════╕ ╒═══════════════╕ ╒═══════════════╕ ╒═══════════════╕ ╒═══════════════╕ 
    │INPUT          │ │ADD CHECKSUM   │ │ADD CHECKSUM   │ │ADD CHECKSUM   │ │ADD CHECKSUM   │ │FINAL CHECKSUM │
    ╞═══╤═══╤═══╤═══╡⇒╞═══╤═══╤═══╤═══╡⇒╞═══╤═══╤═══╤═══╡⇒╞═══╤═══╤═══╤═══╡⇒╞═══╤═══╤═══╤═══╡⇒╞═══╤═══╤═══╤═══╡
    │   │   │   │ 0 │ │   │(0)│   │ 0 │ │   │   │(1)│ 0 │ │   │   │   │   │ │   │   │   │   │ │(0)│ 0 │ 1 │ 0 │
    ├───┼───┼───┼───┤⇒├───┼───┼───┼───┤⇒├───┼───┼───┼───┤⇒├───┼───┼───┼───┤⇒├───┼───┼───┼───┤⇒├───┼───┼───┼───┤
    │   │ 0 │ 1 │ 1 │ │   │ 0 │   │ 1 │ │   │   │ 1 │ 1 │ │(1)│ 0 │ 1 │ 1 │ │   │   │   │   │ │ 1 │ 0 │ 1 │ 1 │
    ├───┼───┼───┼───┤⇒├───┼───┼───┼───┤⇒├───┼───┼───┼───┤⇒├───┼───┼───┼───┤⇒├───┼───┼───┼───┤⇒├───┼───┼───┼───┤ 
    │   │ 0 │ 0 │ 0 │ │   │ 0 │   │ 0 │ │   │   │ 0 │ 0 │ │   │   │   │   │ │(1)│ 0 │ 0 │ 0 │ │ 1 │ 0 │ 0 │ 0 │
    ├───┼───┼───┼───┤⇒├───┼───┼───┼───┤⇒├───┼───┼───┼───┤⇒├───┼───┼───┼───┤⇒├───┼───┼───┼───┤⇒├───┼───┼───┼───┤
    │ 1 │ 1 │ 1 │ 0 │ │   │ 1 │   │ 0 │ │   │   │ 1 │ 0 │ │ 1 │ 1 │ 1 │ 0 │ │ 1 │ 1 │ 1 │ 0 │ │ 1 │ 1 │ 1 │ 0 │
    └───┴───┴───┴───┘ └───┴───┴───┴───┘ └───┴───┴───┴───┘ └───┴───┴───┴───┘ └───┴───┴───┴───┘ └───┴───┴───┴───┘
    ⇑ ⇑  ENCODER  ⇑ ⇑                                                                         ⇓ ⇓ TRANSMIT  ⇓ ⇓
    ┌───────────────┐                                                                         ╒═══════════════╕
    │  00110001110  │                                                                         │ERROR          │
    └───────────────┘                                                                         ╞═══╤═══╤═══╤═══╡
                                                                                              │ 0 │ 0 │ 1 │(1)│
                                                                                              ├───┼───┼───┼───┤
                                                                                              │ 1 │ 0 │ 1 │ 1 │
                                                                                              ├───┼───┼───┼───┤
                                                                                              │ 1 │ 0 │ 0 │ 0 │
    ┌───────────────┐                                                                         ├───┼───┼───┼───┤
    │  00110001110  │                                                                         │ 1 │ 1 │ 1 │ 0 │
    └───────────────┘                                                                         └───┴───┴───┴───┘
    ⇑ ⇑ ⇑  ACK  ⇑ ⇑ ⇑                                                                         ⇓ ⇓  DECODER  ⇓ ⇓ 
    ╒═══════════════╕ ╒═══════════════╕ ╒═══════════════╕ ╒═══════════════╕ ╒═══════════════╕ ╒═══════════════╕
    │CORRECTION     │ │ERROR DETECTED │ │ERROR DETECTED │ │NO ERROR DETECT│ │NO ERROR DETECT│ │WRONG CHECKSUM │
    ╞═══╤═══╤═══╤═══╡⇐╞═══╤═══╤═══╤═══╡⇐╞═══╤═══╤═══╤═══╡⇐╞═══╤═══╤═══╤═══╡⇐╞═══╤═══╤═══╤═══╡⇐╞═══╤═══╤═══╤═══╡
    │ 0 │ 0 │ 1 │(0)│ │   │(0)│   │ 1 │ │   │   │(1)│ 1 │ │   │   │   │   │ │   │   │   │   │ │(0)│ 0 │ 1 │ 1 │
    ├───┼───┼───┼───┤⇐├───┼───┼───┼───┤⇐├───┼───┼───┼───┤⇐├───┼───┼───┼───┤⇐├───┼───┼───┼───┤⇐├───┼───┼───┼───┤
    │ 1 │ 0 │ 1 │ 1 │ │   │ 0 │   │ 1 │ │   │   │ 1 │ 1 │ │(1)│ 0 │ 1 │ 1 │ │   │   │   │   │ │ 1 │ 0 │ 1 │ 1 │
    ├───┼───┼───┼───┤⇐├───┼───┼───┼───┤⇐├───┼───┼───┼───┤⇐├───┼───┼───┼───┤⇐├───┼───┼───┼───┤⇐├───┼───┼───┼───┤ 
    │ 1 │ 0 │ 0 │ 0 │ │   │ 0 │   │ 0 │ │   │   │ 0 │ 0 │ │   │   │   │   │ │(1)│ 0 │ 0 │ 0 │ │ 1 │ 0 │ 0 │ 0 │
    ├───┼───┼───┼───┤⇐├───┼───┼───┼───┤⇐├───┼───┼───┼───┤⇐├───┼───┼───┼───┤⇐├───┼───┼───┼───┤⇐├───┼───┼───┼───┤
    │ 1 │ 1 │ 1 │ 0 │ │   │ 1 │   │ 0 │ │   │   │ 1 │ 0 │ │ 1 │ 1 │ 1 │ 0 │ │ 1 │ 1 │ 1 │ 0 │ │ 1 │ 1 │ 1 │ 0 │
    └───┴───┴───┴───┘ └───┴───┴───┴───┘ └───┴───┴───┴───┘ └───┴───┴───┴───┘ └───┴───┴───┴───┘ └───┴───┴───┴───┘
