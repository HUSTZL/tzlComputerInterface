IOY0 EQU 08A0H
IOY1 EQU 08A8H
IOY2 EQU 08B0H
IOY3 EQU 08B8H
IOY4 EQU 08C0H
IOY5 EQU 08C8H
LED_PORT EQU IOY3
;74HC377_CS---IOY3 74HC377_Q0~7---LED_L0~L7
ORG 0100h
MOV DX, LED_PORT
LED_LOOP:
MOV AL, 01H
RIGHT:
OUT DX, AL
CALL DELAY
SHL AL, 1
JNZ RIGHT
MOV AL, 80H
LEFT:
OUT DX, AL
CALL DELAY
SHR AL, 1
JNZ LEFT
JMP LED_LOOP
DELAY:
MOV CX, 0FFFFH
BACK:
DEC CX
JNZ BACK
RET