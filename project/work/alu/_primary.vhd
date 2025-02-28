library verilog;
use verilog.vl_types.all;
entity alu is
    port(
        A               : in     vl_logic_vector(31 downto 0);
        B               : in     vl_logic_vector(31 downto 0);
        ALUOp           : in     vl_logic_vector(4 downto 0);
        C               : out    vl_logic_vector(31 downto 0);
        Zero            : out    vl_logic
    );
end alu;
