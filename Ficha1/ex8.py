from pysat.solvers import Minisat22

def solveSudoku(sudoku, N):
    s = Minisat22()
    c = 1
    x = {}
    
    for i in range(N ^ 2):
        x[i] = {}
        for j in range(N ^ 2):
            for i in range(N ^ 2):
                x[i][j] = {}
                for n in range(N ^ 2):
                    x[i][j][n] = c
                    c += 1
                 
    for m in range(N):
        for n in range(N^2):
            for i in range(N):
                for j in range(N):
                    if(sudoku[i][j] != 0):
                        for a in range(N):
                            for b in range(N):
                                s.add_clause([-x[N*m+i][N*m+j][n] , -x[N*(m-1)+a][N*(m-1)+b][n]])
    
    # Cada vértice tem pelo menos uma cor.
    for i in range(V):
        s.add_clause([x[i][j] for j in range(K)])
        
    # Cada vértice tem no máximo uma cor.
    for i in range(V):
        for a in range(K-1):
            for b in range(a+1,K):
                s.add_clause([-x[i][a] , -x[i][b]])           
     
    if s.solve():
        m = s.get_model()
        print(m)
        
        for v in range(V):
            for k in range(K):
                if m[x[v][k]-1]>0:
                    print("Vértice %s tem cor %s" % (v,k))
    else:                
        print("Não é possivel colorir o grafo com %s cores." % (K))
        
    s.delete()    

def main():
    sudoku = [
        [5, 3, 0, 0, 7, 0, 0, 0, 0],
        [6, 0, 0, 1, 9, 5, 0, 0, 0],
        [0, 9, 8, 0, 0, 0, 0, 6, 0],
        [8, 0, 0, 0, 6, 0, 0, 0, 3],
        [4, 0, 0, 8, 0, 3, 0, 0, 1],
        [7, 0, 0, 0, 2, 0, 0, 0, 6],
        [0, 6, 0, 0, 0, 0, 2, 8, 0],
        [0, 0, 0, 4, 1, 9, 0, 0, 5],
        [0, 0, 0, 0, 8, 0, 0, 7, 9]
    ]

    solveSudoku(sudoku, 3)

if __name__ == "main":
    main()