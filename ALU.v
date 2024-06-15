module alu(A , B , ALUControl , Result , Z , N , V , C);
//declare input
//RV32I RISC_V
input [31:0] A ,B;
input [2:0] ALUControl;
//output declaration

output [31:0] Result;
output Z , N , V , C ;
//declare intermediate wire

wire [31:0] a_and_b;
wire [31:0] a_or_b;
wire [31:0] not_b;
wire [31:0] mux_1;
wire [31:0] sum;
wire [31:0] mux_2;
wire cout;
wire [31:0] slt;
//logic design
//And operation
assign a_and_b = A & B;
//or operation
assign a_or_b = A | B;
//not operation
assign not_b =~B;

//Ternary oprator
assign mux_1=(ALUControl[0]==1'b0) ?B : not_b;
//addition and substraction
assign {cout ,sum} =A+mux_1+ALUControl[0];
//assign extension
assign slt = {31'b0000000000000000000000000000000,sum[31]}
//desin 4by 1 mux
assign mux_2=(ALUControl[2:0]==3'b000)?sum :
               (ALUControl[2:0]==2'b001) ? sum : 
               (ALUControl[2:0]==2'b010) ? a_and_b : 
                (ALUControl[2:0]==2'b011) ? a_or_b :
                 (ALUControl[2:0]==2'b100) ? slt: 32'h000000000;


assign Result =mux_2;

//Assign flag

assign Z = &(~Result);//aero flag
assign N=Result[31];//negative flag 

assign C=cout & (~ALUControl);//carry flag
assign V= (~ALUControl[1]) & (A[31] ^ sum[31]) & (~(A[31]^B[31] ^ ALUControl[0]));//Overflow flag

endmodule