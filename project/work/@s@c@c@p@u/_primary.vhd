library verilog;
use verilog.vl_types.all;
entity SCCPU is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        inst_in         : in     vl_logic_vector(31 downto 0);
        Data_in         : in     vl_logic_vector(31 downto 0);
        mem_w           : out    vl_logic;
        PC_out          : out    vl_logic_vector(31 downto 0);
        Addr_out        : out    vl_logic_vector(31 downto 0);
        Data_out        : out    vl_logic_vector(31 downto 0);
        reg_sel         : in     vl_logic_vector(4 downto 0);
        reg_data        : out    vl_logic_vector(31 downto 0)
    );
end SCCPU;
