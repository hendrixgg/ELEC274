Vim�UnDo� p��]Y\f�}q�\x�|�b�S���n�B�$�\^   !                   6   6   6   6   5    e�"�    _�                            ����                                                                                                                                                                                                                                                                                                                                                             e��     �                   5��                                                  �                                              �                                                �                                                �                                               5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             e��     �               �               5��                                         $       5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             e��     �                 .text    5��                                                  5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             e�      �                  �               5��                          $                      �                          $                      �                       O   %               O       �       N                 s                     �       P                  u                      5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             e�     �                5��                          $                      �                        ,                     5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             e�     �               # write instructions here.5��                        &                     5�_�      	                     ����                                                                                                                                                                                                                                                                                                                                                             e�"     �                  �               5��                          �                      �                       %   �               %       5�_�      
           	      $    ����                                                                                                                                                                                                                                                                                                                                                             e�0     �                  �               5��                          �                      �                          �                      �                          �                      5�_�   	              
           ����                                                                                                                                                                                                                                                                                                                                                             e�4    �             5��                          �                      5�_�   
                         ����                                                                                                                                                                                                                                                                                                                                                             e�O     �         	       �             5��                          $                      �                          $                      5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             e�T     �         	      _start:5��                          $                      5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             e�X     �      	          �         
    5��                          H                      �                          H                      �                         M                      �                          N                      5�_�                    
        ����                                                                                                                                                                                                                                                                                                                                                             e��     �   	             5��    	                      �                      �    
                      �                      �    
                      �                      5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             e��     �             �             5��                          �                      5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             e��     �   
              5��    
                      �                      5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             e��    �             5��                          H                      5�_�                            ����                                                                                                                                                                                                                                                                                                                                                  V        e��     �                  .text   .global _start   .org    0x0000       _start:   # Write instructions here.       _end:       br _end   P#------------------------------------------------------------------------------#               .org    0x1000   %# Write constants and variables here.    5�5�_�                            ����                                                                                                                                                                                                                                                                                                                                                  V        e��     �                5��                          H                      �                         K                      �                         K                      �                        J                     �                         K                      �                          L                      �                     	   Q              	       �                     -   Y              -       �       :                 �                      �                         �                      �                        �                     �                        �                     �                        �                     �       -                 �                     �       C                 �                      �    	                     �                     �    	                    �                     �    	                     �                      �    	                     �                      �    
                      �                      �    
                      �                      �    	                     �                      �    	                     �                      �    	                 $   �              $       �    	   '                 �                     �    	   ,                 �                     �    	   E                                     �    	   J                                       �    
                                           �    
                                        �    
                    #                    �    
   !                 7                    �    
                    4                    �    
   #                 9                    �    
   B                 X                     �                         ]                     �                         w                     5�_�                       B    ����                                                                                                                                                                                                                                                                                                                                                  V        e�V     �   
            B    movi    r3, 1           # The Then task (for when A equals 0).5��    
   A                  W                     5�_�                           ����                                                                                                                                                                                                                                                                                                                                                  V        e�X     �                   stw     r2, B(r0)       # 5��                         v                     �       2                 �                     �                      !   �              !       �       $                 �                    �       $                 �                    �       %                 �                    �       A                 �                    5�_�                    
   I    ����                                                                                                                                                                                                                                                                                                                                                  V        e��     �   	            JTHEN:                       # Optional label; marks the start of the Then.5��    	   I                                       �    	   I                                       5�_�                    
   I    ����                                                                                                                                                                                                                                                                                                                                                  V        e��     �   	            JTHEN:                       # Optional label; marks the start of the Then.5��    	   I                                       5�_�                           ����                                                                                                                                                                                                                                                                                                                                                  V        e��     �               E    br END_IF               # Skip Else task and go to the end of If.5��                         �                     5�_�                       !    ����                                                                                                                                                                                                                                                                                                                                                  V        e��     �               J    br      END_IF               # Skip Else task and go to the end of If.5��                         �                     5�_�                       E    ����                                                                                                                                                                                                                                                                                                                                                  V        e��     �               E    br      END_IF          # Skip Else task and go to the end of If.5��       E                 �                     �                         �                    �                         �                     �                          �                     �                     8   �             8       �       D                 !                     �                         &                     �                        *                    �                        6                    �       2                 T                     �                          U                     �                         U                     �                          V                     �                          U                     �                          U                     �                        W                    �                         U                    �                         \                     �                          ]                     �                         ]                    �                         ]                    �                        _                    5�_�                           ����                                                                                                                                                                                                                                                                                                                                                  V        e��     �               
