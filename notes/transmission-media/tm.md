# Transmission media - Chapter 7
This chapter gives a taxonomy of different transimission media for
datacommunication.

    Examples.
        - wired propagation.
        - wireless propagation.
        - propataion of optical media.

Question to keep in mind when reading.
    What must a communication system do so that the receiver still 
    can distinguish the information that has been sent.

    First thing to pop in mind.
        - Shield the information from disturbances.
            - Use suitable transmission medium.
        - Propagate to the correct receiver.
        - Propagate the info efficiently.

    Suitable transmission media.
        - Guided transmission media.
            - Copper wire 
            - Optical cable

        - Unguided transmission media.
            - Electromagnetic waves (radio)
            - Free space laser or infrared light diodes.
                Unguided media can still be highly directional.
                A laser beam is such an example.

Terminology
- Atenuation.
    The signal becomes weaker.

- Noise or interference.
    Unwanted disturbances become mixed with the signal.

- Distortion.
    The waveform changes shape.
    One cause is that different components experience different 
    atenuation or delays.

# Taxonomy
                      +---------------+
                      | Enerrgy types |
              +-------+---------------+--------+
              |               |                |           
              |               |                |           
      +------------+      +-------+           +-----------------+
    +-| Electrical |    +-| Light |         +-| Electromagnetic |
    | +------------+    | +-------+         | +-----------------+
    | +--------------+  | +---------------+ |  +-------------------+                            
    |_| Twisted pair |  |_| Optical fibre | |__| Terrestrial radio |   
    | +--------------+  | +---------------+ |  +-------------------+   
    | +---------------+ | +----------+      |  +-----------+           
    |_| Coaxial cable | |_| infrared |      |__| Satellite |           
      +---------------+ | +----------+         +-----------+           
                        | +-------+                                   
                        |_| laser |              
                          +-------+              

# Background radiation and Electrical noise
Random electromagnetic noise can create disturbances for digital signals.
That noise can add unintended signals. Shielding is needed.

Sources of disturbances.
    - Electric motors.
    - Flourescent light bulbs.

## Twisted pair copper wiring
Shielded and unshielded twised pair wiring is used extensively 
in communications.

Keeping two wires paralell gives one wire more readiation than the 
other, due to one being in proximity to the source of disturbance.
Twisting them puts them on average at the same distance to the 
disturbance.

This method is not a solution for all disturbances.
    - Very strong electrical noise.
    - Close proximity to source of disturbance.
    - High frequencies used for communication.

The solution is SHIELDING!

## Coaxial cable and shielded twisted pair (STP)
### Coaxial cable
Cable television wires (coaxial cables) have metal shielding.
This prevents outside disturbances from affecting the signal 
in the center wire. It also inhibits the central wire from 
causing disturbances to other wires nearby.

The downside is that the shielding makes the wire less flexible.

### Shielded Twisted Pair (SWP)
The solution is Shielded Twisted Pair (SWP)

| Category | Specified bandwidth | Example Ethernet data rate | Distance |
|---|---:|---:|---:|
| Cat5e | 100 MHz | 1,000 Mbit/s | 100 m |
| Cat6 | 250 MHz | 10,000 Mbit/s | Up to 55 m* |
| Cat6A | 500 MHz | 10,000 Mbit/s | 100 m |
| Cat7 | 600 MHz | 10,000 Mbit/s | 100 m |
| Cat7A | 1,000 MHz | 10,000 Mbit/s | 100 m |
| Cat8 | 2,000 MHz | 25,000 or 40,000 Mbit/s | 30 m |

# Optical fibers
Optical fibers are one directional. Each one has to have a light 
emitter at one end, and a light sensitive receiver at the other.
Therefore two fibres are used for each communicating node.

A fiber cables downside is that it can not be bent to far.
    - It will break.
    - The light does not bend with the cable if bent too far.
It can not be bent beyond a a circle with a radius of two inches.

Light looses energy when reflecting against the cladding surrounding 
the wire. Therefore light can be dispersed and lose the symbol that 
the signal was intended to carry.

## Three types if fiber cables exist
- Multimode, step index fiber.
    - Abrupt boundary between fiber and cladding.
    - Cheapest, high dispersion.

- Multimode, graded index fiber.
    - Slightly more expensive.
    - Fiber density is higher near the edge.
      Reduces reflection and dispersion

- Single mode fiber.
    - The most expensive option.
    - Used for longer distances and higher bit rates.
    - Has a smaller diameter, which inherently reduces reflection 
      and dispersion.

Emitters and receivers need to match the type of cable.
    - Cheaper devices.
        - LED emitters.
        - Photo-sensitive cells receiver.

    - Expensive.
        - Injection Laser Diode (ILD) emitter.
        - Photodiode receiver.

## Comparison between copper and fiber wires

    - Optical wire
        * Immune to electrical noise.
        * Less signal attenuation (degradation).
        * Higher bandwidth.

    - Copper wiring
        * Lower overall cost
        * Less bound to specialist knowledge.
        * More durable.
