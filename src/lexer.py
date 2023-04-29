import sys
import ply.lex as lex
import os 
import subprocess

tokens = ('RES',
          'CONTROL_STATEMENT',
          'INT',
          'IDENTIFIER',
          'OPERATOR',
          'BOOLEAN',
          'SPECIAL_CHAR',
          'LEFT_BRACE',
          'RIGHT_BRACE',
          'LEFT_PARAN',
          'RIGHT_PARAN'
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

def t_BOOLEAN(t):
    r'true|false|and|or|not'
    return t

def t_LEFT_BRACE(t):
    r'{'
    return t


def t_RIGHT_BRACE(t):
    r'}'
    return t


def t_LEFT_PARAN(t):
    r'\('
    return t


def t_RIGHT_PARAN(t):
    r'\)'
    return t


t_ignore = ' \t\n'


def t_error(t):
    raise TypeError("Unknown text '%s'" % (t.value,))

output_file = "data/tokens.txt"
if __name__ == "__main__":
    fileName = sys.argv[1]
    if fileName.endswith(".xyz"):
        tokenList = []
        f = open(fileName, "r")
        Lines = f.readlines()
        for line in Lines:
            line = line.rstrip()
            if line:
                lexer = lex.lex()
                lexer.input(line)
                for tok in iter(lexer.token, None):
                    tokenList.append(tok.value)

        file = open(output_file, 'w')
        file.writelines(str(tokenList))
        file.close()
        output_file = "data/tokens.txt"
        inp_string = str(tokenList)
        result = subprocess.check_output('''swipl -g "consult('src/parser.pl'), program(P,''' + inp_string + ''', []), write(P), halt."''', shell=True)
        result1 =str(result, encoding="UTF-8")
        os.system('''swipl -g "consult('src/evaluator.pl'), eval_program(''' + result1 + ''', Env), write(Env), halt."''')
    else:
        print("Please pass file name with .xyz extension")
