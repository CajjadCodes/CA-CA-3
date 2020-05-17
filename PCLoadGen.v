module PCLoadGen(PCWrite, PCWriteCondBeq, PCWriteCondBne, zero, PCLoad);
input PCWrite;
input PCWriteCondBeq; 
input PCWriteCondBne; 
input zero;
output PCLoad;
	
	assign PCLoad = PCWrite | (zero & PCWriteCondBeq) | (~zero & PCWriteCondBne); 	

endmodule
