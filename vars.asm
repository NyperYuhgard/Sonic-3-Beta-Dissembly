; Constantes
StackPointer          equ $00000000 
Compiler_Place_Holder equ $00000000    
Check_Interrupt       equ $0020800C   

gm_SEGALogo            equ $00
gm_TitleScreen         equ $04
gm_DemoMode            equ $08
gm_PlayMode            equ $0C
gm_S2_SpecialStage     equ $10 
gm_Continue            equ $14
gm_S2_Versus_Mode_Menu equ $1C
gm_S2_Options_Menu     equ $24
gm_Level_Select_Menu   equ $28
gm_S3_Special_Stage    equ $2C
gm_SK_Special_Stage    equ $30

Sonic_And_Miles       equ $00
Sonic_Alone           equ $01
Miles_Alone           equ $02
Knuckles_Alone        equ $03

; Botões dos Controles
Btn_Up                equ $00    
Btn_Down              equ $01  
Btn_Left              equ $02    
Btn_Right             equ $03
Btn_B                 equ $04
Btn_C                 equ $05   
Btn_A                 equ $06
Btn_Start             equ $07

; Varíaveis de objetos
Obj_Pointer           equ $00     ; Longword      ; 00          ; 00..03
Obj_Flags             equ $04     ; Byte          ; 01          ; 04
Obj_Routine           equ $05     ; Byte          ; 24          ; 05
Obj_Height            equ $06     ; Byte 
Obj_Width             equ $07     ; Byte          ; 19          ; 07
Obj_Priority          equ $08     ; Word          ; 18          ; 08..09
Obj_Art_VRAM          equ $0A     ; Word          ; 02..03      ; 0A..0B
Obj_Map               equ $0C     ; Longword      ; 04..07      ; 0C..0F
Obj_X                 equ $10     ; Word          ; 08..09      ; 10..11
Obj_Sub_X             equ $12     ; Word          ; 0A..0B      ; 12..13  ; Fixed position
Obj_Y                 equ $14     ; Word          ; 0C..0D      ; 14..15
Obj_Sub_Y             equ $16     ; Word          ; 0E..0F      ; 16..17
Obj_Speed_X           equ $18     ; Longword      ; 10..13      ; 18..1B
Obj_Speed_Y           equ $1A     ; complemento do $18 as vezes referenciado em word ; 12..13 ; 1A..1B
Obj_Inertia           equ $1C     ; Word          ; 14..15      ; 1C..1D
Obj_Height_2          equ $1E     ; Byte          ; 16          ; 1E
Obj_Width_2           equ $1F     ; Byte          ; 17          ; 1F
Obj_Ani_Number        equ $20     ; Byte          ; 1C          ; 20
Obj_Ani_Flag          equ $21     ; Byte          ; 1D          ; 21
Obj_Map_Id            equ $22     ; Byte          ; 1A          ; 22
Obj_Ani_Frame         equ $23     ; Byte          ; 1B          ; 23
Obj_Ani_Time          equ $24     ; Byte          ; 1E..1F      ; 24..25
Obj_Ani_Time_2        equ $25     ; Byte          ; 1F          ; 25   ; Usado por alguns objetos do Sonic 1
Obj_Angle             equ $26     ; Byte          ; $26         ; $26
Obj_Flip_Angle        equ $27     ; Byte          ; $27         ; $27
Obj_Col_Flags         equ $28     ; Byte          ; 20          ; 28   ; Collision Flags
Obj_Col_Prop          equ $29     ; Byte          ; 21          ; 29 
Obj_Status            equ $2A     ; Byte          ; 22          ; 2A
Obj_Status_2          equ $2B     ; Byte
Obj_Subtype           equ $2C     ; Byte          ; 28          ; 2C
Obj_Flags_2           equ $2D     ; Byte          ; 29          ; 2D
Obj_Timer             equ $2E     ; Word          ; 2A..2B      ; 2E..2F
Obj_Timer_2           equ $2F 
Obj_Child_Data        equ $30  
Obj_Child             equ $34 
Obj_Destr_Flag        equ $3D     ; Byte          ; 39          ; 3D
Obj_Parent_Ref        equ $3E     ; Word          ; 3E..3F      ; 3E..3F     
Obj_Height_3          equ $44 
Obj_Width_3           equ $45 
Obj_Child_Ref         equ $46
Obj_Respaw_Ref        equ $48     ; Word          ; None        ; 48..49

Obj_Size              equ $4A

; Variaveis locais de objectos
Obj_Control_Var_00      equ $30
Obj_Control_Var_01      equ $31
Obj_Control_Var_02      equ $32
Obj_Control_Var_03      equ $33
Obj_Control_Var_04      equ $34 
Obj_Control_Var_05      equ $35
Obj_Control_Var_06      equ $36
Obj_Control_Var_07      equ $37
Obj_Control_Var_08      equ $38
Obj_Control_Var_09      equ $39
Obj_Control_Var_0A      equ $3A
Obj_Control_Var_0B      equ $3B
Obj_Control_Var_0C      equ $3C
Obj_Control_Var_0D      equ $3D
Obj_Control_Var_0E      equ $3E
Obj_Control_Var_0F      equ $3F
Obj_Player_One_Or_Two   equ $3F
Obj_Control_Var_10      equ $40
Obj_Control_Var_11      equ $41
Obj_Control_Var_12      equ $42
Obj_Control_Var_13      equ $43  
Obj_Player_One_Or_Two_2 equ $43
Obj_Control_Var_14      equ $44  
Obj_Control_Var_16      equ $46  



; Variaveis usadas pelos jogadores
Obj_Player_Flip_Flag  equ $2D     ; Byte          ; 29          ; 2D
Obj_Player_Control    equ $2E     ; Byte          ; 2A          ; 2E 
Obj_Player_Status     equ $2F     ; Byte          ; 2B          ; 2F
Obj_P_Flips_Remaining equ $30     ; Byte          ; 2C          ; 30   
Obj_Player_Flip_Speed equ $31     ; Byte          ; 2D          ; 31
Obj_P_Horiz_Ctrl_Lock equ $32     ; Word          ; 2E..2F      ; 32..33  
Obj_P_Invunerblt_Time equ $34     ; Word / Byte   ; 30..31      ; 34
Obj_P_Invcbility_Time equ $35     ; Word / Byte   ; 32..33      ; 35
Obj_P_Spd_Shoes_Time  equ $36     ; Word / Byte   ; 34..35      ; 36
Obj_Player_Hit_Flag   equ $37     ; Byte                        ; 37
Obj_Player_Selected   equ $38     ; Byte                        ; 38  0 Sonic 1 Miles 2 Knuckles
Obj_Look_Up_Down_Time equ $39     ; Byte                        ; 39 
Obj_Player_Next_Tilt  equ $3A     ; Byte          ; 36          ; 3A
Obj_Player_Tilt       equ $3B     ; Byte          ; 37          ; 3B
Obj_Player_St_Convex  equ $3C     ; Byte          ; 38          ; 3C
Obj_Player_Spdsh_Flag equ $3D     ; Byte          ; 39          ; 3D
Obj_Player_Spdsh_Cnt  equ $3E     ; Byte          ; 3A          ; 3E
Obj_Player_Jump       equ $40     ; Byte          ; 3C          ; 40   
Obj_Player_Angle_Flag equ $41
Obj_Player_Last       equ $42     ; Byte / Word   ; 3D          ; 42..43
Obj_Player_Top_Solid  equ $46     ; Byte          ; 3E          ; 46
Obj_Player_LRB_Solid  equ $47     ; Byte          ; 3F          ; 47 ; Left / Right / Bottom

