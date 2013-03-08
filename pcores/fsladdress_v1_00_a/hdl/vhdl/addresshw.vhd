library ieee;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
library work;
use work.std_logic_arithext.all;


--datapath entity
entity addresshw is
port(
   size:in std_logic_vector(31 downto 0);
   address_in:in std_logic_vector(31 downto 0);
   ld:in std_logic;
   address_out:out std_logic_vector(31 downto 0);
   done:out std_logic;
   FSL_Rst : in std_logic;
   FSL_Clk : in std_logic

);
end addresshw;


--signal declaration
architecture RTL of addresshw is
signal bit0:std_logic;
signal bit1:std_logic;
signal bit2:std_logic;
signal bit3:std_logic;
signal bit4:std_logic;
signal bit5:std_logic;
signal bit6:std_logic;
signal bit7:std_logic;
signal bit8:std_logic;
signal bit9:std_logic;
signal tadd0:std_logic_vector(10 downto 0);
signal tadd0_wire:std_logic_vector(10 downto 0);
signal tadd1:std_logic_vector(10 downto 0);
signal tadd1_wire:std_logic_vector(10 downto 0);
signal tadd2:std_logic_vector(10 downto 0);
signal tadd2_wire:std_logic_vector(10 downto 0);
signal tadd3:std_logic_vector(10 downto 0);
signal tadd3_wire:std_logic_vector(10 downto 0);
signal tadd4:std_logic_vector(10 downto 0);
signal tadd4_wire:std_logic_vector(10 downto 0);
signal tadd5:std_logic_vector(10 downto 0);
signal tadd5_wire:std_logic_vector(10 downto 0);
signal tadd6:std_logic_vector(10 downto 0);
signal tadd6_wire:std_logic_vector(10 downto 0);
signal tadd7:std_logic_vector(10 downto 0);
signal tadd7_wire:std_logic_vector(10 downto 0);
signal cnt:std_logic_vector(2 downto 0);
signal cnt_wire:std_logic_vector(2 downto 0);
signal sig_0:std_logic;
signal sig_1:std_logic;
signal sig_2:std_logic_vector(2 downto 0);
signal sig_3:std_logic_vector(2 downto 0);
signal sig_4:std_logic_vector(2 downto 0);
signal sig_5:std_logic;
signal sig_6:std_logic;
signal sig_7:std_logic;
signal sig_8:std_logic;
signal sig_9:std_logic;
signal sig_10:std_logic;
signal sig_11:std_logic;
signal sig_12:std_logic;
signal sig_13:std_logic;
signal sig_14:std_logic;
signal sig_15:std_logic;
signal sig_16:std_logic;
signal sig_17:std_logic;
signal sig_18:std_logic;
signal sig_19:std_logic;
signal sig_20:std_logic;
signal sig_21:std_logic;
signal sig_22:std_logic;
signal sig_23:std_logic;
signal sig_24:std_logic_vector(1 downto 0);
signal sig_25:std_logic_vector(1 downto 0);
signal sig_26:std_logic_vector(2 downto 0);
signal sig_27:std_logic_vector(3 downto 0);
signal sig_28:std_logic_vector(3 downto 0);
signal sig_29:std_logic_vector(4 downto 0);
signal sig_30:std_logic_vector(5 downto 0);
signal sig_31:std_logic_vector(5 downto 0);
signal sig_32:std_logic_vector(6 downto 0);
signal sig_33:std_logic_vector(7 downto 0);
signal sig_34:std_logic_vector(7 downto 0);
signal sig_35:std_logic_vector(8 downto 0);
signal sig_36:std_logic_vector(9 downto 0);
signal sig_37:std_logic_vector(9 downto 0);
signal sig_38:std_logic_vector(10 downto 0);
signal sig_39:std_logic_vector(10 downto 0);
signal sig_40:std_logic_vector(10 downto 0);
signal sig_41:std_logic_vector(31 downto 0);
signal sig_42:std_logic_vector(31 downto 0);
signal done_int:std_logic;
signal address_out_int:std_logic_vector(31 downto 0);


