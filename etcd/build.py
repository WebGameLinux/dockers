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
    reader = open('./docker-compose.yml', 'r')
    content = reader.read()
    m = re.subn(envVar, replaceEnvVars, content)
    reader.close()
    writer = open("./build/docker-compose.yml", "w+")
    writer.write(m[0].__str__())
    writer.close()