; Variaveis usadas pelos chefes
Obj_Boss_Hit          equ $29


; Status dos jogadores. Também usado pelos escudos para proteção
Classic_Type       equ $00
Invincibility_Type equ $01
Speed_Type         equ $02
Projectile_Type    equ $03 
Fire_Type          equ $04 
Lightning_Type     equ $05 
Water_Type         equ $06


Acceleration equ $0002
Deceleration equ $0004

Max_Dynamic_Objects   equ (((Obj_Dynamic_RAM_End-Obj_Dynamic_RAM)/$4A)-$01)
                          
; Fases 
S2_EHz_Id             equ $00
S2_EHz_Act_1          equ $0000
S2_EHz_Act_2          equ $0001
S2_Mz_Act_3           equ $0500
S2_WFz                equ $0600
S2_HTz_Act_2          equ $0701
S2_OOz_Act_2          equ $0A01
S2_MCz_Act_2          equ $0B01
S2_CNz_Id             equ $0C
S2_CNz_Act_1          equ $0C00
S2_CNz_Act_2          equ $0C01
S2_CPz_Act_1          equ $0D00
S2_CPz_Act_2          equ $0D01
S2_DEz                equ $0E00  
S2_ARz_Act_1          equ $0F00
S2_ARz_Act_2          equ $0F01
S2_SCz                equ $1000

Aiz_Id                equ $00
AIz_Act_1             equ $0000   
AIz_Act_2             equ $0001
Hz_Id                 equ $01
Hz_Act_1              equ $0100
Hz_Act_2              equ $0101
MGz_Id                equ $02
MGz_Act_1             equ $0200
MGz_Act_2             equ $0201
CNz_Id                equ $03
CNz_Act_1             equ $0300
CNz_Act_2             equ $0301
FBz_Act_1             equ $0400
FBz_Act_2             equ $0401 
Iz_Id                 equ $05
Iz_Act_1              equ $0500
Iz_Act_2              equ $0501
LBz_Id                equ $06
LBz_Act_1             equ $0600
LBz_Act_2             equ $0601
LRz_Id                equ $09
LRz_Act_1             equ $0900
DDz_Id                equ $0C
DDz_Act_1             equ $0C00
ALz_Id                equ $0E
Alz_Act_1             equ $0E00  
BPz_Id                equ $0F
BPz_Act_1             equ $0F00
DPz_Act_1             equ $1000
CGz_Act_1             equ $1100
EMz_Id                equ $12
EMz_Act_1             equ $1200
GM_BS_Id              equ $13
GM_BS_Act_1           equ $1300
GS_BS_Act_1           equ $1400
SM_BS_Act_1           equ $1500

S3_Special_Stage      equ $4000
SK_Special_Stage      equ $4001
Disabled_Level        equ $5555
Reset_Game            equ $FFFF


; Músicas 
Angel_Island_1_Snd       equ $0001
Angel_Island_2_Snd       equ $0002
Hydrocity_1_Snd          equ $0003
Hydrocity_2_Snd          equ $0004
Marble_Garden_1_Snd      equ $0005
Marble_Garden_2_Snd      equ $0006
Carnival_Night_1_Snd     equ $0007
Carnival_Night_2_Snd     equ $0008
Flying_Battery_1_Snd     equ $0009
Flying_Battery_2_Snd     equ $000A
Icecap_1_Snd             equ $000B
Icecap_2_Snd             equ $000C
Launch_Base_1_Snd        equ $000D
Launch_Base_2_Snd        equ $000E
Mushroom_Valley_1_Snd    equ $000F
Mushroom_Valley_2_Snd    equ $0010
Sandopolis_1_Snd         equ $0011
Sandopolis_2_Snd         equ $0012
Lava_Reef_1_Snd          equ $0013
Lava_Reef_2_Snd          equ $0014
Sky_Sanctuary_Snd        equ $0015
Death_Egg_1_Snd          equ $0016
Death_Egg_2_Snd          equ $0017
Mini_Boss_Snd            equ $0018
Boss_Snd                 equ $0019
The_Doomsday_Snd         equ $001A
Special_Stage_Snd        equ $001C
BS_Slot_Machine_Snd      equ $001D
BS_Gumball_Machine_Snd   equ $001E
Knuckles_Theme_Snd       equ $001F
Azure_Lake_Snd           equ $0020
Balloon_Park_Snd         equ $0021
Desert_Palace_Snd        equ $0022
Chrome_Gadget_Snd        equ $0023
Endless_Mine_Snd         equ $0024
Title_Screen_Snd         equ $0025
Game_Over_Time_Over_Snd  equ $0027 
Continue_Snd             equ $0028
Extra_Life_Snd           equ $002A
Got_Emerald_Snd          equ $002B
Invincibility_Snd        equ $002C
Panic_Snd                equ $0031 

Super_Sonic_Snd          equ $000A 


