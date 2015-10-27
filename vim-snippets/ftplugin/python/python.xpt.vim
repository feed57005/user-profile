XPTemplate priority=personal

XPTinclude
      \ _common/common

XPT main " def main()
#!/usr/bin/env python

import os
import sys


def Main():
    `cursor^print(sys.argv)
    return 1


if __name__ == '__main__':
    sys.exit(Main())
..XPT
