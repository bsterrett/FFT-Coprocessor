library ieee;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
library work;
use work.std_logic_arithext.all;


--datapath entity
entity butterfly_fsmd is
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
end butterfly_fsmd;


--signal declaration
architecture RTL of butterfly_fsmd is
signal Z:std_logic_vector(31 downto 0);
signal R:std_logic_vector(31 downto 0);
signal X:std_logic_vector(31 downto 0);
signal Y:std_logic_vector(31 downto 0);
signal u1:std_logic_vector(31 downto 0);
signal u2:std_logic_vector(31 downto 0);
signal dout1:std_logic_vector(31 downto 0);
signal dout2:std_logic_vector(31 downto 0);
signal done:std_logic;
signal ld:std_logic;
signal rX:std_logic_vector(31 downto 0);
signal rX_wire:std_logic_vector(31 downto 0);
signal rY:std_logic_vector(31 downto 0);
signal rY_wire:std_logic_vector(31 downto 0);
signal rZ:std_logic_vector(31 downto 0);
signal rZ_wire:std_logic_vector(31 downto 0);
signal rR:std_logic_vector(31 downto 0);
signal rR_wire:std_logic_vector(31 downto 0);
signal ru1:std_logic_vector(31 downto 0);
signal ru1_wire:std_logic_vector(31 downto 0);
signal ru2:std_logic_vector(31 downto 0);
signal ru2_wire:std_logic_vector(31 downto 0);
signal rdout1:std_logic_vector(31 downto 0);
signal rdout1_wire:std_logic_vector(31 downto 0);
signal rdout2:std_logic_vector(31 downto 0);
signal rdout2_wire:std_logic_vector(31 downto 0);
signal cnt:std_logic_vector(7 downto 0);
signal cnt_wire:std_logic_vector(7 downto 0);
signal nxtcnt:std_logic_vector(7 downto 0);
signal sig_0:std_logic;
signal sig_1:std_logic_vector(31 downto 0);
signal sig_2:std_logic;
signal sig_3:std_logic_vector(31 downto 0);
signal sig_4:std_logic;
signal sig_5:std_logic_vector(31 downto 0);
signal sig_6:std_logic;
signal sig_7:std_logic_vector(31 downto 0);
signal sig_8:std_logic;
signal sig_9:std_logic;
signal sig_10:std_logic_vector(31 downto 0);
signal sig_11:std_logic_vector(31 downto 0);
signal sig_12:std_logic_vector(31 downto 0);
signal sig_13:std_logic;
signal sig_14:std_logic;
signal sig_15:std_logic;
signal sig_16:std_logic;
signal sig_17:std_logic_vector(8 downto 0);
signal sig_18:std_logic;
signal sig_19:std_logic;
signal sig_20:std_logic;
signal sig_21:std_logic;
signal sig_22:std_logic;
signal sig_23:std_logic;
signal sig_24:std_logic;
signal sig_25:std_logic;
signal sig_26:std_logic;
signal sig_27:std_logic;
signal sig_28:std_logic_vector(7 downto 0);
signal sig_29:std_logic_vector(7 downto 0);
signal wdata_int:std_logic_vector(31 downto 0);
signal read_int:std_logic;
signal write_int:std_logic;


--component map declaration
component ffthw
port(
   X:in std_logic_vector(31 downto 0);
   Y:in std_logic_vector(31 downto 0);
   u1:in std_logic_vector(31 downto 0);
   u2:in std_logic_vector(31 downto 0);
   ld:in std_logic;
   dout1:out std_logic_vector(31 downto 0);
   dout2:out std_logic_vector(31 downto 0);
   done:out std_logic;
   FSL_Rst : in std_logic;
   FSL_Clk : in std_logic
);
end component;


begin


--portmap
label_ffthw : ffthw port map (
      X => X,
      Y => Y,
      u1 => u1,
      u2 => u2,
      ld => ld,
      dout1 => dout1,
      dout2 => dout2,
      done => done,
      FSL_Rst => FSL_Rst,
      FSL_Clk => FSL_Clk
   );
--register updates
dpREG: process (FSL_Clk,FSL_Rst)
   begin
      if (FSL_Rst = '1') then
         rX <= (others=>'0');
         rY <= (others=>'0');
         rZ <= (others=>'0');
         rR <= (others=>'0');
         ru1 <= (others=>'0');
         ru2 <= (others=>'0');
         rdout1 <= (others=>'0');
         rdout2 <= (others=>'0');
         cnt <= (others=>'0');
      elsif FSL_Clk' event and FSL_Clk = '1' then
         rX <= rX_wire;
         rY <= rY_wire;
         rZ <= rZ_wire;
         rR <= rR_wire;
         ru1 <= ru1_wire;
         ru2 <= ru2_wire;
         rdout1 <= rdout1_wire;
         rdout2 <= rdout2_wire;
         cnt <= cnt_wire;

      end if;
   end process dpREG;


