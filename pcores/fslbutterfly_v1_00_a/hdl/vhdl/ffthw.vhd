library ieee;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
library work;
use work.std_logic_arithext.all;


--datapath entity
entity ffthw is
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
end ffthw;


--signal declaration
architecture RTL of ffthw is
signal mul1:std_logic_vector(31 downto 0);
signal mul1_wire:std_logic_vector(31 downto 0);
signal mul2:std_logic_vector(31 downto 0);
signal mul2_wire:std_logic_vector(31 downto 0);
signal mul3:std_logic_vector(31 downto 0);
signal mul3_wire:std_logic_vector(31 downto 0);
signal mul4:std_logic_vector(31 downto 0);
signal mul4_wire:std_logic_vector(31 downto 0);
signal outX:std_logic_vector(31 downto 0);
signal outX_wire:std_logic_vector(31 downto 0);
signal outY:std_logic_vector(31 downto 0);
signal outY_wire:std_logic_vector(31 downto 0);
signal cnt:std_logic_vector(7 downto 0);
signal cnt_wire:std_logic_vector(7 downto 0);
signal sig_0:std_logic;
signal sig_1:std_logic_vector(7 downto 0);
signal sig_2:std_logic_vector(7 downto 0);
signal sig_3:std_logic_vector(7 downto 0);
signal sig_4:std_logic;
signal sig_5:std_logic_vector(63 downto 0);
signal sig_6:std_logic_vector(63 downto 0);
signal sig_7:std_logic_vector(63 downto 0);
signal sig_8:std_logic_vector(63 downto 0);
signal sig_9:std_logic_vector(31 downto 0);
signal sig_10:std_logic_vector(31 downto 0);
signal sig_11:std_logic_vector(31 downto 0);
signal sig_12:std_logic_vector(31 downto 0);
signal sig_13:std_logic_vector(31 downto 0);
signal sig_14:std_logic_vector(31 downto 0);
signal done_int:std_logic;
signal dout1_int:std_logic_vector(31 downto 0);
signal dout2_int:std_logic_vector(31 downto 0);


begin
--register updates
dpREG: process (FSL_Clk,FSL_Rst)
   begin
      if (FSL_Rst = '1') then
         mul1 <= (others=>'0');
         mul2 <= (others=>'0');
         mul3 <= (others=>'0');
         mul4 <= (others=>'0');
         outX <= (others=>'0');
         outY <= (others=>'0');
         cnt <= (others=>'0');
      elsif FSL_Clk' event and FSL_Clk = '1' then
         mul1 <= mul1_wire;
         mul2 <= mul2_wire;
         mul3 <= mul3_wire;
         mul4 <= mul4_wire;
         outX <= outX_wire;
         outY <= outY_wire;
         cnt <= cnt_wire;

      end if;
   end process dpREG;


--combinational logics
dpCMB: process (mul1,mul2,mul3,mul4,outX,outY,cnt,sig_0,sig_1,sig_2
,sig_3,sig_4,sig_5,sig_6,sig_7,sig_8,sig_9,sig_10,sig_11,sig_12
,sig_13,sig_14,done_int,dout1_int,dout2_int,X,Y,u1,u2,ld
)
   begin
      mul1_wire <= mul1;
      mul2_wire <= mul2;
      mul3_wire <= mul3;
      mul4_wire <= mul4;
      outX_wire <= outX;
      outY_wire <= outY;
      cnt_wire <= cnt;
      sig_0 <= '0';
      sig_1 <= (others=>'0');
      sig_2 <= (others=>'0');
      sig_3 <= (others=>'0');
      sig_4 <= '0';
      sig_5 <= (others=>'0');
      sig_6 <= (others=>'0');
      sig_7 <= (others=>'0');
      sig_8 <= (others=>'0');
      sig_9 <= (others=>'0');
      sig_10 <= (others=>'0');
      sig_11 <= (others=>'0');
      sig_12 <= (others=>'0');
      sig_13 <= (others=>'0');
      sig_14 <= (others=>'0');
      done_int <= '0';
      dout1_int <= (others=>'0');
      dout2_int <= (others=>'0');
      dout1 <= (others=>'0');
      dout2 <= (others=>'0');
      done <= '0';

      if (unsigned(cnt) <= 4) then
         sig_0 <= '1';
      else
         sig_0 <= '0';
      end if;
      sig_1 <= unsigned(cnt) + unsigned(conv_std_logic_vector(1,8));
      if (sig_0 = '1') then
         sig_2 <= sig_1;
      else
         sig_2 <= cnt;
      end if;
      if (ld = '1') then
         sig_3 <= conv_std_logic_vector(0,8);
      else
         sig_3 <= sig_2;
      end if;
      if (unsigned(cnt) = 4) then
         sig_4 <= '1';
      else
         sig_4 <= '0';
      end if;
      done <= done_int;
      sig_5 <= unsigned(u1) * unsigned(X);
      sig_6 <= unsigned(u2) * unsigned(Y);
      sig_7 <= unsigned(u1) * unsigned(Y);
      sig_8 <= unsigned(u2) * unsigned(X);
      sig_9 <= unsigned(mul1) - unsigned(mul2);
      sig_10 <= conv_std_logic_vector(signed(sig_9),32);
      sig_11 <= conv_std_logic_vector(shr(signed(sig_10),conv_unsigned(16,32)),32);
      dout1 <= dout1_int;
      sig_12 <= unsigned(mul3) + unsigned(mul4);
      sig_13 <= conv_std_logic_vector(signed(sig_12),32);
      sig_14 <= conv_std_logic_vector(shr(signed(sig_13),conv_unsigned(16,32)),32);
      dout2 <= dout2_int;
      done_int <= sig_4;
      dout1_int <= sig_11;
      dout2_int <= sig_14;
      cnt_wire <= sig_3;
      mul1_wire <= sig_5(31 downto 0);
      mul2_wire <= sig_6(31 downto 0);
      mul3_wire <= sig_7(31 downto 0);
      mul4_wire <= sig_8(31 downto 0);
   end process dpCMB;
end RTL;
