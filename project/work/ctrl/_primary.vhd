library verilog;
use verilog.vl_types.all;
entity ctrl is
    port(
        Op              : in     vl_logic_vector(6 downto 0);
        Funct7          : in     vl_logic_vector(6 downto 0);
        Funct3          : in     vl_logic_vector(2 downto 0);
        Zero            : in     vl_logic;
        RegWrite        : out    vl_logic;
        MemWrite        : out    vl_logic;
        EXTOp           : out    vl_logic_vector(5 downto 0);
        ALUOp           : out    vl_logic_vector(4 downto 0);
        NPCOp           : out    vl_logic_vector(2 downto 0);
        ALUSrc          : out    vl_logic;
        WDSel           : out    vl_logic_vector(1 downto 0)
    );
end ctrl;
