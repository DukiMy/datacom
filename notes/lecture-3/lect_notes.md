# Data Communications and network - Lecture 3
This lecture is based on the chapter 6 of the book 
"Computer Networks and Internets".

Some of the notes come from the lecture, and others come from 
chapter 6 of the aforementioned book.

## Information sources
What kind of sources of information?
- Microphone
- Video
- Keyboard
- Mouse
- Application programs
    - That generate or consume data, or both.

The sources of information can be arbitrary.

# Analog and digital signals are the types of information sources.
- Analog
    - Characterized by continuous mathematical function.
- Digital
    - Characterized by a fixed set of valid values.

The analog signal might be measured from a microphone.
The digital signal might be measured from a computer keyboard.

# Periodic and Aperiodic signals.
- Periodic is repeating.
- Aperiodic is non-repeating.

# Sine waves
Microphone produces sinewaves.
Characteristics of sine waves.
- Frequency (How many cycles)
- Amplitude (max min height)
- Phase (How far the starting point has shifted from a reference time)
- Wavelength (distance traveled through a medium, determined by speed that the signal travels through the medium)
- Equation for a sinusoidal signal: s(t) = Asin(2pift + theta)
    - f = frequency.
    - t = time.
    - theta = Phase (The starting point of the wave in the cycle).
    - A = amplitude, the greatest distance from zero.

Many natural phenomena produce sinewaves, therefore is it is funcamental
to signal processing.

# Composite waves
Composite waves are combined sinewaves.
Each can have their own frequency and amplitude.

# Bandwidth
The difference between the highest and lowest frequency.

# Digital signals
Either 0 or 1.
Voltage can represent digital values.
The more voltage can be used the more digital signals can be sent at 
the same time.

## At one lvl.
If -5v = 0 and 5v = 1.
If each signal must be read for 1 sec.
Then it takes 8 seconds to read a byte (really slow).

## At two lvls.
If -5v = 00, -2v = 01, 2v = 10 and 5v = 11.
Then 16 bits can be read in 8 seconds.
Doubling of the bandwidth.

## Baud and bits
### Baud
The amount of time that the signal has to be at one value in order 
for the receiver to read the data.

### Bit
The signal level. 

# Synchronization
The sender and receiver need to synchronize.
- They have to descide a starting point in time.
- They have to decide on the baud (amount of time that the signal is actual).

# Line coding
Example with return-to-zero (RZ) scheme:
The signal starts at 0v, and then goes to 5.
    bitvalue = 1
The signal starts at 0v, and then goes to -5.
    bitvalue = 0

The downside with RZ is that you loose the ability to use 0v as a bitvalue when 
sending multiple bits.

## Return-to-Zero (RZ) scheme.
Signal returns to zero during each bit-period.

           1  0  1  0 (bit value)
    +5v ┬ ┌─┐   ┌─┐                
     0v ┼─┘ └┐ ┌┘ └┐ ┌─────────────
    -5v ┴    └─┘   └─┘             
          0  1  2  3  (bit period)

## Non-Return-to-Zero-Level (NRZ-L) scheme.
The line never lands at zero, and always levels at the final bitlevel.

           1  0  1  0 (bit value)
    +5v ┬───┐  ┌──┐                
     0v ┼   │  │  │                
    -5v ┴   └──┘  └────────────────
          0  1  2  3  (bit period)

           0  0  1  0 (bit value)
    +5v ┬      ┌──┐                
     0v ┼      │  │                
    -5v ┴──────┘  └────────────────
          0  1  2  3  (bit period)

## Non-Return-to-Zero-Inverted (NRZ-I) scheme.
Bit value 1 is signified by a transition. No transition during a bit
period equals bit value 0.

           1   0   1   0  (bit value)
    +5v ┬ ┌───────┐                            
     0v ┼ │       │                    
    -5v ┴─┘       └────────────────────
          0   1   2   3   (bit period)


# Manchester encoding
It is easier to detect transition instead of levels.

The transition occurs in the middle of the timeslot for each bit.

    A transition from 0 to negative corresponds to bit 0.
    +----------------------------+
    | bittransition (high -> low)|
    |   -5v       0v       5v    |
    |   |---------<         |    |
    +----------------------------+

    A transition from 0 to positive corresponds to bit 1.
    +----------------------------+
    | bittransition (low -> high)|
    |   -5v       0v       5v    |
    |   |         >---------|    |
    +----------------------------+

1 corresponds with the transition to a positive voltage lvl.
0 correspomds with the transition to zero.

