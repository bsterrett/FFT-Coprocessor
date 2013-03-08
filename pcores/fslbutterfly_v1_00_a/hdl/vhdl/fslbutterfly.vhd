library ieee;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
library work;
use work.std_logic_arithext.all;


--datapath entity
entity fslbutterfly is
port(
   FSL_S_Clk:out std_logic;
   FSL_S_Read:out std_logic;
   FSL_S_Data:in std_logic_vector(31 downto 0);
   FSL_S_Control:in std_logic;
   FSL_S_Exists:in std_logic;
   FSL_M_Clk:out std_logic;
   FSL_M_Write:out std_logic;
   FSL_M_Data:out std_logic_vector(31 downto 0);
   FSL_M_Control:out std_logic;
   FSL_M_Full:in std_logic;
   FSL_Rst : in std_logic;
   FSL_Clk : in std_logic

);
end fslbutterfly;


--signal declaration
architecture RTL of fslbutterfly is
signal rdata:std_logic_vector(31 downto 0);
signal wdata:std_logic_vector(31 downto 0);
signal write:std_logic;
signal read:std_logic;
signal exists:std_logic;
signal full:std_logic;
signal FSL_S_Read_int:std_logic;
signal FSL_M_Data_int:std_logic_vector(31 downto 0);
signal FSL_M_Control_int:std_logic;
signal FSL_M_Write_int:std_logic;
signal FSL_S_Clk_int:std_logic;
signal FSL_M_Clk_int:std_logic;


--component map declaration
component butterfly_fsmd
port(
   rdata:in std_logic_vector(31 downto 0);
   exists:in std_logic;
   read:out std_logic;
   wdata:out std_logic_vector(31 downto 0);
   full:in std_logic;
   write:out std_logic;
   FSL_Rst : in std_logic;
   FSL_Clk : in std_logic
);
end component;


begin


--portmap
label_butterfly_fsmd : butterfly_fsmd port map (
      rdata => rdata,
      exists => exists,
      read => read,
      wdata => wdata,
      full => full,
      write => write,
      FSL_Rst => FSL_Rst,
      FSL_Clk => FSL_Clk
   );


--combinational logics
dpCMB: process (rdata,wdata,write,read,exists,full,FSL_S_Read_int,FSL_M_Data_int,FSL_M_Control_int,FSL_M_Write_int
,FSL_S_Clk_int,FSL_M_Clk_int,FSL_S_Data,FSL_S_Control,FSL_S_Exists,FSL_M_Full)
   begin
      rdata <= (others=>'0');
      exists <= '0';
      full <= '0';
      FSL_S_Read_int <= '0';
      FSL_M_Data_int <= (others=>'0');
      FSL_M_Control_int <= '0';
      FSL_M_Write_int <= '0';
      FSL_S_Clk_int <= '0';
      FSL_M_Clk_int <= '0';
      FSL_S_Clk <= '0';
      FSL_S_Read <= '0';
      FSL_M_Clk <= '0';
      FSL_M_Write <= '0';
      FSL_M_Data <= (others=>'0');
      FSL_M_Control <= '0';

      rdata <= FSL_S_Data;
      exists <= FSL_S_Exists;
      FSL_S_Read <= FSL_S_Read_int;
      FSL_M_Data <= FSL_M_Data_int;
      FSL_M_Control <= FSL_M_Control_int;
      FSL_M_Write <= FSL_M_Write_int;
      full <= FSL_M_Full;
      FSL_S_Clk <= FSL_S_Clk_int;
      FSL_M_Clk <= FSL_M_Clk_int;
      FSL_S_Read_int <= read;
      FSL_M_Data_int <= wdata;
      FSL_M_Control_int <= '0';
      FSL_M_Write_int <= write;
      FSL_S_Clk_int <= '0';
      FSL_M_Clk_int <= '0';
   end process dpCMB;
end RTL;
