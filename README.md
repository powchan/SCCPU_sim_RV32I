# SCCPU_SIM_RISCV32
基于RISCV32的单周期CPU设计，使用Verilog语言。
## 工程架构
### source
这里存放着所有必须的源代码和测试文件，但实际上程序并不靠这里的代码运行。
### project
工程的核心文件夹。储存着所有必须的源代码、测试文件、工程文件以及编译后的项目文件。

## 如何测试
使用Modelsim仿真。首先在`./project/rv32_sc_sim.dat`中写入16进制的RISCV32机器码，这可以通过Rars工具进行汇编得到。你的项目也可能提供了类似的`.dat`文件，你可以将其中的内容复制粘贴过来。  
仿真之后，你可以通过`view->Memory List`选项来查看寄存器和内存的值。其中：
1. `rf`是各个寄存器的值。
2. `dmem`是存储数据的内存的值(即`.data`段)
3. `RAM`是存储代码的内存的值(即`.text`段)

你可以通过`右键->Properties`将数据显示为16进制格式。  
得到数据之后，你可以在Rars中运行相应的汇编代码并比对结果。   
在`./Test_30_Instr.asm`中是我们用于测试的汇编代码，`./project/rv32_sc_sim.dat`已经写好了相应的16进制码。当你用Rars运行我们的程序时，应该注意勾选`Setting->Self-modifying code`，并且通过`Setting->Memory Configuration`设置`Text address at 0`。