begin
--register updates
dpREG: process (FSL_Clk,FSL_Rst)
   begin
      if (FSL_Rst = '1') then
         tadd0 <= (others=>'0');
         tadd1 <= (others=>'0');
         tadd2 <= (others=>'0');
         tadd3 <= (others=>'0');
         tadd4 <= (others=>'0');
         tadd5 <= (others=>'0');
         tadd6 <= (others=>'0');
         tadd7 <= (others=>'0');
         cnt <= (others=>'0');
      elsif FSL_Clk' event and FSL_Clk = '1' then
         tadd0 <= tadd0_wire;
         tadd1 <= tadd1_wire;
         tadd2 <= tadd2_wire;
         tadd3 <= tadd3_wire;
         tadd4 <= tadd4_wire;
         tadd5 <= tadd5_wire;
         tadd6 <= tadd6_wire;
         tadd7 <= tadd7_wire;
         cnt <= cnt_wire;

      end if;
   end process dpREG;


--combinational logics
dpCMB: process (bit0,bit1,bit2,bit3,bit4,bit5,bit6,bit7,bit8,bit9
,tadd0,tadd1,tadd2,tadd3,tadd4,tadd5,tadd6,tadd7,cnt,sig_0
,sig_1,sig_2,sig_3,sig_4,sig_5,sig_6,sig_7,sig_8,sig_9,sig_10
,sig_11,sig_12,sig_13,sig_14,sig_15,sig_16,sig_17,sig_18,sig_19,sig_20
,sig_21,sig_22,sig_23,sig_24,sig_25,sig_26,sig_27,sig_28,sig_29,sig_30
,sig_31,sig_32,sig_33,sig_34,sig_35,sig_36,sig_37,sig_38,sig_39,sig_40
,sig_41,sig_42,done_int,address_out_int,size,address_in,ld)
   begin
      bit0 <= '0';
      bit1 <= '0';
      bit2 <= '0';
      bit3 <= '0';
      bit4 <= '0';
      bit5 <= '0';
      bit6 <= '0';
      bit7 <= '0';
      bit8 <= '0';
      bit9 <= '0';
      tadd0_wire <= tadd0;
      tadd1_wire <= tadd1;
      tadd2_wire <= tadd2;
      tadd3_wire <= tadd3;
      tadd4_wire <= tadd4;
      tadd5_wire <= tadd5;
      tadd6_wire <= tadd6;
      tadd7_wire <= tadd7;
      cnt_wire <= cnt;
      sig_0 <= '0';
      sig_1 <= '0';
      sig_2 <= (others=>'0');
      sig_3 <= (others=>'0');
      sig_4 <= (others=>'0');
      sig_5 <= '0';
      sig_6 <= '0';
      sig_7 <= '0';
      sig_8 <= '0';
      sig_9 <= '0';
      sig_10 <= '0';
      sig_11 <= '0';
      sig_12 <= '0';
      sig_13 <= '0';
      sig_14 <= '0';
      sig_15 <= '0';
      sig_16 <= '0';
      sig_17 <= '0';
      sig_18 <= '0';
      sig_19 <= '0';
      sig_20 <= '0';
      sig_21 <= '0';
      sig_22 <= '0';
      sig_23 <= '0';
      sig_24 <= (others=>'0');
      sig_25 <= (others=>'0');
      sig_26 <= (others=>'0');
      sig_27 <= (others=>'0');
      sig_28 <= (others=>'0');
      sig_29 <= (others=>'0');
      sig_30 <= (others=>'0');
      sig_31 <= (others=>'0');
      sig_32 <= (others=>'0');
      sig_33 <= (others=>'0');
      sig_34 <= (others=>'0');
      sig_35 <= (others=>'0');
      sig_36 <= (others=>'0');
      sig_37 <= (others=>'0');
      sig_38 <= (others=>'0');
      sig_39 <= (others=>'0');
      sig_40 <= (others=>'0');
      sig_41 <= (others=>'0');
      sig_42 <= (others=>'0');
      done_int <= '0';
      address_out_int <= (others=>'0');
      address_out <= (others=>'0');
      done <= '0';

      if (unsigned(cnt) = 5) then
         sig_0 <= '1';
      else
         sig_0 <= '0';
      end if;
      done <= done_int;
      if (unsigned(cnt) <= 5) then
         sig_1 <= '1';
      else
         sig_1 <= '0';
      end if;
      sig_2 <= unsigned(cnt) + unsigned(conv_std_logic_vector(1,3));
      if (sig_1 = '1') then
         sig_3 <= sig_2;
      else
         sig_3 <= cnt;
      end if;
      if (ld = '1') then
         sig_4 <= conv_std_logic_vector(0,3);
      else
         sig_4 <= sig_3;
      end if;
      if (size(7) = '1') then
         sig_5 <= address_in(6);
      else
         sig_5 <= '0';
      end if;
      if (size(10) = '1') then
         sig_6 <= address_in(9);
      elsif (size(9) = '1') then
         sig_6 <= address_in(8);
      elsif (size(8) = '1') then
         sig_6 <= address_in(7);
      else
         sig_6 <= sig_5;
      end if;
      bit0 <= sig_6;
      if (size(7) = '1') then
         sig_7 <= address_in(5);
      else
         sig_7 <= '0';
      end if;
      if (size(10) = '1') then
         sig_8 <= address_in(8);
      elsif (size(9) = '1') then
         sig_8 <= address_in(7);
      elsif (size(8) = '1') then
         sig_8 <= address_in(6);
      else
         sig_8 <= sig_7;
      end if;
      bit1 <= sig_8;
      if (size(7) = '1') then
         sig_9 <= address_in(4);
      else
         sig_9 <= '0';
      end if;
      if (size(10) = '1') then
         sig_10 <= address_in(7);
      elsif (size(9) = '1') then
         sig_10 <= address_in(6);
      elsif (size(8) = '1') then
         sig_10 <= address_in(5);
      else
         sig_10 <= sig_9;
      end if;
      bit2 <= sig_10;
      if (size(7) = '1') then
         sig_11 <= address_in(3);
      else
         sig_11 <= '0';
      end if;
      if (size(10) = '1') then
         sig_12 <= address_in(6);
      elsif (size(9) = '1') then
         sig_12 <= address_in(5);
      elsif (size(8) = '1') then
         sig_12 <= address_in(4);
      else
         sig_12 <= sig_11;
      end if;
      bit3 <= sig_12;
      if (size(7) = '1') then
         sig_13 <= address_in(2);
      else
         sig_13 <= '0';
      end if;
      if (size(10) = '1') then
         sig_14 <= address_in(5);
      elsif (size(9) = '1') then
         sig_14 <= address_in(4);
      elsif (size(8) = '1') then
         sig_14 <= address_in(3);
      else
         sig_14 <= sig_13;
      end if;
      bit4 <= sig_14;
      if (size(7) = '1') then
         sig_15 <= address_in(1);
      else
         sig_15 <= '0';
      end if;
      if (size(10) = '1') then
         sig_16 <= address_in(4);
      elsif (size(9) = '1') then
         sig_16 <= address_in(3);
      elsif (size(8) = '1') then
         sig_16 <= address_in(2);
      else
         sig_16 <= sig_15;
      end if;
      bit5 <= sig_16;
      if (size(7) = '1') then
         sig_17 <= address_in(0);
      else
         sig_17 <= '0';
      end if;
      if (size(10) = '1') then
         sig_18 <= address_in(3);
      elsif (size(9) = '1') then
         sig_18 <= address_in(2);
      elsif (size(8) = '1') then
         sig_18 <= address_in(1);
      else
         sig_18 <= sig_17;
      end if;
      bit6 <= sig_18;
      if (size(8) = '1') then
         sig_19 <= address_in(0);
      else
         sig_19 <= '0';
      end if;
      if (size(10) = '1') then
         sig_20 <= address_in(2);
      elsif (size(9) = '1') then
         sig_20 <= address_in(1);
      else
         sig_20 <= sig_19;
      end if;
      bit7 <= sig_20;
      if (size(9) = '1') then
         sig_21 <= address_in(0);
      else
         sig_21 <= '0';
      end if;
      if (size(10) = '1') then
         sig_22 <= address_in(1);
      else
         sig_22 <= sig_21;
      end if;
      bit8 <= sig_22;
      if (size(10) = '1') then
         sig_23 <= address_in(0);
      else
         sig_23 <= '0';
      end if;
      bit9 <= sig_23;
      sig_24 <= conv_std_logic_vector(shl(unsigned(logic_zero_ext(bit1,2)),conv_unsigned(1,2)),2);
      sig_25 <= unsigned(logic_zero_ext(bit0,2)) + unsigned(sig_24);
      sig_26 <= conv_std_logic_vector(shl(unsigned(logic_zero_ext(bit2,3)),conv_unsigned(2,3)),3);
      sig_27 <= conv_std_logic_vector(shl(unsigned(logic_zero_ext(bit3,4)),conv_unsigned(3,4)),4);
      sig_28 <= unsigned(conv_std_logic_vector(unsigned(sig_26),4)) + unsigned(sig_27);
      sig_29 <= conv_std_logic_vector(shl(unsigned(logic_zero_ext(bit4,5)),conv_unsigned(4,5)),5);
      sig_30 <= conv_std_logic_vector(shl(unsigned(logic_zero_ext(bit5,6)),conv_unsigned(5,6)),6);
      sig_31 <= unsigned(conv_std_logic_vector(unsigned(sig_29),6)) + unsigned(sig_30);
      sig_32 <= conv_std_logic_vector(shl(unsigned(logic_zero_ext(bit6,7)),conv_unsigned(6,7)),7);
      sig_33 <= conv_std_logic_vector(shl(unsigned(logic_zero_ext(bit7,8)),conv_unsigned(7,8)),8);
      sig_34 <= unsigned(conv_std_logic_vector(unsigned(sig_32),8)) + unsigned(sig_33);
      sig_35 <= conv_std_logic_vector(shl(unsigned(logic_zero_ext(bit8,9)),conv_unsigned(8,9)),9);
      sig_36 <= conv_std_logic_vector(shl(unsigned(logic_zero_ext(bit9,10)),conv_unsigned(9,10)),10);
      sig_37 <= unsigned(conv_std_logic_vector(unsigned(sig_35),10)) + unsigned(sig_36);
      sig_38 <= unsigned(tadd0) + unsigned(tadd1);
      sig_39 <= unsigned(tadd2) + unsigned(tadd3);
      sig_40 <= unsigned(tadd4) + unsigned(tadd5);
      sig_41 <= conv_std_logic_vector(signed(tadd6),32);
      sig_42 <= signed(sig_41) + signed(conv_std_logic_vector(unsigned(tadd7),32));
      address_out <= address_out_int;
      done_int <= sig_0;
      address_out_int <= sig_42;
      cnt_wire <= sig_4;
      tadd0_wire <= conv_std_logic_vector(unsigned(sig_25),11);
      tadd1_wire <= conv_std_logic_vector(unsigned(sig_28),11);
      tadd2_wire <= conv_std_logic_vector(unsigned(sig_31),11);
      tadd3_wire <= conv_std_logic_vector(unsigned(sig_34),11);
      tadd4_wire <= conv_std_logic_vector(unsigned(sig_37),11);
      tadd5_wire <= sig_38;
      tadd6_wire <= sig_39;
      tadd7_wire <= sig_40;
   end process dpCMB;
end RTL;
