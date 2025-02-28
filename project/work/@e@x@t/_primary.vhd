library verilog;
use verilog.vl_types.all;
entity EXT is
    port(
        iimm            : in     vl_logic_vector(11 downto 0);
        simm            : in     vl_logic_vector(11 downto 0);
        bimm            : in     vl_logic_vector(11 downto 0);
        uimm            : in     vl_logic_vector(19 downto 0);
        jimm            : in     vl_logic_vector(19 downto 0);
        EXTOp           : in     vl_logic_vector(5 downto 0);
        immout          : out    vl_logic_vector(31 downto 0)
    );
end EXT;
