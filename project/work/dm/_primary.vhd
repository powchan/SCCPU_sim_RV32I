library verilog;
use verilog.vl_types.all;
entity dm is
    port(
        clk             : in     vl_logic;
        DMWr            : in     vl_logic;
        addr            : in     vl_logic_vector(31 downto 0);
        din             : in     vl_logic_vector(31 downto 0);
        dout            : out    vl_logic_vector(31 downto 0)
    );
end dm;