# put the 5��                        _                    5�_�                       	    ����                                                                                                                                                                                                                                                                                                                                                  V        e��     �               
# Put the 5��       	                  f                     �                        i                    �                         |                     5�_�                           ����                                                                                                                                                                                                                                                                                                                                                  V        e�     �                # Put the next instruction here 5��                         x                     5�_�                           ����                                                                                                                                                                                                                                                                                                                                                  V        e�     �               # Put the next instruction e 5��                         x                     5�_�      !                      ����                                                                                                                                                                                                                                                                                                                                                  V        e�     �               # Put the next instruction  5��                         x                     5�_�       "           !          ����                                                                                                                                                                                                                                                                                                                                                  V        e�     �               # Put the next instruction 5��                        w                    5�_�   !   #           "          ����                                                                                                                                                                                                                                                                                                                                                  V        e�     �               !# Put the next instructions here.5��                         c                     5�_�   "   $           #          ����                                                                                                                                                                                                                                                                                                                                                  V        e�     �               # Put next instructions here.5��                         c                     5�_�   #   %           $          ����                                                                                                                                                                                                                                                                                                                                                  V        e�    �               # Put instructions here.5��                         c                     �                        m                    5�_�   $   &           %          ����                                                                                                                                                                                                                                                                                                                                                  V        e�"    �             5��                          �                     5�_�   %   '           &          ����                                                                                                                                                                                                                                                                                                                                                  V        e�    �               # Write instructions here.5��                         5                      �                        ;                     5�_�   &   )           '           ����                                                                                                                                                                                                                                                                                                                                                  V        e�2    �                IF:   :    ldw     r2, A(r0)       # Read value of A from memory.   C    bne     r2, r0, ELSE    # Branch to ELSE task if A not equal 0.   PTHEN:                       # Optional label; marks the start of the Then block.   A    movi    r3, 1           # The Then task (for when A equals 0)   2    stw     r2, B(r0)       #   which sets B to 1.   E    br      END_IF          # Skip Else task and go to the end of If.   ELSE:   D    movi    r3, 2           # The Else task (for when A not equal 0)   2    stw     r3, C(r0)       #   which sets C to 2.   END_IF:   ## Put subsequent instructions here.5��                          P       9              5�_�   '   *   (       )           ����                                                                                                                                                                                                                                                                                                                                                             e��     �               �               5��                          �               =      5�_�   )   .           *           ����                                                                                                                                                                                                                                                                                                                                                  V        e��     �                 .text   .global _start   .org    0x0000       _start:   "# Write initial instructions here.       _end:       br _end   P#------------------------------------------------------------------------------#               .org    0x1000   %# Write constants and variables here.    5��                                   �               5�_�   *   /   ,       .           ����                                                                                                                                                                                                                                                                                                                                                  V        e��     �                   �             5��                          �                     �                         �                     �                        �                    �                        �                    5�_�   .   0           /          ����                                                                                                                                                                                                                                                                                                                                                  V        e�      �                   movi    r3, r05��                        �                    5�_�   /   1           0          ����                                                                                                                                                                                                                                                                                                                                                  V        e�     �                   mov     r3, r05��                      2   �              2       5�_�   0   2           1           ����                                                                                                                                                                                                                                                                                                                                                 v       e� e    �                .text5��                                                  �                                                  5�_�   1   3           2          ����                                                                                                                                                                                                                                                                                                                                                 v       e� �   	 �               D    mov     r3, r0              # Set the value in the list to zero.5��                        �                    5�_�   2   4           3      C    ����                                                                                                                                                                                                                                                                                                                               C                 v       e�"S     �               D    mov     r5, r0              # Set the value in the list to zero.�             5��              @       *   �      @       *       5�_�   3   5           4      H    ����                                                                                                                                                                                                                                                                                                                               C                 v       e�"^     �   
            H    add     r4, r4, r5          # Add element to accumulating sum in r4.5��    
   H                 �                     �                          �                     5�_�   4   6           5      .    ����                                                                                                                                                                                                                                                                                                                               C                 v       e�"_    �                .    stw		r0, 0(r3)			# Set list value to zero.5��       .                 �                     �                         �                     �                         �                     5�_�   5               6          ����                                                                                                                                                                                                                                                                                                                               C       -          v       e�"�     �         !    �         !      	    .text   .global _start   .org    0x0000       6_start:                         # == INITIALIZATION ==   Dldw     r2, N(r0)           # r2 is the loop counter (decrementing).   Emovi    r3, LIST            # r3 points to the first element in LIST.   5movi    r4, 0               # r4 accumulates the sum.   LOOP:   =    ldw     r5, 0(r3)           # Got next element from LIST.   H    add     r4, r4, r5          # Add element to accumulating sum in r4.   D    mov     r3, r0              # Set the value in the list to zero.   ;    addi    r3, r3, 4           # Advance the LIST pointer.   S    subi    r2, r2, 1           # (start of branching code) decrement loop counter.   O                                # Could actually just be storing a pointer to     M                                # one after the last element in the array and   R                                # branch whenever r3 is not equal to that pointer.   G    bgt     r2, r0, LOOP        # Branch if count has not reached zero.       J    stw     r4, SUM(r0)         # Write final accumulated value to memory.   _end:       br      _end       P#------------------------------------------------------------------------------#               .org    0x1000   MSUM:    .skip   4               # Reserve 4 bytes of space for the final sum.   LN:      .word   5               # Indicate that there are N=5 items in LIST.   SLIST:   .word   12, 0xFFFFFFFE, 7, -1, 2    # Hex value is -2 in two's-complement.                .end5��                        �              �      5�_�   *   -   +   .   ,           ����                                                                                                                                                                                                                                                                                                                                                  V        e��     �                   �                    5��                          �                     �                          �                     �                         �                     �                          �                     5�_�   ,               -           ����                                                                                                                                                                                                                                                                                                                                                  V        e��     �                        5��                          �                     �                          �                     5�_�   *           ,   +           ����                                                                                                                                                                                                                                                                                                                                                  V        e��     �                                                �                5��                          +              !       �                           +                      5�_�   '           )   (           ����                                                                                                                                                                                                                                                                                                                                                  V        e�6     �              5��                          �       &               5�_�                           ����                                                                                                                                                                                                                                                                                                                                                  V        e�
     �               # Put the next e 5��                         l                     5�_�                             ����                                                                                                                                                                                                                                                                                                                                                             e��     �                 (left shift by 2 (multiply by 4) so that 5��                                                  �                       	                  	       �                                              �                                              5��