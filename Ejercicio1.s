#EJERCICIO 1

.data 
	.align 2 
    M: .space 1
    N: .space 1
	A: .space 1024	#Asignamos el espacio de memoria que reservamos para la matriz, en este caso 1KB
.text
.globl main

#init(int A[][], int M, int N)
# A -> Matriz MxN.
# M -> Número de filas.
# N -> Número de columnas.
#Inicializa la matriz a 0. Si M <= 0 o N <= 0, retorna -1 como error, en cualquier otro caso devuelve 0.

  init: addu $sp, $sp, -12
	  	sw $a0, 12($sp)
      	sw $a1, 8($sp)
      	sw $a2, 4($sp)
      	la $a0, A
      	li $a1, M	# M <- $a1
      	li $a2, N	# N <- $a2
        #Si los valores de M o N son menores que 0, se dirige a fin_error
        blez $a0, fin_error 
        blez $a1, fin_error
        # for(i=0; i<=M, i++)
      	li $t0, 0	# i = $t0 (iniciado a 0)
bucle1: bge $t0, $a1, fin1	#Cuando i >= M, ir a fin_1
		# for(j=0, j<=N, j++)
        li $t1, 0	# j = $t1 (iniciado a 0)
bucle2: bge $t1, $a2, fin2	#Cuando j >= N, ir a fin_2 		
			
 		addi $t1 $t1, 1	#j++
 		b bucle2
  fin2:
 		addi $t0 $t0, 1	#i++
 		b bucle1
  fin1:	
  		li $v0 0 #Resultado
        lw $a2, 4($sp)
    	lw $a1, 8($sp)
   		lw $a0, 12($sp)
    	addu $sp, $sp, 12
 		jr $ra	#Return
        
 fin_error: li $v0 -1
 			jr $ra
   main:
	#Prueba 1: init(A, 5, 7)
		la $a0, A	
    	li $a1, 4 	#Establecemos el valor de $a1 a 4
    	li $a2, 5	#Establecemos el valor de $a2 a 5
    	jal init	#Llamada a la función de inicialización