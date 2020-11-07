#EJERCICIO 1

.data 
	.align 2 
	A: .space 1024	#Asignamos el espacio de memoria que reservamos para la matriz, en este caso 1KB
	M: .space 1
    N: .space 1
.text
.globl main

#init(int A[][], int M, int N)
# A -> Matrix MxN.
# M -> Número de filas.
# N -> Número de columnas.
#Inicializa la matriz a 0. Si M <= 0 ó N <= 0, devolverá -1, en cualquier otro caso devuelve 0.

init:
	addu $sp, $sp, -12
    sw $a0, 12($sp)
    sw $a1, 8($sp)
    sw $a2, 4($sp)
    la $a0, A
    li $a1, M
    li $a2, N	
    li $t0, 0	# i = $t0
for_1: bge $t0, $a1, fin_1
    
fin_1:

    lw $a2, 4($sp)
    lw $a1, 8($sp)
    lw $a0, 12($sp)
    addu $sp, $sp, 12
	jr $ra
    
main:
	#Prueba 1: init(A, 5, 7)
	la $a0, A	
    li $a1, 4 	#Establecemos el valor de $a1 a 4
    li $a2, 5	#Establecemos el valor de $a2 a 5
    jal init	#Llamada a la función de inicialización