; Efeitos especiais     
Ring_Sfx                 equ $0032
Ring_Left_Speaker_Sfx    equ $0033
Ring_Lost_Sfx            equ $0034
Hurt_Sfx                 equ $0035
Skidding_Sfx             equ $0036 ; Stopping_Sfx
Collect_Oxygen_Sfx       equ $0038 
Water_Splash_Sfx         equ $0039
Drowning_Sfx             equ $003B
Rolling_Sfx              equ $003C ; Spin_Sfx     
Object_Hit_Sfx           equ $003D
Got_Fire_Shield_Sfx      equ $003E  
Got_Water_Shield_Sfx     equ $003F
Got_Lightning_Shield_Sfx equ $0041
Fire_Shield_Sfx          equ $0043
Hyper_Form_Change_Sfx    equ $0046
Grab_Sfx                 equ $004A
Waterfall_Splash_Sfx     equ $004F
Projectile_Sfx           equ $0051
Missile_Explosion_Sfx    equ $0052
Flame_Sfx                equ $0053
Flying_Battery_Move_Sfx  equ $0054
Missile_Throw_Sfx        equ $0056 
Robotnik_Buzzer_Sfx      equ $0057
Spike_Move_Sfx           equ $0058
Draw_Bridge_Move_Sfx     equ $005C
Geyser_Sfx               equ $005D
Fan_Big_Sfx              equ $005E 
Sfx_61                   equ $0061
Smash_Sfx                equ $0062 
Switch_Blip_Sfx          equ $0064
Floor_Thump_Sfx          equ $0068
Crash_Sfx                equ $006C
Jump_Sfx                 equ $0070
Level_Projectile_Sfx     equ $0075
Underwater_Sfx           equ $0079
Boss_Hit_Sfx             equ $007C
Hoverpad_Sfx             equ -$80   ; $0080
Transporter_Sfx          equ -$7F   ; $0081
Tunnel_Booster_Sfx       equ -$7E   ; $0082
Rising_Platform_Sfx      equ -$7D   ; $0083
Wave_Hover_Sfx           equ -$7C   ; $0084
Trapdoor_Sfx             equ -$7B   ; $0085
Balloon_Pop_Sfx          equ -$7A   ; $0086 
Cannon_Turn_Sfx          equ -$79   ; $0087
Small_Bumper_Sfx         equ -$75   ; $008B
Frost_Puff_Sfx           equ -$6F   ; $0091
Ice_Spike_Sfx            equ -$6E   ; $0092
Tube_Launcher_Sfx        equ -$6B   ; $0095
Bridge_Collapse_Sfx      equ -$69   ; $0097  
Buzzer_Sfx               equ -$65   ; $009B
Door_Close_Sfx           equ -$56   ; $00AA
Slide_Thunk_Sfx          equ -$50   ; $00B0
Super_Form_Change_Sfx    equ -$45   ; $00BB  
Energy_Zap_Sfx           equ -$37   ; $00C9
Check_Point_Sfx          equ -$32   ; $00CE 
Special_Stage_Entry_Sfx  equ -$30   ; $00D0 
Spring_Sfx               equ -$2E   ; $00D2
Error_Sfx                equ $00D3       

S2_Enter_Big_Ring_Sfx    equ $0032
S2_Extra_Life_Snd        equ $0098
S2_Panic_Snd             equ $009F 
S2_Smash_Sfx             equ $00B9 
S2_Cha_Ching_Sfx         equ $00C5 
S2_Spring_Sfx            equ $00CC
S2_Add_Points_Blip_Sfx   equ $00CD
S2_Panel_Spinning_Sfx    equ $00CF 
S2_Baaaang_Bumper_Sfx    equ $00D9


; Comandos
Volume_Down              equ -$20 ; $E0
Stop_Sound               equ -$1F ; $E1
PSG_Mute                 equ -$1E ; $E2
Stop_SFx                 equ -$1D ; $E3
Music_Normal_Speed       equ $00FC

; Outros
Sega_PCM               equ -$01 ; $FF


; Z80  
Z80_RAM_Start                  equ $00A00000 

; I/O

IO_Hardware_Version            equ $00A10001 
IO_Joypad_Port_0               equ $00A10003
IO_Port_0_Control              equ $00A10008
IO_Port_1_Control              equ $00A1000A
IO_Expansion_Control           equ $00A1000C

Z80_Bus_Request                equ $00A11100 
Z80_Reset                      equ $00A11200 

; VDP

VDP_Data_Port                  equ $00C00000
VDP_Control_Port               equ $00C00004

; RAM
StackPointer                 equ $00000000  

M68K_Dev_RAM_Start           equ $FFFE0000  

M68K_RAM_Start               equ $FFFF0000  


Sprite_Table_Buffer_2            equ M68K_RAM_Start+$7880
Sprite_Table_Buffer_P2           equ M68K_RAM_Start+$7B00
Sprite_Table_Buffer_P2_2         equ M68K_RAM_Start+$7D80
Level_Layout_Buffer              equ M68K_RAM_Start+$8000
Fg_Mem_Start_Address             equ Level_Layout_Buffer
Fg_Mem_Index_Address             equ Level_Layout_Buffer+$08
Level_Layout_Buffer_End          equ Level_Layout_Buffer+$1000
Blocks_Mem_Address               equ M68K_RAM_Start+$9000
NemesisDec_Data_Buffer           equ M68K_RAM_Start+$AA00
Horizontal_Scroll_Table          equ M68K_RAM_Start+$A800
Sprite_Table_Input               equ M68K_RAM_Start+$AC00

Obj_Memory_Address               equ M68K_RAM_Start+$B000
Obj_Player_One                   equ Obj_Memory_Address
Obj_Player_Two                   equ Obj_Memory_Address+$004A   
Obj_02_Mem_Address               equ Obj_Memory_Address+(Obj_Size*$02)
Obj_04_Mem_Address               equ Obj_Memory_Address+(Obj_Size*$04)
Obj_05_Mem_Address               equ Obj_Memory_Address+(Obj_Size*$05)
Obj_08_Mem_Address               equ Obj_Memory_Address+(Obj_Size*$08)
Obj_Dynamic_RAM                  equ Obj_Memory_Address+(Obj_Size*$03) 
Obj_Dynamic_RAM_End              equ Obj_Memory_Address+(Obj_Size*$5D) 
Obj_Fixed_RAM                    equ Obj_Memory_Address+(Obj_Size*$5E)
Obj_P1_Underwater_Control        equ Obj_Fixed_RAM                ; $5E
Obj_P2_Underwater_Control        equ Obj_Fixed_RAM+(Obj_Size*$01) ; $5F
Obj_Super_Sonic_Stars_RAM        equ Obj_Fixed_RAM+(Obj_Size*$02) ; $60
Obj_Miles_Tails_RAM              equ Obj_Fixed_RAM+(Obj_Size*$03) ; $61
Obj_P1_Dust_Water_Splash         equ Obj_Fixed_RAM+(Obj_Size*$04) ; $62
Obj_P2_Dust_Water_Splash         equ Obj_Fixed_RAM+(Obj_Size*$05) ; $63
Obj_P1_Shield                    equ Obj_Fixed_RAM+(Obj_Size*$06) ; $64
Obj_P2_Shield                    equ Obj_Fixed_RAM+(Obj_Size*$07) ; $65
Obj_P1_Invincibility             equ Obj_Fixed_RAM+(Obj_Size*$08) ; $66
Obj_P2_Invincibility             equ Obj_Fixed_RAM+(Obj_Size*$0C) ; $6A
Obj_Fixed_RAM_End                equ Obj_Fixed_RAM+(Obj_Size*$0F) ; $6D
                   
