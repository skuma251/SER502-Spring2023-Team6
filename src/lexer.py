import sys
import ply.lex as lex

tokens = ('RES',
            'INT',
            'OPERATOR',
            )

def t_RES(t):
    r'int|string|bool|print'
    return t

def t_INT(t):
    r'\d+'
    return t

def t_OPERATOR(t):
    r'[-+*/%<>&|^~]|==|='
    if t.value == '==':
        t.type = 'OPERATOR'
    return t

t_ignore = ' \t\n'

def t_error(t):
    raise TypeError("Unknown text '%s'" % (t.value,))


if __name__ == "__main__":
    fileName = sys.argv[1]
    if fileName.endswith(".xyz"):
        f = open(fileName, "r")
        Lines = f.readlines() 
        for line in Lines:
            line = line.rstrip()
            if line:
                lexer = lex.lex()
                lexer.input(line)
                for tok in iter(lexer.token, None):
                    print(tok.value)
    else:
        print("Please pass file name with .xyz extension")
