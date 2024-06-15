`include "P_C.v"
`include "Instruction_Memory.v"
`include "Register_File.v"
`include "Sign_Extend.v"
`include "ALU.v"
`include "Control_unit_Top.v"
`include "Data_memory.v"
`include "PC_ADDer.v"

module Single_Cycle_Top(clk ,rst);

input ckl , rst ;

wire [31:0] PC_Top , RD_Instr , RD1_Top ,Imm_Ext_Top , ALu_Control_TOp , ALu_Result , ReadData , PCPlus4;
wire [7:0] RegWrite;


P_C pc(
    .clk(clk),
    .rst(rst),
    .PC(PC_Top),
    .PC_NEXT(PCPlus4)
);

Instr_Mem Instr_Mem(
    .rst(rst),
    .A(PC_Top),
    .RD(RD_Instr)
);

Register_File  Register_File(
    .clk(clk),
    .rst(rst),
    .WE3(RegWrite),
    .WD3(ReadData),
    .A1(RD_Instr[19:15]),
    .A2(),
    A3(RD_Instr[11:7]),
    RD1(RD1_Top),
    RD2()
);

Sign_Extend Sign_Extend(
    .In(RD_Instr),
    .Imm_Ext(Imm_Ext_Top)
);

ALU ALU(
    .A(RD1_Top) , 
    .B(Imm_Ext_Top) , 
    .ALUControl(ALu_Control_TOp) ,
    .Result(ALu_Result) , 
    .Z() , 
    .N() , 
    .V() , 
    .C()
);

Control_unit_Top Control_unit_Top(
    .Op(RD_Instr[6:0]) , 
    .RegWrite(RegWrite) ,
    .ImmSrc() , 
    .ALUSrc() , 
    .MemoWrite() , 
    .ResultSrc() , 
    .branch() , 
    .funct3(RD_Instr[14:12]) , 
    .funct7() , 
    .ALUControl(ALu_Control_TOp)
);


Data_Memory Data_Memory(
    .A(ALu_Result) , 
    .WD() , 
    .clk(clk) , 
    .WE() , 
    .RD(ReadData)

);

PC_adder PC_adder(
    .a(PC),
    .b(32'd4),
    .c(PCPlus4)
);


endmodule