Conveyor_Belt_Data_Array         equ M68K_RAM_Start+$CFE0                 
Kosinski_Decomp_Buffer           equ M68K_RAM_Start+$D000
Horizontal_Scroll_Buffer         equ M68K_RAM_Start+$E000 
                           
Collision_Response_List          equ M68K_RAM_Start+$E380

Status_Table_Data                equ M68K_RAM_Start+$E400
Position_Table_Data              equ M68K_RAM_Start+$E500
Position_Table_Data_P2           equ M68K_RAM_Start+$E600
                           
DMA_Buffer_List                  equ M68K_RAM_Start+$E700
DMA_Buffer_List_End              equ M68K_RAM_Start+$E8F8

Ring_Status_Table                equ M68K_RAM_Start+$E900
                           
Palette_Buffer                   equ M68K_RAM_Start+$ED00
Palette_Row_0_Offset             equ Palette_Buffer
Palette_Row_1_Offset             equ Palette_Buffer+$0020
Palette_Row_2_Offset             equ Palette_Buffer+$0040
Palette_Row_3_Offset             equ Palette_Buffer+$0060
                            
Palette_Data_Target              equ Palette_Buffer+$0080
Palette_Row_1_Data_Target        equ Palette_Buffer+$00A0
Palette_Row_2_Data_Target        equ Palette_Buffer+$00C0
Palette_Row_3_Data_Target        equ Palette_Buffer+$00E0                            

                            
Camera_RAM                       equ M68K_RAM_Start+$EE00
Horizontal_Scrolling             equ Camera_RAM
Vertical_Scrolling               equ Camera_RAM+$02
Horizontal_Scrolling_P2          equ Camera_RAM+$04
Vertical_Scrolling_P2            equ Camera_RAM+$06
Tmp_EE08                         equ Camera_RAM+$08
Sonic_Scroll_Lock_Flag           equ Camera_RAM+$0A
Miles_Scroll_Lock_Flag           equ Camera_RAM+$0B
Level_Limits_Min_X               equ Camera_RAM+$0C 
Level_Limits_Max_X               equ Camera_RAM+$0E 
Level_Limits_Min_Y               equ Camera_RAM+$10 
Level_Limits_Max_Y               equ Camera_RAM+$12             
Sonic_Level_Limits_Min_X         equ Camera_RAM+$14 
Sonic_Level_Limits_Max_X         equ Camera_RAM+$16
Sonic_Level_Limits_Min_Y         equ Camera_RAM+$18
Sonic_Level_Limits_Max_Y         equ Camera_RAM+$1A 
Miles_Level_Limits_Min_X         equ Camera_RAM+$1C
Miles_Level_Limits_Max_X         equ Camera_RAM+$1E
Miles_Level_Limits_Min_Y         equ Camera_RAM+$20
Miles_Level_Limits_Max_Y         equ Camera_RAM+$22
Camera_X_Scroll_Delay            equ Camera_RAM+$24  
Position_Table_Index             equ Camera_RAM+$26
Camera_X_Scroll_Delay_2P         equ Camera_RAM+$28 
Position_Table_Index_2P          equ Camera_RAM+$2A
Distance_From_Top                equ Camera_RAM+$2C
Distance_From_Top_P2             equ Camera_RAM+$2E     
Rasters_Flag                     equ Camera_RAM+$30
Level_Limits_Y_Changing          equ Camera_RAM+$32
Dynamic_Resize_Routine           equ M68K_RAM_Start+$EE33
Fast_Vertical_Scroll_Flag        equ M68K_RAM_Start+$EE39
Vertical_Scroll_Value_P2_2       equ M68K_RAM_Start+$EE3A
Camera_X_Difference              equ Camera_RAM+$3E
Camera_Y_Difference              equ Camera_RAM+$40
Ring_Start_Offset_Ptr            equ M68K_RAM_Start+$EE44
Ring_End_Offset_Ptr              equ M68K_RAM_Start+$EE48
Ring_Offset_Ptr                  equ M68K_RAM_Start+$EE4C
Object_Respaw_Next               equ M68K_RAM_Start+$EE50
Object_Respaw_Previous           equ M68K_RAM_Start+$EE52
Apparent_ZoneAndAct:		equ M68K_RAM_Start+$EE54			; 2 bytes; unlike Current_ZoneAndAct, this is only used
										; during level transitions where the player enters Act 2
										; but is still stated to be in Act 1 until a later point
Apparent_Zone:			equ M68K_RAM_Start+$EE54
Apparent_Act:			equ M68K_RAM_Start+$EE55
Palette_Fade_Timer               equ M68K_RAM_Start+$EE56 
Camera_X_P2                      equ Camera_RAM+$60 
Camera_Y_P2                      equ Camera_RAM+$64
Screen_Pos_Buffer_X_P2           equ Camera_RAM+$68
Screen_Pos_Buffer_Y_P2           equ Camera_RAM+$6C
Screen_Pos_Buffer_X_P2_2         equ Camera_RAM+$70
Screen_Pos_Buffer_Y_P2_2         equ Camera_RAM+$74
Camera_X                         equ Camera_RAM+$78
Camera_Y                         equ Camera_RAM+$7C
Screen_Pos_Buffer_X              equ M68K_RAM_Start+$EE80
Screen_Pos_Buffer_Y              equ M68K_RAM_Start+$EE84
Screen_Pos_Rounded_X             equ M68K_RAM_Start+$EE88
Screen_Pos_Rounded_Y             equ M68K_RAM_Start+$EE8A
Screen_Pos_Buffer_X_2            equ M68K_RAM_Start+$EE8C
AIz_Wavy_Flame_Counter           equ M68K_RAM_Start+$EE8E
Screen_Pos_Buffer_Y_2            equ M68K_RAM_Start+$EE90
Screen_Pos_Rounded_X_2           equ M68K_RAM_Start+$EE94
Screen_Pos_Rounded_Y_2           equ M68K_RAM_Start+$EE96
AIz_Flying_Battery_X             equ M68K_RAM_Start+$EE98  
AIz_Flying_Battery_Y             equ M68K_RAM_Start+$EE9C
AIz_Flying_Battery_Rounded_Y     equ M68K_RAM_Start+$EEA2
Plane_Double_Update_Flag         equ M68K_RAM_Start+$EEA4
Special_Vint_Routine             equ M68K_RAM_Start+$EEA6
Screen_Wrap_X                    equ M68K_RAM_Start+$EEA8
Screen_Wrap_Y                    equ M68K_RAM_Start+$EEAA
Level_Layout_Wrap_Y              equ M68K_RAM_Start+$EEAC 
Level_Layout_Wrap_Row            equ M68K_RAM_Start+$EEAE 
VRAM_Add                         equ M68K_RAM_Start+$EEB0
Level_Repeat_Routine             equ M68K_RAM_Start+$EEB2
Level_Events_Buffer_0            equ M68K_RAM_Start+$EEB4
Level_Events_Buffer_1            equ M68K_RAM_Start+$EEB6
Level_Events_Buffer_0_P2         equ M68K_RAM_Start+$EEB8
Level_Events_Buffer_1_P2         equ M68K_RAM_Start+$EEBA
Level_Repeat_Offset              equ M68K_RAM_Start+$EEBC
Level_Events_Routine             equ M68K_RAM_Start+$EEC0
Level_Events_Routine_2           equ M68K_RAM_Start+$EEC2
Foreground_Events_Y_Counter      equ M68K_RAM_Start+$EEC4
Level_Events_Buffer_5            equ M68K_RAM_Start+$EEC6
Draw_Delayed_Position            equ M68K_RAM_Start+$EEC8
Draw_Delayed_Position_Rowcount   equ M68K_RAM_Start+$EECA
Earthquake_Flag                  equ M68K_RAM_Start+$EECC
Earthquake_Offset                equ M68K_RAM_Start+$EECE
Earthquake_Last_Offset           equ M68K_RAM_Start+$EED0
Background_Events                equ M68K_RAM_Start+$EED2  
Vertical_Scroll_Buffer           equ M68K_RAM_Start+$EEEA
Sprite_Mask_Flag                 equ M68K_RAM_Start+$EF3A
Use_Normal_Sprite_Table          equ M68K_RAM_Start+$EF3C
Normal_Sprite_Table_Flag         equ M68K_RAM_Start+$EF3E
Level_Result_BCD_Total_Bonus     equ M68K_RAM_Start+$EF40
Ring_Consumption_Table           equ M68K_RAM_Start+$EF80
                             
