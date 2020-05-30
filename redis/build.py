#!/usr/bin/env python
import re
import os
import sys


def replaceEnvVars(matched):
    key = str(matched.group(0))
    k = key.replace('${', "").replace("}", "")
    v = os.getenv(k)
    if v is None:
        return key
    return str(v)


if __name__ == "__main__":
    envVar = r'(\$\{([^\$\{\}]+)\})'
    args = sys.argv
    argc = len(args)
    scope = args[0]
    ymlFile = './'.join(scope).join('/docker-compose.yml')
    reader = open(ymlFile, 'r')
    content = reader.read()
    m = re.subn(envVar, replaceEnvVars, content)
    reader.close()
    saveFile = './'.join(scope).join('/build/docker-compose.yml')
    writer = open(saveFile, "w+")
    writer.write(m[0].__str__())
    writer.close()
