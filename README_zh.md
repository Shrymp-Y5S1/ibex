# Ibex RISC-V 处理器核心

## 概述

Ibex 是一个**生产级、开源的 32 位 RISC-V CPU 核心**，由 [lowRISC](https://www.lowrisc.org) 维护，采用 SystemVerilog 编写。它最初由 ETH Zurich 和博洛尼亚大学的 PULP 团队以 "Zero-riscy" 名义开发，于 2018 年 12 月贡献给 lowRISC。

Ibex 是 [OpenTitan](https://opentitan.org) 项目的重要组成部分，广泛应用于安全芯片和嵌入式系统中。

## 核心特性

- **RISC-V 32 位架构**：支持 RV32I/E 基础整数指令集
- **流水线**：2 级或 3 级流水线可配置
- **丰富的 ISA 扩展支持**：
  - **M** — 乘除法扩展（4 种实现：无 / 慢速 / 快速 / 单周期）
  - **C / Zc\*** — 压缩指令扩展
  - **B** — 位操作扩展（可选：无 / 平衡 / 完整）
- **可配置的物理内存保护（PMP）**：最多 16 个区域，粒度可调
- **指令缓存（ICache）**：可选，支持 ECC 校验和数据加扰
- **安全特性**：锁步（lockstep）比较、虚拟指令注入（抗侧信道）、数据无关时序
- **调试支持**：触发模块（trigger module）
- **性能计数器**：可配置数量（最多 10 个）

## 预定义配置

| 配置名称 | 特性 | 验证状态 |
|---|---|---|
| `small` | RV32EC, 2 级流水, 3 周期乘法 | 已验证 |
| `opentitan` | RV32IMC, 单周期乘法, ICache(ECC+加扰), 16 PMP, 安全特性 | 已充分验证 |
| `maxperf` | RV32IMC, 3 级流水, 单周期乘法 | 已充分验证 |
| `maxperf-pmp-bmbalanced` | maxperf + PMP + 位操作 | 已充分验证 |
| `experimental-branch-predictor` | 含分支预测器 | 实验性 |

## 目录结构

```
ibex/
├── rtl/                  # RTL 源代码（31个 SystemVerilog 文件）
│   ├── ibex_core.sv      # 核心顶层模块
│   ├── ibex_top.sv       # 封装顶层（含寄存器文件选择、锁步）
│   ├── ibex_pkg.sv       # 头文件包（枚举、参数、结构体）
│   ├── ibex_if_stage.sv  # 取指阶段
│   ├── ibex_id_stage.sv  # 译码阶段
│   ├── ibex_ex_block.sv  # 执行模块（ALU、乘法器、除法器、分支、LSU）
│   ├── ibex_wb_stage.sv  # 写回阶段
│   ├── ibex_decoder.sv   # 指令译码器
│   ├── ibex_controller.sv # 流水线控制器
│   ├── ibex_alu.sv       # 算术逻辑单元
│   ├── ibex_load_store_unit.sv  # 访存单元
│   ├── ibex_cs_registers.sv     # 控制与状态寄存器
│   ├── ibex_pmp.sv       # 物理内存保护
│   ├── ibex_icache.sv    # 指令缓存
│   ├── ibex_multdiv_fast.sv     # 快速乘除法器
│   ├── ibex_multdiv_slow.sv     # 慢速乘除法器（面积更小）
│   ├── ibex_branch_predict.sv   # 分支预测器（实验性）
│   ├── ibex_register_file_ff.sv    # 触发器寄存器文件
│   ├── ibex_register_file_fpga.sv  # FPGA 优化寄存器文件
│   ├── ibex_register_file_latch.sv # 锁存器寄存器文件（ASIC）
│   ├── ibex_lockstep.sv      # 锁步比较器
│   ├── ibex_dummy_instr.sv   # 虚拟指令注入
│   └── ibex_tracer.sv        # 指令追踪器
│
├── dv/                   # 设计验证
│   ├── formal/           # 端到端形式化验证（与 Sail 规范等价性证明）
│   ├── uvm/              # UVM 动态验证（含受约束随机测试）
│   ├── cosim/            # 与 Spike 联合仿真框架
│   ├── cs_registers/     # CSR 寄存器测试平台
│   ├── riscv_compliance/ # RISC-V 合规性测试
│   └── verilator/        # Verilator 性能计数器与联合仿真
│
├── formal/               # 独立形式化属性（数据无关时序、ICache 断言）
├── syn/                  # 综合流程（Yosys + OpenSTA 脚本、SDC 约束）
├── examples/             # 示例系统与测试程序
│   ├── simple_system/    # 最小 Ibex 系统（Verilator 仿真）
│   └── sw/               # 软件示例（hello_test、CoreMark 基准测试等）
│
├── doc/                  # Sphinx 文档（概述、用户指南、参考、开发者指南）
├── util/                 # 工具脚本（配置解析、工具检查、sv2v 转换）
├── shared/               # lowRISC 公共 IP（总线、RAM、时钟生成、定时器）
├── vendor/               # 第三方依赖（CoreMark、riscv-dv、Spike、架构测试等）
├── ci/                   # CI 辅助脚本
├── lint/                 # 代码检查豁免文件（Verilator、Verible）
├── .github/              # GitHub Actions CI 工作流与 Issue 模板
│
├── ibex_configs.yaml     # 所有预定义 CPU 配置
├── *.core                # FuseSoC 核心描述文件
├── Makefile              # 顶层构建便捷目标
├── flake.nix             # Nix 可复现开发环境
└── README.md             # 英文原始说明
```

## 主要功能模块说明

### 流水线架构

Ibex 采用 2 级（取指 → 译码/执行/写回）或 3 级（取指 → 译码+执行 → 写回）流水线设计，可根据性能与面积需求灵活选择。

### 取指阶段（IF Stage）

- 预取缓冲区（prefetch buffer）
- 取指 FIFO
- 指令缓存（可选，支持 ECC 和加扰）
- 分支预测器（实验性，静态预测）

### 译码与执行

- **译码器**：支持 RV32I/E 全指令 + C/Zc 压缩指令译码
- **ALU**：完整整数算术逻辑运算
- **乘除法器**：快速（单周期）或慢速（多周期）两种实现
- **访存单元**：支持字节/半字/字读写
- **分支处理**：带分支目标 ALU

### 控制与状态寄存器（CSR）

全面支持 RISC-V 特权架构规定的机器模式 CSR，包括：
- 异常与中断控制（mstatus, mie, mip, mtvec 等）
- 性能监视计数器（mcycle, minstret 等）
- 物理内存保护（PMP）配置寄存器
- 调试触发寄存器

### 物理内存保护（PMP）

- 可配置区域数量（最多 16 个）
- 可配置粒度（最小 256 字节）  
- 支持 NA4 / NAPOT 地址匹配模式
- 读写执行权限控制

### 安全特性

- **锁步模式**：两个 Ibex 核心并行运行，比较输出结果，检测硬件故障
- **虚拟指令注入**：随机插入虚拟指令，掩盖真实执行特征（抗差分功耗分析）
- **数据无关时序**：乘法/除法操作耗时与操作数无关（抗时序侧信道）

## 验证体系

Ibex 拥有业界领先的多层次验证体系：

1. **形式化验证**：使用 Sail RISC-V 规范模型，通过 Cadence Jasper 或 Yosys + rIC3 证明 Ibex 与规范的等价性（近 1000 条属性/不变量）
2. **UVM 动态验证**：完整的 UVM 测试平台，含记分板、功能覆盖率收集、受约束随机指令序列生成（基于 Google riscv-dv）
3. **Spike 联合仿真**：每条退休指令与 Spike ISA 仿真器交叉校验
4. **RISC-V 合规性测试**：通过官方 RISC-V 架构测试套件
5. **CSR 专项测试**：基于 C++ DPI 的 CSR 寄存器模型检查

## 构建系统

**主要构建工具**：[FuseSoC](https://github.com/olofk/fusesoc)

```bash
# 仿真构建（Verilator）
fusesoc --cores-root=. run --target=sim --setup --build lowrisc:ibex:ibex_top

# 语法检查
fusesoc --cores-root=. run --target=lint lowrisc:ibex:ibex_top

# 指定配置
fusesoc --cores-root=. run --target=sim --setup --build \
  lowrisc:ibex:ibex_top --RV32E=0 --RV32M=ibex_pkg::RV32MFast
```

**可复现环境**：支持 Nix flake 开发环境

## 示例系统

`examples/simple_system/` 提供了一个最小的 Ibex 系统，包含：
- Ibex CPU 核心
- 统一指令/数据存储器
- 串行输出外设
- 定时器外设
- 仿真器停机寄存器

可直接加载 ELF 或 vmem 格式的二进制文件进行 Verilator 仿真。

## 硬件实现适配

目录中的综合脚本和约束文件表明，此 Ibex 副本已考虑 FPGA 硬件实现路径（Yosys 综合 + SDC 时序约束），可作为 FPGA 故障注入项目的嵌入式处理器 IP 使用。

## 许可证

Apache License 2.0

## 上游项目

- 仓库地址：[https://github.com/lowRISC/ibex](https://github.com/lowRISC/ibex)
- 文档地址：[https://ibex-core.readthedocs.io](https://ibex-core.readthedocs.io/en/latest/)
- 维护组织：[lowRISC](https://www.lowrisc.org)