Palette_Underwater_Target        equ M68K_RAM_Start+$F000
                             
Palette_Underwater_Buffer        equ M68K_RAM_Start+$F080
Palette_UW_Row_0_Offset          equ Palette_Underwater_Buffer
Palette_UW_Row_1_Offset          equ Palette_Underwater_Buffer+$0020
Palette_UW_Row_2_Offset          equ Palette_Underwater_Buffer+$0040
Palette_UW_Row_3_Offset          equ Palette_Underwater_Buffer+$0060
                             
Plane_Buffer                     equ M68K_RAM_Start+$F100
Game_Mode                        equ M68K_RAM_Start+$F600
Control_Ports_Logical_Data       equ M68K_RAM_Start+$F602
Control_Ports_Buffer_Data        equ M68K_RAM_Start+$F604
HBlank_Ptr                       equ M68K_RAM_Start+$F608
VDP_Register_1_Command           equ M68K_RAM_Start+$F60E
Demo_Timer                       equ M68K_RAM_Start+$F614
Vertical_Scroll_Value            equ M68K_RAM_Start+$F616
Vertical_Scroll_Value_2          equ M68K_RAM_Start+$F618
Vertical_Scroll_Value_3          equ M68K_RAM_Start+$F61A
Vertical_Scroll_Value_P2         equ M68K_RAM_Start+$F61E
Vertical_Scroll_Value_P2_3       equ M68K_RAM_Start+$F620
S2_Teleport_Timer                equ M68K_RAM_Start+$F622 
S2_Teleport_Flag                 equ M68K_RAM_Start+$F623 
Horizontal_Int_Count_Cmd         equ M68K_RAM_Start+$F624
Scanline_Counter                 equ M68K_RAM_Start+$F625
Palette_Fade_Info                equ M68K_RAM_Start+$F626
Palette_Fade_Count               equ M68K_RAM_Start+$F627
VBlank_0_Run_Count               equ M68K_RAM_Start+$F628
VBlank_Index                     equ M68K_RAM_Start+$F62A
Sprites_Drawn                    equ M68K_RAM_Start+$F62C
Palette_Underwater_Ptr           equ M68K_RAM_Start+$F62E
Palette_Cycle_Count_0            equ M68K_RAM_Start+$F632
Palette_Cycle_Count_1            equ M68K_RAM_Start+$F634
Random_Seed                      equ M68K_RAM_Start+$F636
Pause_Status                     equ M68K_RAM_Start+$F63A
DMA_Trigger                      equ M68K_RAM_Start+$F640
Horizontal_Interrupt_Flag        equ M68K_RAM_Start+$F644
Water_Level_Move                 equ M68K_RAM_Start+$F646
Current_Water_Level              equ M68K_RAM_Start+$F648
Target_Water_Level               equ M68K_RAM_Start+$F64A
Water_Level_Change_Speed         equ M68K_RAM_Start+$F64C
Water_Entered_Counter            equ M68K_RAM_Start+$F64D
Underwater_Flag                  equ M68K_RAM_Start+$F64E
H_Int_Update_Flag                equ M68K_RAM_Start+$F64F 
Palette_Cycle_Counters           equ M68K_RAM_Start+$F650
Super_Sonic_Palette_Frame        equ M68K_RAM_Start+$F65C
Super_Sonic_Palette_Timer        equ M68K_RAM_Start+$F65E
Super_Sonic_Palette_Status       equ M68K_RAM_Start+$F65F
PalCycle_Done_Flag               equ M68K_RAM_Start+$F660
VBlank_Subroutine                equ M68K_RAM_Start+$F662
Background_Collision_Flag        equ M68K_RAM_Start+$F664
Level_Boundaries_Flag            equ M68K_RAM_Start+$F668
Control_Ports_Logical_Data_2     equ M68K_RAM_Start+$F66A
Super_Sonic_Frame_Count          equ M68K_RAM_Start+$F670
PLC_Data_Buffer                  equ M68K_RAM_Start+$F680
Nemesis_Decomp_Destination       equ M68K_RAM_Start+$F684
Nemesis_Decomp_Vars              equ M68K_RAM_Start+$F6E0
Nemesis_Repeat_Count             equ M68K_RAM_Start+$F6E4
Nemesis_Palette_Index            equ M68K_RAM_Start+$F6E8
Nemesis_Previous_Row             equ M68K_RAM_Start+$F6EC
Nemesis_Data_Word                equ M68K_RAM_Start+$F6F0
Nemesis_Shift_Value              equ M68K_RAM_Start+$F6F4
PLC_Data_Count                   equ M68K_RAM_Start+$F6F8
Nemesis_Frame_Pattern_Left       equ M68K_RAM_Start+$F6FA
PLC_Data_Buffer_End:             equ PLC_Data_Buffer+$80
Miles_Control_Vars               equ M68K_RAM_Start+$F700    
Miles_CPU_Ctrl_Auto_Timer        equ M68K_RAM_Start+$F702
Miles_CPU_Respawn_Timer          equ M68K_RAM_Start+$F704
Miles_CPU_Routine                equ M68K_RAM_Start+$F708 
Miles_CPU_Respawn_X              equ M68K_RAM_Start+$F70A
Miles_CPU_Respawn_Y              equ M68K_RAM_Start+$F70C 
Miles_CPU_Jumping                equ M68K_RAM_Start+$F70F
Ring_Pos_Routine                 equ M68K_RAM_Start+$F710
Title_Card_Flag                  equ M68K_RAM_Start+$F711
CNz_Triangle_Pos_Routine         equ M68K_RAM_Start+$F71A
CNz_Triangle_Pos_Flag            equ M68K_RAM_Start+$F71B
CNz_Triangle_Pos_Start           equ M68K_RAM_Start+$F71C
CNz_Triangle_Pos_End             equ M68K_RAM_Start+$F720
CNz_Triangle_Pos_Start_2P        equ M68K_RAM_Start+$F724
CNz_Triangle_Pos_End_2P          equ M68K_RAM_Start+$F728
Palette_Cycle_Flag               equ M68K_RAM_Start+$F72E
Water_Level_Flag                 equ M68K_RAM_Start+$F730
Demo_Button_Index_2P             equ M68K_RAM_Start+$F732
Demo_Button_Press_Counter_2P     equ M68K_RAM_Start+$F734
Carrying_Sonic_Data              equ M68K_RAM_Start+$F73E
Art_Scaling_Data_Buffer          equ M68K_RAM_Start+$F740
Art_Scaling_Index_0              equ M68K_RAM_Start+$F744
Art_Scaling_Index_1              equ M68K_RAM_Start+$F746
Art_Scaling_Index_2              equ M68K_RAM_Start+$F748
Art_Scaling_Result_0             equ M68K_RAM_Start+$F74A
Art_Scaling_Result_1             equ M68K_RAM_Start+$F74E
Art_Scaling_Result_2             equ M68K_RAM_Start+$F752
Art_Scaling_Address              equ M68K_RAM_Start+$F75C
Sonic_Max_Speed                  equ M68K_RAM_Start+$F760
Sonic_Acceleration               equ M68K_RAM_Start+$F762
Sonic_Deceleration               equ M68K_RAM_Start+$F764
Sonic_Previous_Frame             equ M68K_RAM_Start+$F766
Primary_Angle                    equ M68K_RAM_Start+$F768
Secondary_Angle                  equ M68K_RAM_Start+$F76A
Object_Pos_Routine               equ M68K_RAM_Start+$F76C
Camera_X_Current                 equ M68K_RAM_Start+$F76E
Object_Pos_Next                  equ M68K_RAM_Start+$F770
Object_Pos_Previous              equ M68K_RAM_Start+$F774
Camera_X_Current_P2              equ M68K_RAM_Start+$F78C
Demo_Button_Index                equ M68K_RAM_Start+$F790
Demo_Button_Press_Counter        equ M68K_RAM_Start+$F792
Demo_Pal_FadeOut_Counter         equ M68K_RAM_Start+$F794
Current_Collision_Ptr            equ M68K_RAM_Start+$F796
Boss_Flag                        equ M68K_RAM_Start+$F7AA
Sonic_LBz_Cylinder_Angle         equ M68K_RAM_Start+$F7B2
Miles_LBz_Cylinder_Angle         equ M68K_RAM_Start+$F7B3 
Primary_Collision_Ptr            equ M68K_RAM_Start+$F7B4
Secondary_Collision_Ptr          equ M68K_RAM_Start+$F7B8
S1_Load_Big_Ring_Art_Flag        equ M68K_RAM_Start+$F7BE  
Wind_Tunnels_Flag                equ M68K_RAM_Start+$F7C7
Sonic_Wind_Flag                  equ M68K_RAM_Start+$F7C8 
Miles_Wind_Flag                  equ M68K_RAM_Start+$F7C9 
Control_Locked_Flag_P1           equ M68K_RAM_Start+$F7CC 
Special_Stage_Entry_Flag         equ M68K_RAM_Start+$F7CD
Control_Locked_Flag_P2           equ M68K_RAM_Start+$F7CF 
Enemy_Hit_Chain_Count            equ M68K_RAM_Start+$F7D0
Level_Results_Time_Bonus         equ M68K_RAM_Start+$F7D2
Level_Results_Ring_Bonus         equ M68K_RAM_Start+$F7D4
HUD_Results_Refresh_Flag         equ M68K_RAM_Start+$F7D6
Camera_X_Left                    equ M68K_RAM_Start+$F7DA 
Camera_X_Left_P2                 equ M68K_RAM_Start+$F7DC
Miles_Previous_Frame             equ M68K_RAM_Start+$F7DE
Miles_Tails_Previous_Frame       equ M68K_RAM_Start+$F7DF
; Refresh_Level_Layout             equ M68K_RAM_Start+$F7E0
Level_Trigger_Array              equ M68K_RAM_Start+$F7E0
Animate_Counters                 equ M68K_RAM_Start+$F7F0
Sprite_Table_Buffer              equ M68K_RAM_Start+$F800
Boss_Data_Buffer                 equ M68K_RAM_Start+$FA80
;Tmp_FA81                         equ M68K_RAM_Start+$FA81
;Tmp_FA82                         equ M68K_RAM_Start+$FA82
;Tmp_FA83                         equ M68K_RAM_Start+$FA83
;Tmp_FA8A                         equ M68K_RAM_Start+$FA8A
;Tmp_FA8B                         equ M68K_RAM_Start+$FA8B
Target_Camera_Max_X              equ M68K_RAM_Start+$FA92
Target_Camera_Min_X              equ M68K_RAM_Start+$FA94
Target_Camera_Min_Y              equ M68K_RAM_Start+$FA96
Target_Camera_Max_Y              equ M68K_RAM_Start+$FA98
Slotted_Objects_Bits             equ M68K_RAM_Start+$FA9A
Boss_Attack_Started              equ M68K_RAM_Start+$FAA2
Boss_Defeated_Flag               equ M68K_RAM_Start+$FAA3
Obj_Knuckles_Mem_Address         equ M68K_RAM_Start+$FAA4
Obj_End_Panel_Mem_Address        equ M68K_RAM_Start+$FAA6
Player_Control_Lock_Flag         equ M68K_RAM_Start+$FAA8
Knuckles_Control_Lock_Flag       equ M68K_RAM_Start+$FAA9
End_Level_Flag                   equ M68K_RAM_Start+$FAAA
Palette_Rotation_Custom          equ M68K_RAM_Start+$FADA
Palette_Rotation_Data            equ M68K_RAM_Start+$FADE
Object_Respawn_Table             equ M68K_RAM_Start+$FB00

