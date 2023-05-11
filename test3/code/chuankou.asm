;连接方式：KEY0-7 接 74HC373_D0-7,74HC373_CS 接 IOY1,RxD 接 TxD,接地—GND，
; 收发时钟接 1MHZ,74HC377_CS 接 IOY2,74HC377_Q0 接 LED0-7
;结果说明：
;************************;
;*8251 串行通讯(自发自收)*;
;************************;
IOY0 EQU 08A0H
IOY1 EQU 08A8H
IOY2 EQU 08B0H
IOY3 EQU 08B8H
IOY4 EQU 08C0H
IOY5 EQU 08C8H
IO8251A equ 3F0h
IO8251B equ 3F1h
KEY_PORT EQU IOY1
LED_PORT EQU IOY2
start:
MOV DX,IO8251B ;初始化 8251
xor AL,AL
;向 8251 控制端口送 3 个 0
OUT DX,AL ;第 1 个 0
CALL DELAY_0F ;延时
OUT DX,AL ;第 2 个 0
CALL DELAY_0F ;延时
OUT DX,AL ;第 3 个 0
CALL DELAY_0F ;延时
;8251 复位
MOV AL,040h ;向 8251 控制端口送 40H,使其复位
OUT DX,AL
CALL DELAY_0F ;延时
;设置工作方式：1 个停止位(01),无校验(00)，8 个数据位(11),波特率因子为 16(10)
;4e = 01 00 11 10
MOV AL,04eh ;1 个停止位(01),无校验(00)，
;8 个数据位(11),波特率因子为 16(10)
OUT DX,AL
CALL DELAY_0F ;延时
MOV AL, 037h ;向 8251 送控制字允许其发送和接收,且错误标志复位
OUT DX,AL
CALL DELAY_0F ;延时
;准备发送的数据：AL=01h,逐步左移用于发送，接收后现在 LED 上

waitToSend:
MOV DX,IO8251B
IN AL,DX
TEST AL,01 ;发送是否准备好：TxRDY 位
JZ waitToSend
MOV DX, KEY_PORT ;AL:待发送的数据
IN AL, DX
MOV DX,IO8251A
OUT DX,AL ;发送
;CALL DELAY_0F ;延时

waitToReceive:
MOV DX,IO8251B
IN AL,DX
TEST AL,02 ;检查接收是否准备好：RxRDY 位
JZ waitToReceive ;没有,等待
MOV DX,IO8251A ;准备好了则接收数据
IN AL,DX
MOV DX,LED_PORT ;将接收到的字符显示在 LED 上
OUT DX,AL

JMP waitToSend ;再次发送下一个字符
DELAY_0F:
PUSH CX
MOV CX,0Fh;
here1: LOOP here1
POP CX
RET
DELAY_FFF:
PUSH CX
MOV CX,0FFFH;
here2: LOOP here2
POP CX
RET