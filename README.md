# Password-Protected Digital Calculator on FPGA (Basys-3)

This project implements a password-protected digital calculator on a Xilinx FPGA using Verilog HDL and the Vivado design suite. The system ensures that arithmetic operations can only be performed after entering a correct password sequence through push buttons. The design demonstrates the use of finite state machines (FSM), modular hardware design, and clock division on an FPGA platform.

The calculator remains locked initially. A predefined password sequence must be entered using push buttons on the FPGA board. The correct sequence is S3 → S1 → S2, which corresponds to pressing btnR, then btnU, and finally btnL on the Basys-3 board. If the correct sequence is entered, the calculator unlocks and an LED indicates that the system is active. If any incorrect button is pressed during the sequence, the system enters an error state and an error LED turns on.

Once unlocked, the calculator accepts two operands through the switches available on the board. The first operand is taken from switches sw[3:0] and the second operand from switches sw[7:4]. The operation mode is selected using switches sw[9:8]. When the mode is set to 01, the system performs addition of the two operands. When the mode is set to 10, multiplication is performed. If the mode is set to 00 or 11, the operation is considered invalid and a dedicated LED blinks to indicate an invalid operation.

The blinking of the invalid operation LED is implemented using a clock divider module. Since the Basys-3 board provides a 100 MHz system clock, a counter-based clock divider is used to generate a slower clock signal that produces a blinking frequency of approximately 2 Hz. This demonstrates the use of clock management techniques commonly used in FPGA designs.

The design follows a modular structure consisting of multiple Verilog modules. The top-level module connects all submodules and interfaces them with the FPGA board inputs and outputs. A finite state machine module handles the password checking and state transitions between idle, intermediate password states, unlock state, and error state. An arithmetic module performs the selected operation when the calculator is unlocked. A clock divider module generates a slow clock for LED blinking, and a blink generator module controls the invalid operation LED behavior.

The project is implemented and tested on the Basys-3 FPGA development board using the Vivado design environment. The design is synthesized, implemented, and programmed onto the FPGA to verify the correct operation of password protection, arithmetic computation, and LED status indications.

Hardware used in this project includes the Basys-3 FPGA development board based on the Xilinx Artix-7 FPGA. The design is written in Verilog HDL and synthesized using the Xilinx Vivado toolchain.

The switch and LED mapping on the board is as follows. Switches sw[3:0] represent the first operand and switches sw[7:4] represent the second operand. Switches sw[9:8] select the arithmetic operation. The push buttons btnR, btnU, and btnL are used to enter the password sequence, while btnC resets the system. LED[0] indicates that the calculator is active after successful authentication, LED[1] indicates an error due to incorrect password entry, LED[2] blinks when an invalid operation mode is selected, and LEDs LED[10:3] display the arithmetic result in binary form.

This project demonstrates practical FPGA design concepts including FSM design, digital arithmetic implementation, clock division, and hardware interfacing using switches and LEDs. It also illustrates how security features such as password protection can be integrated into digital hardware systems.
