XPTemplate priority=personal

XPTinclude
      \ _common/common

XPT main " def main()
#!/usr/bin/python

import os
import sys

def main():
  `cursor^print(sys.argv)
  return 1

if __name__ == '__main__':
  sys.exit(main())
..XPT
