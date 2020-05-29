#!/usr/bin/env python
import re
import os


def replaceEnvVars(matched):
    key = str(matched.group(0))
    k = key.replace('${', "").replace("}", "")
    v = os.getenv(k)
    if v is None:
        return key
    return str(v)


if __name__ == "__main__":
    envVar = r'(\$\{([^\$\{\}]+)\})'
    fs = open('./docker-compose.yml', 'r')
    content = fs.read()
    m = re.subn(envVar, replaceEnvVars, content)
    fs.close()
    fs1 = open("./build/docker-compose.yml", "w+")
    fs1.write(m[0].__str__())
