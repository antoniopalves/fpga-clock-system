# FPGA Clock System (Core IP)

This project implements a fully functional digital clock system on an FPGA using VHDL and Xilinx ISE. It includes real-time clock functionality with additional modes such as Alarm, Timer, and Stopwatch, each controllable via physical switches and buttons with debouncing logic.

## Features

- **Clock Display Modes**: HH:MM and MM:SS
- **Alarm**: Alerts when clock time matches set alarm time (LED ON)
- **Timer**: Countdown timer with visual feedback (LED ON while active)
- **Stopwatch**: Counts time in SS:msms format
- **Editing**: Change time values with increment buttons and mode selectors
- **Debouncer**: Eliminates bounce from physical buttons
- **Asynchronous Reset**: System-wide reset for all modules

## Project Structure

```
P1/
├── 4/                          # Possibly simulation data or test folders
├── 6/                          # Additional internal folders
├── VHDL Files/                # All VHDL source code organized by modules
│   ├── CoreIP/
│   ├── Debouncer/
│   ├── Display/
│   └── StateMachines/
├── Especificações Core IP.pdf         # Core module documentation
├── Especificações Debouncer.pdf       # Debouncer documentation
├── Relatório Trabalho 1 - CSD.pdf     # Final report with diagrams and tests
├── .gitignore
└── README.md
```

## How to Use

1. **Open Xilinx ISE** and create a new project.
2. Import all files from `VHDL Files/`.
3. Set the top-level module (likely `principal.vhdl` or similar).
4. Connect FPGA I/Os according to the switch/button/display/LED definitions in the specs.
5. Synthesize, implement, and upload to your FPGA board.

## Authors

- Guilherme Conha – Nº 60143  
- Pedro Peres – Nº 60495  
- António Alves – Nº 58339  

**Institution:** Departamento de Engenharia Eletrotécnica e de Computadores  
**Course:** Circuitos e Sistemas Digitais – 2023/2024 – 1º Semestre  
**Class:** P1
