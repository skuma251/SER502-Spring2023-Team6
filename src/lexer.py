import sys


def lexer(filename):
    token_list = []
    reserved_keywords = ['int', 'string', 'bool', 'print']
    control_keywords = ['for', 'while', 'if', 'then', 'else', 'range', 'in']

    token = ""
    with open(filename, 'r') as file:
        lines = file.readlines()
        print(lines)
        for line in lines:
            for i in line:
                if i == '\t':
                    continue
                elif i == ' ':
                    continue
                else:
                    token += i

            each_keyword = ''
            for i in range(len(token)):
                if each_keyword in reserved_keywords:
                    token_list.append(each_keyword)
                    each_keyword = ''
                    token[i:]
                if each_keyword in control_keywords:
                    if each_keyword + token[i:] == "int\n":
                        each_keyword += token[i]
                    token_list.append(each_keyword)
                    each_keyword = ''
                    token[i:]
                if each_keyword not in reserved_keywords:
                    each_keyword += token[i]
                else:
                    continue
            token = ''


    return token_list


if __name__ == "__main__":
    fileName = sys.argv[1]
    if fileName.endswith(".xyz"):
        tokens = lexer(fileName)
        print(tokens)
    else:
        print("Please pass file name with .xyz extension")
