ORG 0100H

MOV BX, 0FFFFH
MOV SI, 1000H
MOV DI, 1500H

MOV CX, 06H
MOV DX, PROMPT1
MOV AH, 09H
INT 21H

INPUT:MOV AH, 1
INT 21H
MOV [BX+SI], AL
INC SI
LOOP INPUT

MOV SI, 1000H
MOV CX, 06H
LOP:MOV AL, [BX+SI]
MOV [BX+DI], AL
INC SI
INC DI
LOOP LOP

MOV AH, 02H
MOV DL, 20H
INT 21H

MOV DX, PROMPT2
MOV AH, 09H
INT 21H

MOV CX, 06H
MOV DI, 1500H
MOV AH, 02H

OUTPUT:MOV DL, [BX+DI]
INT 21H
INC DI
LOOP OUTPUT

MOV AH, 4CH
INT 21H

PROMPT1 DB 0AH, 0DH, "INPUT 6 CHARACTERS INTO SOURCE ADDRESS",0AH, 0DH, 0
PROMPT2 DB 0AH, 0DH, "DESTINATION DATA:",0AH, 0DH, 0