import sys
import ply.lex as lex

tokens = ('RES',
          'CONTROL_STATEMENT',
            'INT',
            'IDENTIFIER',
            'OPERATOR',
            'SPECIAL_CHAR',
            'LEFT_BRACE', 'RIGHT_BRACE'
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

def t_CONTROL_STATEMENT(t):
    r'for|in|range|while|if|then|else'
    return t

def t_IDENTIFIER(t):
    r'[a-zA-Z_][a-zA-Z_0-9]*'
    return t

def t_SPECIAL_CHAR(t):
    r'.|;'
    return t

def t_LEFT_BRACE(t):
    r'{'
    return t

def t_RIGHT_BRACE(t):
    r'}'
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