--combinational logics
dpCMB: process (Z,R,X,Y,u1,u2,dout1,dout2,done,ld
,rX,rY,rZ,rR,ru1,ru2,rdout1,rdout2,cnt,nxtcnt
,sig_0,sig_1,sig_2,sig_3,sig_4,sig_5,sig_6,sig_7,sig_8,sig_9
,sig_10,sig_11,sig_12,sig_13,sig_14,sig_15,sig_16,sig_17,sig_18,sig_19
,sig_20,sig_21,sig_22,sig_23,sig_24,sig_25,sig_26,sig_27,sig_28,sig_29
,wdata_int,read_int,write_int,rdata,exists,full)
   begin
      Z <= (others=>'0');
      R <= (others=>'0');
      X <= (others=>'0');
      Y <= (others=>'0');
      u1 <= (others=>'0');
      u2 <= (others=>'0');
      ld <= '0';
      rX_wire <= rX;
      rY_wire <= rY;
      rZ_wire <= rZ;
      rR_wire <= rR;
      ru1_wire <= ru1;
      ru2_wire <= ru2;
      rdout1_wire <= rdout1;
      rdout2_wire <= rdout2;
      cnt_wire <= cnt;
      nxtcnt <= (others=>'0');
      sig_0 <= '0';
      sig_1 <= (others=>'0');
      sig_2 <= '0';
      sig_3 <= (others=>'0');
      sig_4 <= '0';
      sig_5 <= (others=>'0');
      sig_6 <= '0';
      sig_7 <= (others=>'0');
      sig_8 <= '0';
      sig_9 <= '0';
      sig_10 <= (others=>'0');
      sig_11 <= (others=>'0');
      sig_12 <= (others=>'0');
      sig_13 <= '0';
      sig_14 <= '0';
      sig_15 <= '0';
      sig_16 <= '0';
      sig_17 <= (others=>'0');
      sig_18 <= '0';
      sig_19 <= '0';
      sig_20 <= '0';
      sig_21 <= '0';
      sig_22 <= '0';
      sig_23 <= '0';
      sig_24 <= '0';
      sig_25 <= '0';
      sig_26 <= '0';
      sig_27 <= '0';
      sig_28 <= (others=>'0');
      sig_29 <= (others=>'0');
      wdata_int <= (others=>'0');
      read_int <= '0';
      write_int <= '0';
      read <= '0';
      wdata <= (others=>'0');
      write <= '0';

      Y <= rY;
      X <= rX;
      u1 <= ru1;
      u2 <= ru2;
      sig_0 <= exists and read_int;
      if (sig_0 = '1') then
         sig_1 <= rdata;
      else
         sig_1 <= rY;
      end if;
      sig_2 <= exists and read_int;
      if (sig_2 = '1') then
         sig_3 <= rY;
      else
         sig_3 <= rX;
      end if;
      sig_4 <= exists and read_int;
      if (sig_4 = '1') then
         sig_5 <= rX;
      else
         sig_5 <= ru1;
      end if;
      sig_6 <= exists and read_int;
      if (sig_6 = '1') then
         sig_7 <= ru1;
      else
         sig_7 <= ru2;
      end if;
      sig_8 <=  not full;
      sig_9 <= sig_8 and write_int;
      if (done = '1') then
         sig_10 <= dout1;
      else
         sig_10 <= rdout1;
      end if;
      if (sig_9 = '1') then
         sig_11 <= rdout2;
      else
         sig_11 <= sig_10;
      end if;
      if (done = '1') then
         sig_12 <= dout2;
      else
         sig_12 <= rdout2;
      end if;
      wdata <= wdata_int;
      sig_13 <= cnt(0) or cnt(1);
      sig_14 <= sig_13 or cnt(2);
      sig_15 <= sig_14 or cnt(3);
      read <= read_int;
      sig_16 <= cnt(6) or cnt(7);
      write <= write_int;
      ld <= cnt(4);
      sig_17 <= conv_std_logic_vector(shl(conv_unsigned(unsigned(cnt),9),conv_unsigned(1,9)),9);
      nxtcnt <= sig_17(7 downto 0);
      sig_18 <= cnt(0) and exists;
      sig_19 <= cnt(1) and exists;
      sig_20 <= cnt(2) and exists;
      sig_21 <= cnt(3) and exists;
      sig_22 <= cnt(5) and done;
      sig_23 <=  not full;
      sig_24 <= cnt(6) and sig_23;
      sig_25 <=  not full;
      sig_26 <= cnt(7) and sig_25;
      if (unsigned(cnt) = 0) then
         sig_27 <= '1';
      else
         sig_27 <= '0';
      end if;
      if (sig_27 = '1') then
         sig_28 <= conv_std_logic_vector(1,8);
      else
         sig_28 <= cnt;
      end if;
      if (sig_18 = '1') then
         sig_29 <= nxtcnt;
      elsif (sig_19 = '1') then
         sig_29 <= nxtcnt;
      elsif (sig_20 = '1') then
         sig_29 <= nxtcnt;
      elsif (sig_21 = '1') then
         sig_29 <= nxtcnt;
      elsif (cnt(4) = '1') then
         sig_29 <= nxtcnt;
      elsif (sig_22 = '1') then
         sig_29 <= nxtcnt;
      elsif (sig_24 = '1') then
         sig_29 <= nxtcnt;
      elsif (sig_26 = '1') then
         sig_29 <= nxtcnt;
      else
         sig_29 <= sig_28;
      end if;
      wdata_int <= rdout1;
      read_int <= sig_15;
      write_int <= sig_16;
      rY_wire <= sig_1;
      rX_wire <= sig_3;
      ru1_wire <= sig_5;
      ru2_wire <= sig_7;
      rdout1_wire <= sig_11;
      rdout2_wire <= sig_12;
      cnt_wire <= sig_29;
   end process dpCMB;
end RTL;
