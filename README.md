# FPGA Clock System (Core IP)

This project implements a complete multi-functional **digital clock system** on an FPGA, developed using **VHDL** and **Xilinx ISE**. It supports real-time timekeeping along with alarm, timer, and stopwatch functionalities — all accessible via switches and buttons. The design includes user interaction handling through a debouncing module and outputs to a 4-digit 7-segment display.

---

## 🧠 Features Overview

- 🕒 **Clock Modes (HH:MM / MM:SS)**  
  Real-time clock operation with switchable display formats.

- ⏰ **Alarm Mode**  
  Triggers an LED when the system time matches a preset alarm time. Alarm time is editable.

- ⏳ **Timer Mode (MM:SS)**  
  Configurable countdown timer with LED indication while active. Stops at 00:00.

- ⌚ **Stopwatch Mode (SS:msms)**  
  Millisecond-precision stopwatch with start/stop/reset control.

- ✍️ **Edit Mode**  
  Any mode with a time value (Clock, Alarm, Timer) can be edited:
  - Select seconds, minutes, or hours with `buttonMODE`.
  - Increment the selected unit with `buttonINC`.

- 🔁 **Mode Selection**  
  Navigate between Clock → Alarm → Timer → Stopwatch using `buttonTYPEMODE`.

- 🧼 **Debouncer**  
  Ensures clean signal pulses from mechanical button presses.

- 🔃 **Asynchronous Reset**  
  Resets all internal state machines and counters instantly.

---

## 🧩 System Architecture

The system is composed of multiple modular VHDL components:

### Core Modules (`VHDL Files/`)
- **`principal.vhdl`** – Top-level module, instantiates and connects all subsystems.
- **`relogio.vhdl`** – Core clock logic with editing support.
- **`alarm.vhdl`** – Holds target alarm time and LED logic.
- **`timer.vhdl`** – Implements a countdown timer that starts/stops.
- **`stopwatch.vhdl`** – Free-running stopwatch with millisecond accuracy.
- **`conv_displays.vhdl`** – Converts time digits to drive the 7-segment display.
- **`Mode_State_Machine.vhdl`** – FSM to handle Clock/Alarm/Timer/Stopwatch switching.
- **`State_machine.vhdl`** – FSM to manage edit mode (hours/minutes/seconds) and target module.

### Input Handling
- **`Debouncer.vhdl`** – Filters mechanical bounce from all push buttons.

---

## ⚙️ Input/Output Interface

### 🧾 Inputs (Switches/Buttons)
| Name             | Function                                 |
|------------------|------------------------------------------|
| `clk`            | Global system clock                      |
| `reset`          | Asynchronous reset                       |
| `switch1`        | Toggle display mode (HH:MM or MM:SS)     |
| `switchEDIT`     | Enable editing mode for Clock            |
| `switchALARM`    | Enable editing mode for Alarm            |
| `switchTIMER`    | Enable editing mode for Timer            |
| `switchStopWatch`| Pause/Resume Stopwatch                   |
| `buttonMODE`     | Select unit to edit (sec/min/hour)       |
| `buttonINC`      | Increment selected unit                  |
| `buttonTYPEMODE` | Change functional mode                   |

### 💡 Outputs
| Name         | Function                                            |
|--------------|-----------------------------------------------------|
| `LED_Alarm`  | Lights up when alarm triggers                       |
| `LED_Timer`  | Lights up while countdown timer is active           |
| `algarismo`  | Encoded value to display on 7-segment driver        |
| `an0-3`      | Digit activation for each display segment           |

---

## 📁 Project Structure
P1/
├── 4/ # (Optional) Simulation or test results

├── 6/ # (Optional) Project folders

├── VHDL Files/ # All source code (.vhdl)

│ ├── CoreIP/

│ ├── Debouncer/

│ ├── Display/

│ └── StateMachines/

├── Especificações Core IP.pdf # Clock system specifications

├── Especificações Debouncer.pdf # Debouncer specs

├── Relatório Trabalho 1 - CSD.pdf # Final technical report

├── .gitignore

└── README.md
---

## 🚀 Getting Started

1. **Open Xilinx ISE** and create a new project.
2. Add all `.vhdl` files from the `VHDL Files/` folder.
3. Set `principal.vhdl` as the top-level module.
4. Assign pins for switches, buttons, LEDs, and 7-segment display.
5. Synthesize, implement, and upload to your FPGA board (e.g., Basys 3).

---

## 🧪 Testing

The design was tested via simulation and real FPGA implementation. Each feature — Clock, Alarm, Timer, Stopwatch, FSMs, and Debouncer — was validated for correctness. Refer to **`Relatório Trabalho 1 - CSD.pdf`** for waveform evidence and test methodology.

---

## 👨‍💻 Authors

- **Guilherme Concha** – Nº 60143  
- **Pedro Peres** – Nº 60495  
- **António Alves** – Nº 58339  

**Institution:** Departamento de Engenharia Eletrotécnica e de Computadores  
**Course:** Circuitos e Sistemas Digitais – 2023/2024 – 1º Semestre  
**Class:** P1

---