# Manchester line encoding
A transition in the middle of the bit-period going from 0v to +5v corresponds to bitvalue 1.
A transition in the middle of the bit-period going from +5v to 0v corresponds to bitvalue 0.

    ┼─────────────────────────────────────────────────────────────────────┼
    │ The transition occurs in the middle of the bit-period.              │
    │ Left and right column are vertically mirrored.                      │
    ┼ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ┼
    │     0 0 0 0 0 0 0 0  (bit value) │     1 1 1 1 1 1 1 1  (bit value) │
    │+5v ┼┐┌┐┌┐┌┐┌┐┌┐┌┐┌┐               +5v ┼┌┐┌┐┌┐┌┐┌┐┌┐┌┐┌              │
    │ 0v ┼└┘└┘└┘└┘└┘└┘└┘└              │ 0v ┼┘└┘└┘└┘└┘└┘└┘└┘              │
    │    0-1-2-3-4-5-6-7-8 (bit period)     0-1-2-3-4-5-6-7-8 (bit period)│
    ┼ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─│─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ┼
    │     0 1 0 1 0 1 0 1  (bit value)       1 0 1 0 1 0 1 0  (bit value) │
    │+5v ┼┐ ┌─┐ ┌─┐ ┌─┐ ┌─             │+5v ┼┌─┐ ┌─┐ ┌─┐ ┌─┐              │
    │ 0v ┼└─┘ └─┘ └─┘ └─┘                0v ┼┘ └─┘ └─┘ └─┘ └─             │
    │    0-1-2-3-4-5-6-7-8 (bit period)│    0-1-2-3-4-5-6-7-8 (bit period)│
    ┼ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ┼
    │     0 0 1 1 0 0 1 1  (bit value) │     1 1 0 0 1 1 0 0  (bit value) │
    │+5v ┼┐┌┐ ┌┐┌─┐┌┐ ┌┐┌               +5v ┼┌┐┌─┐┌┐ ┌┐┌─┐┌┐              │
    │ 0v ┼└┘└─┘└┘ └┘└─┘└┘              │ 0v ┼┘└┘ └┘└─┘└┘ └┘└              │
    │    0-1-2-3-4-5-6-7-8 (bit period)     0-1-2-3-4-5-6-7-8 (bit period)│
    ┼ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─│─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ┼
    │     0 0 0 0 1 1 1 1  (bit value)       1 1 1 1 0 0 0 0  (bit value) │
    │+5v ┼┐┌┐┌┐┌┐ ┌┐┌┐┌┐┌              │+5v ┼┌┐┌┐┌┐┌─┐┌┐┌┐┌┐              │
    │ 0v ┼└┘└┘└┘└─┘└┘└┘└┘                0v ┼┘└┘└┘└┘ └┘└┘└┘└              │
    │    0-1-2-3-4-5-6-7-8 (bit period)│    0-1-2-3-4-5-6-7-8 (bit period)│
    ┼─────────────────────────────────────────────────────────────────────┼
    │ Mirroring the line code vertically switches all the bits.           │
    ┼ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ┼
    │     0 0 0 0 0 0 0 0  (bit value) │ Vertically mirrored.             │
    │+5v ┼┐┌┐┌┐┌┐┌┐┌┐┌┐┌┐                                                 │
    │ 0v ┼└┘└┘└┘└┘└┘└┘└┘└              │      1 1 1 1 1 1 1 1  (bit value)│
    │    0-1-2-3-4-5-6-7-8 (bit period)  +5v ┼┌┐┌┐┌┐┌┐┌┐┌┐┌┐┌             │
    ┼ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─┤  0v ┼┘└┘└┘└┘└┘└┘└┘└┘             │
    │     1 1 1 1 1 1 1 1  (bit value)   +5v ┼┐┌┐┌┐┌┐┌┐┌┐┌┐┌┐             │
    │+5v ┼┌┐┌┐┌┐┌┐┌┐┌┐┌┐┌              │  0v ┼└┘└┘└┘└┘└┘└┘└┘└             │
    │ 0v ┼┘└┘└┘└┘└┘└┘└┘└┘                     0 0 0 0 0 0 0 0  (bit value)│
    │    0-1-2-3-4-5-6-7-8 (bit period)│     0-1-2-3-4-5-6-7-8(bit period)│
    ┼─────────────────────────────────────────────────────────────────────┴────────────────┼
    │+5v ┼┐ ┌─┐┌┐ ┌─┐┌┐┌┐┌┐ ┌─┐┌┐┌┐ ┌─┐ ┌─┐ ┌─┐┌┐ ┌┐┌─┐┌┐┌┐ ┌─┐┌┐ ┌┐┌─┐┌┐┌┐ ┌─┐┌┐ ┌┐┌┐┌┐┌  │
    │ 0v ┼└─┘ └┘└─┘ └┘└┘└┘└─┘ └┘└┘└─┘ └─┘ └─┘ └┘└─┘└┘ └┘└┘└─┘ └┘└─┘└┘ └┘└┘└─┘ └┘└─┘└┘└┘└┘  │
    │    │0 1 0 0 1 0 0 0│0 1 0 0 0 1 0 1│0 1 0 0 1 1 0 0│0 1 0 0 1 1 0 0│0 1 0 0 1 1 1 1│ │
    │    │ │ │ │ H │ │ │ │ │ │ │ E │ │ │ │ │ │ │ L │ │ │ │ │ │ │ L │ │ │ │ │ │ │ L │ │ │ │ │
    ┼────┼─┴─┴─┴─┴─┴─┴─┴─┼─┴─┴─┴─┴─┴─┴─┴─┼─┴─┴─┴─┴─┴─┴─┴─┼─┴─┴─┴─┴─┴─┴─┴─┼─┴─┴─┴─┴─┴─┴─┴─┼─┼
         │ 40 bit-periods                                                                  │

# Differential Manchester encoding
Uses transitions to determine bit value.
Differential means that the information is the the change of the signal.
    One change equals 1.
    Two changes equals 0.

    Transition symbol = '>'
    +----------------------------+
    | bitperiod (two transitions)|
    |   0s       0.5s       1s   |
    |   >--------->---------|    |
    +----------------------------+
A zero is represented by a transition in the beginning of the 
bitperiod and at the middle of the bitperiod, implying two 
changes.

    Every bitperiod has a transition in the middle.
    +----------------------------+
    | bitperiod (one transition) |
    |   0s       0.5s       1s   |
    |   |         >---------|    |
    +----------------------------+
A one is represented by a transition in the middle of the bitperiod,
implying one change.

# Compression
Reducing the number of bits that requires to represent data.

    Lossy compression - When decompressed, a approximation of the original 
    is given.

    Lossless - The exact copy of the pre-compressed data is made when it is
    decompressed.

Test - Can I reconstruct the exact data?
    Yes - Lossless
    No  - Lossy

Lossless may use a 'dictionary' to assign symbols to long repeating patterns.
