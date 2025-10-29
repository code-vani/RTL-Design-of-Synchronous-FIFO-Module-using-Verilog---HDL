# 🧠 RTL Design of Synchronous FIFO using Verilog HDL

## 📋 Abstract  
This project presents the RTL design and verification of a **Synchronous FIFO (First-In-First-Out)** buffer using **Verilog HDL**. The FIFO efficiently manages sequential data flow between two processes operating under the same clock domain. It is widely used in digital systems such as FPGAs, SoCs, and embedded applications to handle timing mismatches between producers and consumers. The design includes write/read pointer management, full/empty detection, and overflow/underflow protection. Simulation is performed using **Icarus Verilog** and visualized in **GTKWave**, validating correct functionality and timing behavior. This implementation provides a foundational understanding of synchronous memory elements in digital design and can be extended for deeper FIFO structures, asynchronous variants, or FPGA deployment.

---

## ⚙️ Design Overview  
The **Synchronous FIFO** stores data sequentially and outputs it in the same order. It synchronizes all operations using a single clock signal, ensuring data integrity during read and write operations.

### 🔧 Key Components  
1. **Memory Array (Dual-Port RAM)** – Stores FIFO data, enabling simultaneous read/write using one clock.  
2. **Write Logic** – Controls data writing using `wptr` and prevents overflow.  
3. **Read Logic** – Controls data reading using `rptr` and prevents underflow.  
4. **Full/Empty Flags** – Detect buffer status using pointer comparison.  
5. **Count Logic** – Tracks elements currently stored in FIFO.

---

## 🧾 Project Features  
✅ Parameterized depth & width  
✅ Overflow/underflow protection  
✅ Fully synchronous (single-clock domain)  
✅ Synthesizable RTL design  
✅ Verified with testbench simulation  

---

## 🧮 Parameters Used

| Parameter | Description | Default |
|------------|-------------|----------|
| `WIDTH` | Width of each data word | 8 bits |
| `DEPTH` | Number of entries | 8 |
| `UPP_TH` | Upper threshold (testing) | 6 |
| `LOW_TH` | Lower threshold (testing) | 2 |

---

## 🧰 Tools Used  
- **EDA Playground** (https://www.edaplayground.com/)  
- **Simulator:** Icarus Verilog 12.0  
- **Waveform Viewer:** GTKWave  

---

## 🚀 How to Simulate  
1. Open [EDA Playground](https://www.edaplayground.com/).  
2. Select **Icarus Verilog 12.0** as the simulator.  
3. Load `sync_fifo.v` (Design) and `tb_sync_fifo.v` (Testbench).  
4. Set **Top Module:** `tb_sync_fifo`.  
5. Run ▶️ simulation and view the waveform in EPWave/GTKWave.

---

## 📈 Waveform and Results  

| Signal | Description | Behavior |
|--------|--------------|-----------|
| `clk` | Clock signal | Synchronizes all FIFO operations |
| `reset` | Active-high reset | Clears all registers and flags |
| `w_enb` / `r_enb` | Write/Read enable | Controls data transfer |
| `din` / `dout` | Data input/output | Sequential data flow |
| `full` / `empty` | Status flags | Indicate buffer state |
| `wptr`, `rptr` | Pointers | Increment cyclically |
| `count` | Counter | Tracks FIFO occupancy |

### 🖼 Simulation Output  
<img width="1299" height="285" src="https://github.com/user-attachments/assets/67a98dc1-c5e8-40ef-a5e2-760cc1ef98d6" alt="Synchronous FIFO waveform"/>

**Waveform Summary:**  
- During reset, pointers and count reset to zero.  
- Data writes increment `count` and toggle `full` when full.  
- Reads decrement `count` and assert `empty` when drained.  
- No data corruption or timing mismatch observed.

---

## 🧩 Applications  
- Buffering in **network routers and switches**  
- **SoC inter-module** communication  
- **UART**, SPI, and serial interfaces  
- Real-time **DSP pipelines**

---

## ✅ Conclusion  
The project successfully demonstrates a **fully functional synchronous FIFO** at the RTL level using Verilog HDL. Simulation confirms accurate read/write synchronization, data integrity, and flag operation. This design can be scaled for higher depth, integrated into **larger SoC systems**, or extended into **asynchronous FIFO architectures** for cross-clock data transfer.

---

## 👩‍💻 Contributors  

| Name | Email |
|------|--------|
| Vanshika Garg | vanshikagarg.20744@gmail.com |
| Vangara Sravanthi | o210018@rguktong.ac.in |
| Vidushi Bahuguna | to.vidushibahuguna@gmail.com |
| Vutukuri Poojitha | reddypoojitha356@gmail.com |
| Yesilanka Veera Sai Sindhu | yesilankasindhu@gmail.com |

---

## 🕒 Batch Details  
**Batch:** NXP WIT Batch 3  
**Date:** 28 October, 2025  
**Project Title:** RTL Design of Synchronous FIFO Module using Verilog HDL  
