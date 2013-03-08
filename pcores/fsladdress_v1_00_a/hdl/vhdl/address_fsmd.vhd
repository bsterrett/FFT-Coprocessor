library ieee;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
library work;
use work.std_logic_arithext.all;


--datapath entity
entity address_fsmd is
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
end address_fsmd;


--signal declaration
architecture RTL of address_fsmd is
signal size:std_logic_vector(31 downto 0);
signal address_in:std_logic_vector(31 downto 0);
signal address_out:std_logic_vector(31 downto 0);
signal done:std_logic;
signal ld:std_logic;
signal rsize:std_logic_vector(31 downto 0);
signal rsize_wire:std_logic_vector(31 downto 0);
signal raddr_in:std_logic_vector(31 downto 0);
signal raddr_in_wire:std_logic_vector(31 downto 0);
signal raddr_out:std_logic_vector(31 downto 0);
signal raddr_out_wire:std_logic_vector(31 downto 0);
signal cnt:std_logic_vector(4 downto 0);
signal cnt_wire:std_logic_vector(4 downto 0);
signal nxtcnt:std_logic_vector(4 downto 0);
signal sig_0:std_logic;
signal sig_1:std_logic_vector(31 downto 0);
signal sig_2:std_logic;
signal sig_3:std_logic_vector(31 downto 0);
signal sig_4:std_logic_vector(31 downto 0);
signal sig_5:std_logic;
signal sig_6:std_logic_vector(5 downto 0);
signal sig_7:std_logic;
signal sig_8:std_logic;
signal sig_9:std_logic;
signal sig_10:std_logic;
signal sig_11:std_logic;
signal sig_12:std_logic;
signal sig_13:std_logic_vector(4 downto 0);
signal sig_14:std_logic_vector(4 downto 0);
signal wdata_int:std_logic_vector(31 downto 0);
signal read_int:std_logic;
signal write_int:std_logic;


--component map declaration
component addresshw
port(
   size:in std_logic_vector(31 downto 0);
   address_in:in std_logic_vector(31 downto 0);
   ld:in std_logic;
   address_out:out std_logic_vector(31 downto 0);
   done:out std_logic;
   FSL_Rst : in std_logic;
   FSL_Clk : in std_logic
);
end component;


begin


--portmap
label_addresshw : addresshw port map (
      size => size,
      address_in => address_in,
      ld => ld,
      address_out => address_out,
      done => done,
      FSL_Rst => FSL_Rst,
      FSL_Clk => FSL_Clk
   );
--register updates
dpREG: process (FSL_Clk,FSL_Rst)
   begin
      if (FSL_Rst = '1') then
         rsize <= (others=>'0');
         raddr_in <= (others=>'0');
         raddr_out <= (others=>'0');
         cnt <= (others=>'0');
      elsif FSL_Clk' event and FSL_Clk = '1' then
         rsize <= rsize_wire;
         raddr_in <= raddr_in_wire;
         raddr_out <= raddr_out_wire;
         cnt <= cnt_wire;

      end if;
   end process dpREG;


--combinational logics
dpCMB: process (size,address_in,address_out,done,ld,rsize,raddr_in,raddr_out,cnt,nxtcnt
,sig_0,sig_1,sig_2,sig_3,sig_4,sig_5,sig_6,sig_7,sig_8,sig_9
,sig_10,sig_11,sig_12,sig_13,sig_14,wdata_int,read_int,write_int,rdata,exists
,full)
   begin
      size <= (others=>'0');
      address_in <= (others=>'0');
      ld <= '0';
      rsize_wire <= rsize;
      raddr_in_wire <= raddr_in;
      raddr_out_wire <= raddr_out;
      cnt_wire <= cnt;
      nxtcnt <= (others=>'0');
      sig_0 <= '0';
      sig_1 <= (others=>'0');
      sig_2 <= '0';
      sig_3 <= (others=>'0');
      sig_4 <= (others=>'0');
      sig_5 <= '0';
      sig_6 <= (others=>'0');
      sig_7 <= '0';
      sig_8 <= '0';
      sig_9 <= '0';
      sig_10 <= '0';
      sig_11 <= '0';
      sig_12 <= '0';
      sig_13 <= (others=>'0');
      sig_14 <= (others=>'0');
      wdata_int <= (others=>'0');
      read_int <= '0';
      write_int <= '0';
      read <= '0';
      wdata <= (others=>'0');
      write <= '0';

      size <= rsize;
      address_in <= raddr_in;
      sig_0 <= exists and read_int;
      if (sig_0 = '1') then
         sig_1 <= rdata;
      else
         sig_1 <= raddr_in;
      end if;
      sig_2 <= exists and read_int;
      if (sig_2 = '1') then
         sig_3 <= raddr_in;
      else
         sig_3 <= rsize;
      end if;
      if (done = '1') then
         sig_4 <= address_out;
      else
         sig_4 <= raddr_out;
      end if;
      wdata <= wdata_int;
      sig_5 <= cnt(0) or cnt(1);
      read <= read_int;
      ld <= cnt(2);
      write <= write_int;
      sig_6 <= conv_std_logic_vector(shl(conv_unsigned(unsigned(cnt),6),conv_unsigned(1,6)),6);
      nxtcnt <= sig_6(4 downto 0);
      sig_7 <= cnt(0) and exists;
      sig_8 <= cnt(1) and exists;
      sig_9 <= cnt(3) and done;
      sig_10 <=  not full;
      sig_11 <= cnt(4) and sig_10;
      if (unsigned(cnt) = 0) then
         sig_12 <= '1';
      else
         sig_12 <= '0';
      end if;
      if (sig_12 = '1') then
         sig_13 <= conv_std_logic_vector(1,5);
      else
         sig_13 <= cnt;
      end if;
      if (sig_7 = '1') then
         sig_14 <= nxtcnt;
      elsif (sig_8 = '1') then
         sig_14 <= nxtcnt;
      elsif (cnt(2) = '1') then
         sig_14 <= nxtcnt;
      elsif (sig_9 = '1') then
         sig_14 <= nxtcnt;
      elsif (sig_11 = '1') then
         sig_14 <= nxtcnt;
      else
         sig_14 <= sig_13;
      end if;
      wdata_int <= raddr_out;
      read_int <= sig_5;
      write_int <= cnt(4);
      raddr_in_wire <= sig_1;
      rsize_wire <= sig_3;
      raddr_out_wire <= sig_4;
      cnt_wire <= sig_14;
   end process dpCMB;
end RTL;
