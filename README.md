# 🧠 RTL Design of Synchronous FIFO using Verilog HDL

## 📋 Overview
This project implements a **Synchronous FIFO (First-In-First-Out)** memory buffer using **Verilog HDL** at the **RTL (Register Transfer Level)**.  
The FIFO operates in a **single clock domain**, ensuring synchronized read and write operations. It efficiently manages data transfer between producer and consumer processes — crucial in SoC, FPGA, and embedded systems.


### 🧩 Project Structure

```
sync_fifo_project/
│
├── src/
│   └── sync_fifo.v              # FIFO design module
│
├── testbench/
│   └── tb_sync_fifo.v           # Testbench for simulation
│
├── simulation/
│   ├── dump.vcd                 # Waveform file (auto-generated after simulation)
│   └── waveform.png             # Screenshot of simulation waveform (GTKWave)
│
└── README.md                    # Project documentation
```

## ⚙️ Design Description

### 1️⃣ Memory Array (Dual-Port RAM)
Stores data written into the FIFO. Both read and write operations occur simultaneously using the same clock signal.

### 2️⃣ Write Control Logic
- Controls the **write pointer (`wptr`)**.  
- Prevents writing when the FIFO is **full**.  
- Data is written only when `w_enb = 1` and `full = 0`.

### 3️⃣ Read Control Logic
- Controls the **read pointer (`rptr`)**.  
- Prevents reading when the FIFO is **empty**.  
- Data is read only when `r_enb = 1` and `empty = 0`.

### 4️⃣ Full / Empty Detection Logic
- Compares the `wptr` and `rptr` to determine FIFO state.
- Generates `full` and `empty` flags to prevent overflow and underflow.

### 5️⃣ Count Logic
- Keeps track of the number of elements in the FIFO.
- Used for debugging and status monitoring.

## 🧾 Key Features

✅ Parameterized FIFO (depth and width can be modified easily)  
✅ Handles full and empty conditions correctly  
✅ Overflow and underflow protection  
✅ Single-clock synchronous design  
✅ Fully synthesizable and testbench verified  

## 🧮 Parameters Used

| **Parameter** | **Description** | **Default Value** |
|----------------|-----------------|------------------|
| `WIDTH` | Width of each data word | 8 bits |
| `DEPTH` | Number of data words | 8 |
| `UPP_TH` | Upper threshold (for testing) | 6 |
| `LOW_TH` | Lower threshold (for testing) | 2 |


## 🧰 Tools Used

- **EDA Playground** (https://www.edaplayground.com/)  
- **Simulator:** Icarus Verilog 12.0  
- **Waveform Viewer:** GTKWave  


## 🚀 How to Run the Simulation

1. Open [EDA Playground](https://www.edaplayground.com/).  
2. Select:
   - **Tools → Icarus Verilog 12.0**
   - **Top module name:** `tb_sync_fifo`
3. Paste:
   - FIFO code (`sync_fifo.v`) in the **left panel**
   - Testbench (`tb_sync_fifo.v`) in the **right panel**
4. Enable ✅ **“Open EPWave after run”**
5. Click **Run** ▶️

After simulation:
- The waveform (`dump.vcd`) will auto-generate.
- You can visualize it in **GTKWave** or **EPWave**.

## 📈 Waveform Explanation

Below is the waveform generated from the simulation:

🖼 <img width="1299" height="285" alt="image" src="https://github.com/user-attachments/assets/67a98dc1-c5e8-40ef-a5e2-760cc1ef98d6" />


### 🕒 Explanation of Key Signals

| **Signal** | **Description** | **Waveform Behavior** |
|-------------|------------------|------------------------|
| `clk` | Clock signal | Periodic square wave controlling all operations |
| `reset` | Active-high reset | Initializes FIFO (clears pointers, flags) |
| `w_enb` | Write enable | When high, data (`din`) is written into FIFO |
| `r_enb` | Read enable | When high, data is read from FIFO to `dout` |
| `din` | Data input | Input values pushed into FIFO |
| `dout` | Data output | Output values read from FIFO in the same order |
| `full` | Full flag | Goes high when FIFO reaches capacity |
| `empty` | Empty flag | Goes high when FIFO has no data |
| `wptr`, `rptr` | Write and read pointers | Move cyclically as data is written/read |
| `count` | Number of elements in FIFO | Increases on write, decreases on read |

## 🧠 Interpretation of the Waveform

1. **Reset Phase (Initial cycles)**  
   - `reset = 1` clears FIFO; all signals (`wptr`, `rptr`, `count`) → `0`.

2. **Write Phase**  
   - `w_enb = 1`, data written to FIFO.  
   - `count` increments; `full` goes high when FIFO reaches max capacity.

3. **Read Phase**  
   - `r_enb = 1`, data is read in FIFO order.  
   - `count` decrements; `empty` goes high when all data is read.

4. **Idle Phase**  
   - No read/write; FIFO retains data.


## 🧩 Applications

- Packet buffering in **network routers**
- Data flow control in **DSP/video pipelines**
- Buffers in **UARTs and serial communication**
- **Inter-module communication** in SoCs and FPGAs

## 🧾 Expected Outcomes

✅ Verified **synchronous FIFO module** with correct functionality  
✅ **Synthesizable RTL design** meeting timing and logic requirements  
✅ **Waveform validation** showing proper data flow and status flag behavior  
✅ Ready for **FPGA/SoC integration**

## 👩‍💻 Contributors

| **Name** | **Email** |
|-----------|-----------|
| Vanshika Garg | vanshikagarg.20744@gmail.com |
| Vangara Sravanthi | o210018@rguktong.ac.in |
| Vidushi Bahuguna | to.vidushibahuguna@gmail.com |
| Vutukuri Poojitha | reddypoojitha356@gmail.com |
| Yesilanka Veera Sai | yesilankasindhu@gmail.com |

## 🕒 Batch Details

**Batch Name:** NXP WIT Batch 3  
**Submission Date:** 28 October, 2025  
**Project Title:** RTL Design of Synchronous FIFO Module using Verilog HDL
