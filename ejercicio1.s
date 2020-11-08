
# EJERCICIO 1
.text
.globl main

#init(int A[][], int M, int N)
# A -> Matriz MxN.
# M -> Número de filas.
# N -> Número de columnas.
#Inicializa la matriz a 0. Si M <= 0 o N <= 0, retorna -1 como error, en cualquier otro caso devuelve 0.
  init: 
 		addu $sp, $sp, 4
        li $a0, 0
      	sw $a1, 4($sp) 	# M <- $a1 
      	sw $a2, ($sp)	# N <- $a2 
        mul $a0, $a1, $a2 # A = MxN
        blez $a1, fin_error #Si el número de filas, M, es menor o igual que 0 se redirige a fin_error
        blez $a2, fin_error	#Si el número de columnas, N, es menor o igual que 0 se redirige a fin_error
      	li $t0, 0	# i = $t0 (iniciado a 0)
bucle1: bge $t0, $a1, fin1	#Cuando i >= M, ir a fin_1
		# for(j=0, j<=N, j++)
        li $t1, 0	# j = $t1 (iniciado a 0)
bucle2: bge $t1, $a2, fin2	#Cuando j >= N, ir a fin_2 		
			# Dirección del elemento (i,j)  <- $t4
			mul  $t2, $t0, $a2 # i*N <- $t2
            add  $t2, $t2, $t1 # + j
            mul  $t2, $t2, 4   # * 4
            add  $t2, $a0, $t2 # A + (i*N + j)*4
            # A[i][j] = 0
            li $t2, 0 # memoria[$t2] = 0			
 		addi $t1 $t1, 1	#j++
 		b bucle2
  fin2:
 		addi $t0 $t0, 1	#i++
 		b bucle1
  fin1:	
  		li $v0 0 #Resultado
 		jr $ra	#Return
        lw $a1, ($sp) 	
      	lw $a2, 4($sp)
        addu $sp, $sp, 4
        
 fin_error: li $v0 -1	#Resultado en caso de error
 			jr $ra	#Return

#add(int A[][], int M, int N, int i, int j, int k, int l)
# A -> Matriz MxN.
# M -> Número de filas.
# N -> Número de columnas.
#Suma los valores de la matriz comprendidos entre los elementos (i,j) y (k,l)
# i -> entero correspondiente a la fila del primer elemento de la matriz
# j -> entero correspondiente a la columna del primer elemento de la matriz
# k -> entero correspondiente a la fila del último elemento de la matriz 
# l ->  entero correspondiente a la columna del último elemento de la matriz
   add: 
   		li $a0, 0
        addu $sp, $sp, -20
      	sw $a1, 20($sp)	# M <- $a1 
      	sw $a2, 16($sp)	# N <- $a2 
        mul $a0, $a1, $a2 # A = MxN
        blez $a1, fin_error	#Si el número de filas, M, es menor o igual que 0 se redirige a fin_error
        blez $a2, fin_error	#Si el número de columnas, N, es menor o igual que 0 se redirige a fin_error
        sw $t0, 12($sp)	# i <- $t0
        sw $t1, 8($sp)	# j <- $t1
        sw $t2, 4($sp)	# k <- $t2
        sw $t3, ($sp)	# l <- $t3
        jal prueba	#Vemos si los valores se ajustan 
       
        # Dirección del elemento (i,j) <- $t4
		mul  $t4, $t0, $a2 # i*N <- $t4
        add  $t4, $t4, $t1 # + j
        mul  $t4, $t4, 4   # * 4
        add  $t4, $a0, $t4 # A + (i*N + j)*4
        
        # Dirección del elemento (k,l) <- $t5
		mul  $t5, $t2, $a2 # k*N <- $t5
        add  $t5, $t5, $t3 # + l
        mul  $t5, $t5, 4   # * 4
        add  $t5, $a0, $t5 # A + (k*N + l)*4 
        li $t6, 0	#suma = 0
        #Bucle infinito pero no se arreglarlo :(
bucle3: bgt $t0, $t2, fin3	#Si i > k ir a fin3
		beq $t0, $t2, fin5
bucle4: bge $t1, $a2, fin4	#Si j >= N ir a fin4
			add $t6, $t6, $t4
			addi $t1 $t1, 1	#j++
		b bucle4
  fin4: 
  		li $t1, 0
        addi $t0, $t0, 1 #i++
        b bucle3
  fin5: bgt $t2, $t3, fin3	# Si j > l ir a fin3 
  			add $t6, $t6, $t4
            addi $t1 $t1, 1	#j++
  fin3:
   		li $v0 0
        lw $t0, ($sp)
        lw $t1, 4($sp)
        lw $t2, 8($sp)
        lw $t3, 12($sp)
   		lw $a1, 16($sp) 	
      	lw $a2, 20($sp)
        addu $sp, $sp, 20
        jr $ra
        
prueba:	#Comprobamos que los valores no estén fuera de rango, redirigiendo a fin_error
		bgt $t0, $a1, fin_error	#Si i > M 
		bgt $t1, $a2, fin_error	#Si j > N 
		bgt $t2, $a1, fin_error	#Si k > M 
		bgt $t3, $a2, fin_error	#Si l > N 
        blt $t0, $a1, fin_error	#Si i < M 
		blt $t1, $a2, fin_error	#Si j < N 
		blt $t2, $a1, fin_error	#Si k < M  
		blt $t3, $a2, fin_error	#Si l < N 
		blt $t2, $t0, fin_error	#Si k < i 

#extract(int A[][], int M, int N, int B[], int P, int i, int j, int k, int l).
# A -> Matriz MxN.
# M -> Número de filas.
# N -> Número de columnas.
# B -> dirección de inicio de un vector de números enteros de dimensión P
# Almacena en el vector B todos los elementos de la matriz situados entre los índices (i,j) y (k,l)
# i -> entero correspondiente a la fila del primer elemento de la matriz
# j -> entero correspondiente a la columna del primer elemento de la matriz
# k -> entero correspondiente a la fila del último elemento de la matriz 
# l ->  entero correspondiente a la columna del último elemento de la matriz
extract:
		li $a0, 0
        addu $sp, $sp, -24
      	sw $a1, 24($sp)	# M <- $a1 
      	sw $a2, 20($sp)	# N <- $a2 
        mul $a0, $a1, $a2 # A = MxN
        sw $a3, 16($sp) # B
        sw $t0, 12($sp)	# i <- $t0
        sw $t1, 8($sp)	# j <- $t1
        sw $t2, 4($sp)	# k <- $t2
        sw $t3, ($sp)	# l <- $t3
        blez $a1, fin_error	#Si el número de filas, M, es menor o igual que 0 se redirige a fin_error
        blez $a2, fin_error	#Si el número de columnas, N, es menor o igual que 0 se redirige a fin_error
        jal prueba	#Vemos si los valores se ajustan 
        
       	# Dirección del elemento (i,j) <- $t4
		mul  $t4, $t0, $a2 # i*N <- $t4
        add  $t4, $t4, $t1 # + j
        mul  $t4, $t4, 4   # * 4
        add  $t4, $a0, $t4 # A + (i*N + j)*4
        
        # Dirección del elemento (k,l) <- $t5
		mul  $t5, $t2, $a2 # k*N <- $t5
        add  $t5, $t5, $t3 # + l
        mul  $t5, $t5, 4   # * 4
        add  $t5, $a0, $t5 # A + (k*N + l)*4 
   main: #Para las pruebas :3
   		li $a1, 4
        li $a2, 9
    	jal init
       
        