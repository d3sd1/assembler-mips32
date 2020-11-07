
##EJERCICIO 1
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
        li $a0, 0
      	li $a1, 4	# M <- $a1 (M = 4)
      	li $a2, 7	# N <- $a2 (N = 7)
        mul $a0, $a1, $a2 # A = MxN
        #Si los valores de M o N son menores que 0, se dirige a fin_error
        blez $a1, fin_error 
        blez $a2, fin_error
        # for(i=0; i<=M, i++)
      	li $t0, 0	# i = $t0 (iniciado a 0)
bucle1: bge $t0, $a1, fin1	#Cuando i >= M, ir a fin_1
		# for(j=0, j<=N, j++)
        li $t1, 0	# j = $t1 (iniciado a 0)
bucle2: bge $t1, $a2, fin2	#Cuando j >= N, ir a fin_2 		
			# Dirección del elemento (i,j)
			mul  $t3 $t0 $a2 # i*N <- $t3
            add  $t3 $t3 $t1 # + j
            mul  $t3 $t3 4   # * 4
            add  $t3 $a0 $t3 # A + (i*N + j)*4
            # A[i][j] = 0
            sw $zero, ($t3) # memoria[$t3] = 0			
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
        
 fin_error: li $v0 -1	#Resultado en caso de error
 			lw $a2, 4($sp)
    		lw $a1, 8($sp)
   			lw $a0, 12($sp)
    		addu $sp, $sp, 12
 			jr $ra	#Return

   main:
    	jal init
#add(int A[][], int M, int N, int i, int j, int k, int l)
# A -> Matriz MxN.
# M -> Número de filas.
# N -> Número de columnas.
#Suma los valores de la matriz comprendidos entre los elementos (i,j) y (k,l)