S2_Palette_Buffer                equ M68K_RAM_Start+$FB00
S2_Palette_Row_0_Offset          equ S2_Palette_Buffer
S2_Palette_Row_1_Offset          equ S2_Palette_Buffer+$0020

Stack_Area                       equ M68K_RAM_Start+$FD00  
Stack_Area_End                   equ M68K_RAM_Start+$FE00 
Restart_Level_Flag               equ M68K_RAM_Start+$FE02
Level_Frame_Count                equ M68K_RAM_Start+$FE04
Debug_Mode_Object_Index          equ M68K_RAM_Start+$FE06 
Debug_Mode_Flag_Index            equ M68K_RAM_Start+$FE08 
Debug_Mode_Camera_Delay          equ M68K_RAM_Start+$FE0A
Debug_Mode_Camera_Speed          equ M68K_RAM_Start+$FE0B 
Vertical_Interrupt_Count         equ M68K_RAM_Start+$FE0C

; Gonna eventually do the whole thing like this, but for now only a few variables
		pusho						; save options
		opt	ae+					; enable auto evens

		rsset M68K_RAM_Start+$FE10
Current_ZoneAndAct:		rs.w	1					; 2 bytes; not to be confused with Apparent_ZoneAndAct,
										; this actually holds the real zone the player is in
