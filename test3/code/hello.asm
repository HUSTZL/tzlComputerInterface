ORG 0100h ;start IP=0100
MOV DX, MESS ;String offset in DX, Segment in DS
MOV AX,0900h ;Call print string bios service
INT 21h ;uOS CALL
MOV AX,04C00h ;exit with code 0 (in AL)
INT 021h ;back to CMD>
MESS DB 0Ah,0Dh,"*** YOU ARE WELLCOME ***",0