Current_Zone:			equ	Current_ZoneAndAct
Current_Act:			equ	Current_ZoneAndAct+1
Life_count:			rs.b	1					; current lives; not the lives displayed on the screen
				rs.b	3					; unused
Current_SpecialStage:		rs.w	1					; 2 bytes, although only the first is used
Continue_count:			rs.b	1					; current continues
Super_Sonic_flag:		rs.b	1					; whether or not Sonic is in his Super transformation
Time_Over_flag:			rs.b	1					; determines if the player got a Game or Time over
Extra_life_flags:		rs.b	1					; flag for giving the player a 1UP at 100 or 200 rings

; If set, the respective HUD element will be updated.
Update_HUD_lives:		rs.b	1
Update_HUD_rings:		rs.b	1
Update_HUD_timer:		rs.b	1
Update_HUD_score:		rs.b	1
		popo						; restore options

Ring_Count_Address               equ M68K_RAM_Start+$FE20
Time_Count_Address               equ M68K_RAM_Start+$FE22
Timer_Minute_Count_Address       equ M68K_RAM_Start+$FE23
Timer_Second_Count_Address       equ M68K_RAM_Start+$FE24
Timer_Centiseconds_Count_Address equ M68K_RAM_Start+$FE25
Score_Count_Address              equ M68K_RAM_Start+$FE26
Saved_Level_Flag                 equ M68K_RAM_Start+$FE30
Saved_Last_Start_Post_Hit        equ M68K_RAM_Start+$FE31
Saved_Obj_X_P1                   equ M68K_RAM_Start+$FE32
Saved_Obj_Y_P1                   equ M68K_RAM_Start+$FE34
Saved_Ring_Count_Address         equ M68K_RAM_Start+$FE36
Saved_Time                       equ M68K_RAM_Start+$FE38
Saved_Obj_Art_VRAM_P1            equ M68K_RAM_Start+$FE3C
Saved_Top_Solid_P1               equ M68K_RAM_Start+$FE3E
Saved_Camera_X                   equ M68K_RAM_Start+$FE40
Saved_Camera_Y                   equ M68K_RAM_Start+$FE42
Saved_Current_Water_Level        equ M68K_RAM_Start+$FE50
Saved_Underwater_Flag            equ M68K_RAM_Start+$FE53
Saved_Ring_Status_Flag           equ M68K_RAM_Start+$FE54
Saved_Ring_Status_Flag_P2        equ M68K_RAM_Start+$FE55
Saved_Sonic_Level_Limits_Max_Y   equ M68K_RAM_Start+$FE56
Saved_Dynamic_Resize_Routine     equ M68K_RAM_Start+$FE58
Dropdash_flag:			equ M68K_RAM_Start+$FE5A			; checks if Sonic is currently 'dropdashing'
Oscillate_Data_Buffer            equ M68K_RAM_Start+$FE5E
Object_Frame_Timer               equ M68K_RAM_Start+$FEA2
Object_Frame_Buffer              equ M68K_RAM_Start+$FEA3
Object_Frame_Anim_Counter        equ M68K_RAM_Start+$FEA6
Object_Frame_Anim_Frame          equ M68K_RAM_Start+$FEA7
Object_Frame_Anim_Accum          equ M68K_RAM_Start+$FEA8
Object_Frame_Angle               equ M68K_RAM_Start+$FEAA
LRz_Rocks_Routine                equ M68K_RAM_Start+$FEB0
LRz_Rocks_Pos_Next               equ M68K_RAM_Start+$FEB2
LRz_Rocks_Pos_Previous           equ M68K_RAM_Start+$FEB6  
Miles_Max_Speed                  equ M68K_RAM_Start+$FEC0
Miles_Acceleration               equ M68K_RAM_Start+$FEC2
Miles_Deceleration               equ M68K_RAM_Start+$FEC4
Life_Count_P2                    equ M68K_RAM_Start+$FEC6
Ring_Status_Flag_P2              equ M68K_RAM_Start+$FEC7 ; Vida extra com 100 e 200 anéis e continue
HUD_Life_Refresh_Flag_P2         equ M68K_RAM_Start+$FEC8
HUD_Rings_Refresh_Flag_P2        equ M68K_RAM_Start+$FEC9
HUD_Timer_Refresh_Flag_P2        equ M68K_RAM_Start+$FECA
HUD_Score_Refresh_Flag_P2        equ M68K_RAM_Start+$FECB
Time_Over_Flag_P2                equ M68K_RAM_Start+$FECC
Ring_Count_Address_P2            equ M68K_RAM_Start+$FED0
Time_Count_Address_P2            equ M68K_RAM_Start+$FED2   
Timer_Minute_Count_Address_P2    equ M68K_RAM_Start+$FED3
Score_Count_Address_P2           equ M68K_RAM_Start+$FED6
Saved_Level_Flag_P2              equ M68K_RAM_Start+$FEE0
Saved_Last_Start_Post_Hit_P2     equ M68K_RAM_Start+$FEE1
Saved_Obj_X_P2                   equ M68K_RAM_Start+$FEE2
Saved_Obj_Y_P2                   equ M68K_RAM_Start+$FEE4
Saved_Ring_Count_Address_P2      equ M68K_RAM_Start+$FEE6
Saved_Time_Count_Address_P2      equ M68K_RAM_Start+$FEE8
Saved_Obj_Art_VRAM_P2            equ M68K_RAM_Start+$FEEC
Saved_Top_Solid_P2               equ M68K_RAM_Start+$FEEE
Total_Ring_Count_Address         equ M68K_RAM_Start+$FEF0
Total_Ring_Count_Address_P2      equ M68K_RAM_Start+$FEF2
Monitors_Broken                  equ M68K_RAM_Start+$FEF4
Monitors_Broken_P2               equ M68K_RAM_Start+$FEF6
Loser_Timer_Left                 equ M68K_RAM_Start+$FEF8
Competition_Laps_To_Win          equ M68K_RAM_Start+$FEFA
Competition_Lap_Count_P1         equ M68K_RAM_Start+$FEFC
Competition_Lap_Count_P2         equ M68K_RAM_Start+$FEFD
Results_Screen_2P                equ M68K_RAM_Start+$FF02
Remainning_Rings_Count           equ M68K_RAM_Start+$FF04
Perfect_Bonus_Rings_Flag         equ M68K_RAM_Start+$FF06 
Player_Selected_Flag             equ M68K_RAM_Start+$FF08 
Player_Select_Flag               equ M68K_RAM_Start+$FF0A 
Two_Player_Items_Mode            equ M68K_RAM_Start+$FF0C
Kosinski_Mod_Queue_Count         equ M68K_RAM_Start+$FF0E
Kosinski_Saved_Registers         equ M68K_RAM_Start+$FF10 
Kosinski_Saved_SR                equ M68K_RAM_Start+$FF38
Kosinski_Bookmark                equ M68K_RAM_Start+$FF3A
Kosinski_Description_Field       equ M68K_RAM_Start+$FF3E
Kosinski_Decomp_Queue            equ M68K_RAM_Start+$FF40
Kosinski_Decomp_Destination      equ M68K_RAM_Start+$FF44
Kosinski_Modules_Left            equ M68K_RAM_Start+$FF60
Kosinski_Module_Size             equ M68K_RAM_Start+$FF62
Kosinski_Mod_Queue               equ M68K_RAM_Start+$FF64
Kosinski_Mod_Destination         equ M68K_RAM_Start+$FF68
Tmp_FF7C                         equ M68K_RAM_Start+$FF7C
Tmp_FF7E                         equ M68K_RAM_Start+$FF7E
Level_Select_Hold_Timer          equ M68K_RAM_Start+$FF80 
Level_Select_Menu_Cursor         equ M68K_RAM_Start+$FF82  
Sound_Test_Sound                 equ M68K_RAM_Start+$FF84
Title_Screen_Menu_Cursor         equ M68K_RAM_Start+$FF86
Level_Id_2P                      equ M68K_RAM_Start+$FF88
Act_Id_2P                        equ Level_Id_2P+$01
Two_Player_Flag_2                equ M68K_RAM_Start+$FF8A
Options_Menu_Cursor              equ M68K_RAM_Start+$FF8C
Level_Results_Total_Bonus        equ M68K_RAM_Start+$FF8E
Level_Music_Buffer               equ M68K_RAM_Start+$FF90
Game_Over_2P_Flag                equ M68K_RAM_Start+$FF98
SS_Completed_Flag                equ M68K_RAM_Start+$FFB0 
Emeralds_Count                   equ M68K_RAM_Start+$FFB1
Emerald_Collected_Flag_List      equ M68K_RAM_Start+$FFB2 

Title_Screen_Animate_Buffer      equ M68K_RAM_Start+$FFBC
Title_Screen_Animate_Delay       equ M68K_RAM_Start+$FFBD
Title_Screen_Animate_Frame       equ M68K_RAM_Start+$FFBE
                             
Next_Extra_Life_Score            equ M68K_RAM_Start+$FFC0
Next_Extra_Life_Score_P2         equ M68K_RAM_Start+$FFC4
End_Level_Art_Load_Flag          equ M68K_RAM_Start+$FFC8
Debug_Player_Obj_Map             equ M68K_RAM_Start+$FFCA
Debug_Player_Obj_Art_VRAM        equ M68K_RAM_Start+$FFCE
Level_Select_Flag                equ M68K_RAM_Start+$FFD0 
Slow_Motion_Flag                 equ M68K_RAM_Start+$FFD1
Debug_Mode_Flag                  equ M68K_RAM_Start+$FFD2
Secret_Code_Input_Entries        equ M68K_RAM_Start+$FFD4
Secret_Code_Input_Entries_2      equ Secret_Code_Input_Entries+$02
Two_Player_Flag                  equ M68K_RAM_Start+$FFD8 
Menu_Player_One_Cursor           equ M68K_RAM_Start+$FFDA
Menu_Player_Two_Cursor           equ M68K_RAM_Start+$FFDB 
CNz_Triangle_Angle_Buffer        equ M68K_RAM_Start+$FFDC 
Sound_Buffer_Id                  equ M68K_RAM_Start+$FFE4
Auto_Control_Player_Flag         equ M68K_RAM_Start+$FFF0
Demo_Sequence_Idx                equ M68K_RAM_Start+$FFF2
End_Demo_Sequence_Idx            equ M68K_RAM_Start+$FFF4
Vertical_Frequency               equ M68K_RAM_Start+$FFF6
Hardware_Id                      equ M68K_RAM_Start+$FFF8 
Debug_Mode_Active                equ M68K_RAM_Start+$FFFA
Init_Flag                        equ M68K_RAM_Start+$FFFC 

; CRAM
Color_RAM_Address              equ $C0000000

; Variaveis para os menus exceto seleção de fases que é comprimido
__                      equ  $00
_0                      equ  $10
_1                      equ  $11
_2                      equ  $12  
_st                     equ  $1A  ; estrela no sound test
_A                      equ  $1E
_B                      equ  $1F 
_C                      equ  $20
_D                      equ  $21
_E                      equ  $22
_F                      equ  $23
_G                      equ  $24
_H                      equ  $25 
_I                      equ  $26
_J                      equ  $27
_K                      equ  $28
_L                      equ  $29
_M                      equ  $2A 
_N                      equ  $2B 
_O                      equ  $2C
_P                      equ  $2D
_Q                      equ  $2E
_R                      equ  $2F
_S                      equ  $30
_T                      equ  $31
_U                      equ  $32
_V                      equ  $33
_W                      equ  $34
_X                      equ  $35
_Y                      equ  $36
_Z                      equ  $37  